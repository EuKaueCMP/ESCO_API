#!/usr/bin/env python3
"""
Testes E2E da RBOSF_API contra uma carga completa dos scripts novos.

O que o script faz, em ordem:
  1. Sobe um PostgreSQL efêmero em Docker (imagem configurável).
  2. Aplica script/CREATE/esco_database_create.sql
     + script/CREATE/esco_database_refactor.sql
     + script/INSERTs/esco_db_refatorado.sql (carga completa, ~12 s).
  3. Reexecuta a carga para validar idempotência (comparando contagens).
  4. Publica a API com `dotnet publish -c Release` em diretório temporário.
  5. Gera um .env próprio (sem tocar no .env do repositório) apontando
     para o Postgres de teste e inicia a API.
  6. Executa a suíte HTTP (metadados, coleções, grupos, ocupações,
     habilidades, buscas, 404s) medindo tempo de resposta e payload.
  7. Imprime tabela de resultados, rankings de performance e insights.
  8. Faz teardown: mata a API e remove o container (--rm).

Uso:
  python3 script/tests/testes_api_e2e.py
  python3 script/tests/testes_api_e2e.py --sem-idempotencia
  python3 script/tests/testes_api_e2e.py --imagem postgres:16 --manter-artefatos

Pré-requisitos: docker e dotnet (net10) disponíveis no PATH.
O Postgres de teste fica publicado apenas em 127.0.0.1 em porta aleatória.
"""

import argparse
import json
import os
import shutil
import socket
import subprocess
import sys
import tempfile
import time
import types
import urllib.error
import urllib.request
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SQL_CREATE = REPO / "script/CREATE/esco_database_create.sql"
SQL_REFACTOR = REPO / "script/CREATE/esco_database_refactor.sql"
SQL_INSERT = REPO / "script/INSERTs/esco_db_refatorado.sql"
API_PROJECT = REPO / "server/RBOSF_API"
BASE = "rbosfapi/v1"

# Contagens esperadas em uma carga limpa (fonte: validação final do SQL)
ESPERADO = {
    "grupos": 619,
    "ocupacoes": 3071,
    "ocupacoes_esco": 3036,
    "ocupacoes_mercado": 35,
    "habilidades": 15221,
    "relacoes_oh": 173226,
    "hierarquias_h": 21566,
    "colecoes": 7,
}

T0 = time.monotonic()


def log(msg: str) -> None:
    print(f"[{time.monotonic() - T0:7.1f}s] {msg}", flush=True)


def porta_livre() -> int:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("127.0.0.1", 0))
        return s.getsockname()[1]


def rodar(cmd, **kwargs) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, **kwargs)


def esperar_container(nome: str, timeout: int = 90) -> None:
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        r = rodar(["docker", "exec", nome, "pg_isready", "-U", "postgres"])
        if r.returncode == 0:
            return
        time.sleep(1)
    raise RuntimeError(f"Postgres de teste não ficou pronto em {timeout}s")


def psql(nome_container: str, sql: str, db: str = "postgres") -> str:
    r = rodar(["docker", "exec", nome_container, "psql", "-U", "postgres",
               "-d", db, "-At", "-v", "ON_ERROR_STOP=1", "-c", sql])
    if r.returncode != 0:
        raise RuntimeError(f"psql falhou: {r.stderr.strip()[:500]}")
    return r.stdout.strip()


def psql_arquivo(nome_container: str, caminho_host: Path, db: str,
                 arquivo_log: Path) -> None:
    r = rodar(["docker", "exec", nome_container, "psql", "-U", "postgres",
               "-d", db, "-v", "ON_ERROR_STOP=1",
               "-f", f"/workspace/{caminho_host.relative_to(REPO)}"])
    saida = r.stdout + r.stderr
    arquivo_log.write_text(saida)
    if r.returncode != 0:
        raise RuntimeError(
            f"SQL falhou ({caminho_host.name}) com código {r.returncode}; log: {arquivo_log}\n"
            f"Últimas linhas:\n{saida[-2000:]}")


def contagens(nome_container: str) -> dict:
    sql = """
    SELECT 'grupos', count(*) FROM esco_dataset.grupo_ocupacao
    UNION ALL SELECT 'ocupacoes', count(*) FROM esco_dataset.ocupacao
    UNION ALL SELECT 'ocupacoes_esco', count(*) FROM esco_dataset.ocupacao
      WHERE uri LIKE 'http://data.europa.eu/esco/occupation/%'
    UNION ALL SELECT 'ocupacoes_mercado', count(*) FROM esco_dataset.ocupacao
      WHERE uri LIKE 'https://nexthire.local/esco/occupation/%'
    UNION ALL SELECT 'habilidades', count(*) FROM esco_dataset.habilidade
    UNION ALL SELECT 'relacoes_oh', count(*) FROM esco_dataset.ocupacao_habilidade
    UNION ALL SELECT 'hierarquias_h', count(*) FROM esco_dataset.hierarquia_habilidade
    UNION ALL SELECT 'colecoes', count(*) FROM esco_dataset.colecao
    """
    saida = psql(nome_container, sql, db="rbosf_db")
    return {k: int(v) for k, v in (linha.split("|") for linha in saida.splitlines())}


class HTTP:
    def __init__(self, base: str):
        self.base = base

    def get(self, path: str, timeout: float = 120.0):
        url = f"{self.base}/{path.lstrip('/')}"
        t = time.monotonic()
        try:
            with urllib.request.urlopen(url, timeout=timeout) as resp:
                corpo = resp.read()
                status = resp.status
        except urllib.error.HTTPError as e:
            corpo = e.read()
            status = e.code
        ms = (time.monotonic() - t) * 1000
        return status, corpo, ms

    def json(self, path: str, timeout: float = 120.0):
        status, corpo, ms = self.get(path, timeout)
        dados = json.loads(corpo.decode("utf-8"))
        return status, dados, corpo, ms


class Resultado:
    def __init__(self, nome: str):
        self.nome = nome
        self.status = "OK"
        self.duracao_ms = 0.0
        self.bytes = 0
        self.http_status = ""
        self.detalhe = ""

    def falha(self, msg: str):
        self.status = "FALHA"
        self.detalhe = msg

    def aviso(self, msg: str):
        self.status = "AVISO"
        self.detalhe = msg


def checar(res: Resultado, condicao: bool, msg_ok: str, msg_erro: str) -> bool:
    if condicao:
        res.detalhe = msg_ok
        return True
    res.falha(msg_erro)
    return False


# ---------------------------------------------------------------------------
# Casos de teste (recebem ctx com estado compartilhado entre testes)
# ---------------------------------------------------------------------------

def t_metadados_status(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/metadados/status")
    res.http_status, res.bytes = s, len(c)
    ok = checar(res, s == 200 and d == ["released", "deprecated"],
                "released/deprecated", f"status={s}, corpo={d}")
    if not ok:
        return
    s2, d2, c2, _ = ctx.http.json(f"{BASE}/metadados/tipo-habilidade")
    s3, d3, c3, _ = ctx.http.json(f"{BASE}/metadados/tipo-conceito")
    s4, d4, c4, _ = ctx.http.json(f"{BASE}/metadados/reutilizacao")
    s5, d5, c5, _ = ctx.http.json(f"{BASE}/metadados/tipo-relacionamento")
    ok2 = (s2 == 200 and d2 == ["conhecimento", "competencia"] and
           s3 == 200 and d3 == ["habilidade", "grupo_habilidade"] and
           s4 == 200 and len(d4) == 4 and
           s5 == 200 and d5 == ["essencial", "opcional"])
    checar(res, ok2, "5 endpoints de metadados OK",
           f"tipos: {d2}/{d3}/{d4}/{d5}")


def t_colecao_listar(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/colecao")
    res.http_status, res.bytes = s, len(c)
    nomes = {i["nome"] for i in d} if isinstance(d, list) else set()
    checar(res, s == 200 and len(d) == 7 and
           "Competências digitais" in nomes and "Ocupações de investigação" in nomes,
           f"{len(d)} coleções", f"status={s}, itens={len(d) if isinstance(d, list) else d}")


def t_colecao_termo(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/colecao/termo/digitais")
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 200 and isinstance(d, list) and len(d) >= 1,
           f"{len(d)} resultado(s)", f"status={s}, corpo={str(d)[:200]}")


def t_grupo_listar(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/grupoOcupacao", timeout=180)
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 200 and len(d) == ESPERADO["grupos"],
           f"{len(d)} grupos", f"status={s}, itens={len(d) if isinstance(d, list) else d}")


def t_grupo_termo(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/grupoOcupacao/termo/software")
    res.http_status, res.bytes = s, len(c)
    alvo = next((g for g in d if g.get("codigo") == "2512"), None) \
        if isinstance(d, list) else None
    if checar(res, s == 200 and isinstance(d, list) and len(d) >= 1 and alvo,
              f"{len(d)} resultado(s); 2512 '{alvo['nome']}'" if alvo else "alvo não achado",
              f"status={s}, itens={len(d) if isinstance(d, list) else d}"):
        ctx.grupo_id = alvo["grupoId"]


def t_grupo_por_id(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/grupoOcupacao/{ctx.grupo_id}")
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 200 and d.get("codigo") == "2512" and d.get("nome"),
           f"2512 '{d.get('nome')}'", f"status={s}, corpo={str(d)[:200]}")


def t_ocupacao_listar(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao", timeout=180)
    res.http_status, res.bytes = s, len(c)
    sem_grupo = [o for o in d if not o.get("nomeGrupoOcupacao")] \
        if isinstance(d, list) else []
    checar(res, s == 200 and len(d) == ESPERADO["ocupacoes"] and not sem_grupo,
           f"{len(d)} ocupações, todas com grupo",
           f"status={s}, itens={len(d) if isinstance(d, list) else d}, sem_grupo={len(sem_grupo)}")


def t_ocupacao_termo_fullstack(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao/termo/full-stack")
    res.http_status, res.bytes = s, len(c)
    alvo = next((o for o in d if o.get("titulo") == "Desenvolvedor Full-stack"), None) \
        if isinstance(d, list) else None
    if checar(res, s == 200 and alvo,
              f"{len(d)} resultado(s); ocupacao_id={alvo['ocupacaoId']}" if alvo else "alvo não achado",
              f"status={s}, itens={len(d) if isinstance(d, list) else d}"):
        ctx.fullstack_id = alvo["ocupacaoId"]
        ctx.fullstack_grupo = alvo["grupoOcupacaoId"]


def t_ocupacao_termo_devops(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao/termo/devops")
    res.http_status, res.bytes = s, len(c)
    tem = isinstance(d, list) and any(o.get("titulo") == "Engenheiro DevOps" for o in d)
    checar(res, s == 200 and tem,
           f"{len(d)} resultado(s), 'Engenheiro DevOps' presente",
           f"status={s}, itens={len(d) if isinstance(d, list) else d}")


def t_ocupacao_por_id(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao/{ctx.fullstack_id}")
    res.http_status, res.bytes = s, len(c)
    alt = d.get("nomesAlternativos")
    checar(res, s == 200 and d.get("titulo") == "Desenvolvedor Full-stack"
           and d.get("grupoOcupacaoId") == ctx.fullstack_grupo
           and (alt is None or isinstance(alt, list)),
           f"Full-stack no grupo {d.get('grupoOcupacaoId')}; altNames={'array' if isinstance(alt, list) else alt!r}",
           f"status={s}, corpo={str(d)[:300]}")


def t_ocupacao_por_grupo(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao/grupo/{ctx.fullstack_grupo}")
    res.http_status, res.bytes = s, len(c)
    ok = s == 200 and isinstance(d, list) and len(d) >= 1
    if not checar(res, ok, f"{len(d)} ocupações no grupo 2512",
                  f"status={s}, itens={len(d) if isinstance(d, list) else d}"):
        if s == 200 and isinstance(d, list) and len(d) == 0:
            res.detalhe = ("BUG provável: GrupoOcupacaoRepository.ListarPorGrupo usa "
                           "grupo.Ocupacao sem Include/lazy load -> lista vazia")
        return
    ids = {o.get("ocupacaoId") for o in d}
    checar(res, ctx.fullstack_id in ids,
           "Full-stack presente no retorno do grupo", "Full-stack ausente no grupo")


def t_ocupacao_habilidades(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao/ocupacaoId/{ctx.fullstack_id}/habilidades",
                                timeout=180)
    res.http_status, res.bytes = s, len(c)
    nomes = {h.get("nome") for h in d} if isinstance(d, list) else set()
    esperadas = {"Docker", "Git", "GitHub", "GraphQL", "Kubernetes",
                 "LGPD", "Node.js", "React", "Terraform"}
    inter = esperadas & nomes
    checar(res, s == 200 and isinstance(d, list) and len(d) >= 100 and len(inter) >= 5,
           f"{len(d)} habilidades; novas: {sorted(inter)}",
           f"status={s}, itens={len(d) if isinstance(d, list) else d}, novas={sorted(inter)}")


def t_habilidade_listar(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/habilidade", timeout=300)
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 200 and len(d) == ESPERADO["habilidades"],
           f"{len(d)} habilidades", f"status={s}, itens={len(d) if isinstance(d, list) else d}")


def t_habilidade_termo_docker(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/habilidade/termo/docker")
    res.http_status, res.bytes = s, len(c)
    alvo = next((h for h in d if h.get("nome") == "Docker"), None) \
        if isinstance(d, list) else None
    if checar(res, s == 200 and alvo,
              f"{len(d)} resultado(s); habilidade_id={alvo['habilidadeId']}" if alvo else "alvo não achado",
              f"status={s}, itens={len(d) if isinstance(d, list) else d}"):
        ctx.docker_id = alvo["habilidadeId"]


def t_habilidade_termo_lgpd(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/habilidade/termo/lgpd")
    res.http_status, res.bytes = s, len(c)
    tem = isinstance(d, list) and any(h.get("nome") == "LGPD" for h in d)
    checar(res, s == 200 and tem,
           f"{len(d)} resultado(s), 'LGPD' presente",
           f"status={s}, itens={len(d) if isinstance(d, list) else d}")


def t_habilidade_por_id(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/habilidade/{ctx.docker_id}")
    res.http_status, res.bytes = s, len(c)
    alt = d.get("nomesAlternativos")
    checar(res, s == 200 and d.get("nome") == "Docker"
           and d.get("tipoConceito") == "habilidade" and d.get("descricao"),
           f"Docker id={d.get('habilidadeId')}; altNames={'array' if isinstance(alt, list) else alt!r}",
           f"status={s}, corpo={str(d)[:300]}")


def t_404_ocupacao(ctx, res):
    s, c, ms = ctx.http.get(f"{BASE}/ocupacao/999999999")
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 404, "404 com mensagem", f"status={s}, corpo={c[:120]!r}")


def t_404_habilidade(ctx, res):
    s, c, ms = ctx.http.get(f"{BASE}/habilidade/999999999")
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 404, "404 com mensagem", f"status={s}, corpo={c[:120]!r}")


def t_404_grupo(ctx, res):
    s, c, ms = ctx.http.get(f"{BASE}/grupoOcupacao/999999999")
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 404, "404 com mensagem", f"status={s}, corpo={c[:120]!r}")


def t_404_colecao(ctx, res):
    s, c, ms = ctx.http.get(f"{BASE}/colecao/999999999")
    res.http_status, res.bytes = s, len(c)
    checar(res, s == 404, "404 com mensagem", f"status={s}, corpo={c[:120]!r}")


def t_busca_sem_resultado(ctx, res):
    s, d, c, ms = ctx.http.json(f"{BASE}/ocupacao/termo/zzzqqqxxxzzz")
    res.http_status, res.bytes = s, len(c)
    if s == 200 and isinstance(d, list) and len(d) == 0:
        res.status = "AVISO"
        res.detalhe = "Retorna 200 [] para busca sem resultado (inconsistente com 404 por id)"
    elif s == 200 and isinstance(d, list) and len(d) > 0:
        res.falha(f"Busca sem sentido retornou {len(d)} itens")
    else:
        res.detalhe = f"status={s} (404), comportamento 404"


def t_busca_sem_termo(ctx, res):
    s, c, ms = ctx.http.get(f"{BASE}/ocupacao/termo/")
    res.http_status, res.bytes = s, len(c)
    checar(res, s in (404, 200), f"status={s}", f"status inesperado {s}")


CASOS = [
    ("Metadados | 5 endpoints", t_metadados_status),
    ("Coleção | listar", t_colecao_listar),
    ("Coleção | termo digitais", t_colecao_termo),
    ("Grupo | listar (619)", t_grupo_listar),
    ("Grupo | termo software", t_grupo_termo),
    ("Grupo | por id 2512", t_grupo_por_id),
    ("Ocupação | listar (3071)", t_ocupacao_listar),
    ("Ocupação | termo full-stack", t_ocupacao_termo_fullstack),
    ("Ocupação | termo devops", t_ocupacao_termo_devops),
    ("Ocupação | por id Full-stack", t_ocupacao_por_id),
    ("Ocupação | por grupo 2512", t_ocupacao_por_grupo),
    ("Ocupação | habilidades Full-stack", t_ocupacao_habilidades),
    ("Habilidade | listar (15221)", t_habilidade_listar),
    ("Habilidade | termo docker", t_habilidade_termo_docker),
    ("Habilidade | termo lgpd", t_habilidade_termo_lgpd),
    ("Habilidade | por id Docker", t_habilidade_por_id),
    ("404 | ocupação inexistente", t_404_ocupacao),
    ("404 | habilidade inexistente", t_404_habilidade),
    ("404 | grupo inexistente", t_404_grupo),
    ("404 | coleção inexistente", t_404_colecao),
    ("Busca | termo sem resultado", t_busca_sem_resultado),
    ("Busca | termo vazio", t_busca_sem_termo),
]


def imprimir_resultados(resultados, fases):
    print("\n" + "=" * 100)
    print("RESULTADOS DOS TESTES")
    print("=" * 100)
    print(f"{'TESTE':44s} {'STATUS':7s} {'HTTP':>5s} {'TEMPO(ms)':>10s} {'PAYLOAD':>9s}  DETALHE")
    n_ok = n_avisos = n_falhas = 0
    for r in resultados:
        print(f"{r.nome:44s} {r.status:7s} {r.http_status!s:>5s} {r.duracao_ms:10.0f} "
              f"{r.bytes / 1024:8.1f}KB  {r.detalhe[:60]}")
        if r.status == "OK":
            n_ok += 1
        elif r.status == "AVISO":
            n_avisos += 1
        else:
            n_falhas += 1
    print("-" * 100)
    print(f"OK={n_ok}  AVISOS={n_avisos}  FALHAS={n_falhas}")

    print("\n" + "=" * 100)
    print("FASES DE INFRA (tempo)")
    print("=" * 100)
    for nome, segundos in fases:
        print(f"  {nome:48s} {segundos:7.1f}s")

    print("\n" + "=" * 100)
    print("INSIGHTS DE PERFORMANCE (top 8 por tempo)")
    print("=" * 100)
    por_tempo = sorted(resultados, key=lambda r: r.duracao_ms, reverse=True)[:8]
    for r in por_tempo:
        print(f"  {r.nome:44s} {r.duracao_ms:9.0f}ms  {r.bytes / 1024:8.1f}KB")
    print("\nINSIGHTS DE PAYLOAD (top 5 por tamanho)")
    for r in sorted(resultados, key=lambda r: r.bytes, reverse=True)[:5]:
        print(f"  {r.nome:44s} {r.bytes / 1024:9.1f}KB")

    falhas = [r for r in resultados if r.status == "FALHA"]
    avisos = [r for r in resultados if r.status == "AVISO"]
    if falhas or avisos:
        print("\n" + "=" * 100)
        print("PONTOS DE ATENÇÃO (para o backlog da API)")
        print("=" * 100)
        for r in falhas + avisos:
            print(f"  [{r.status}] {r.nome}: {r.detalhe}")
    print("=" * 100)
    return n_falhas


def main():
    ap = argparse.ArgumentParser(description="E2E RBOSF_API + carga SQL nova")
    ap.add_argument("--imagem", default="postgres:latest")
    ap.add_argument("--pg-porta", type=int, default=None)
    ap.add_argument("--api-porta", type=int, default=None)
    ap.add_argument("--sem-idempotencia", action="store_true")
    ap.add_argument("--manter-artefatos", action="store_true",
                    help="não remove o diretório temporário do publish")
    args = ap.parse_args()

    if shutil.which("docker") is None:
        sys.exit("ERRO: docker não encontrado no PATH")
    if shutil.which("dotnet") is None:
        sys.exit("ERRO: dotnet não encontrado no PATH (necessário .NET 10)")

    pg_porta = args.pg_porta or porta_livre()
    api_porta = args.api_porta or porta_livre()
    container = f"rbosf-api-tests-{os.getpid()}"
    tmp = Path(tempfile.mkdtemp(prefix="rbosf_api_tests_"))
    api_proc = None
    fases = []

    def fase(nome, segundos):
        fases.append((nome, segundos))
        log(f"{nome}: {segundos:.1f}s")

    try:
        # 1. subir Postgres
        log(f"Subindo {args.imagem} em 127.0.0.1:{pg_porta} (container {container})")
        t = time.monotonic()
        r = rodar(["docker", "run", "--rm", "-d", "--name", container,
                   "-e", "POSTGRES_PASSWORD=postgres",
                   "-p", f"127.0.0.1:{pg_porta}:5432",
                   "-v", f"{REPO}:/workspace", args.imagem])
        if r.returncode != 0:
            sys.exit(f"ERRO ao subir Postgres:\n{r.stderr}")
        esperar_container(container)
        fase("Postgres pronto", time.monotonic() - t)

        # 2. carga SQL
        log("Aplicando esco_database_create.sql")
        t = time.monotonic()
        psql_arquivo(container, SQL_CREATE, "postgres", tmp / "log_create.sql")
        fase("CREATE (schema base)", time.monotonic() - t)

        log("Aplicando esco_database_refactor.sql")
        t = time.monotonic()
        psql_arquivo(container, SQL_REFACTOR, "rbosf_db", tmp / "log_refactor.sql")
        fase("CREATE (tabelas de vínculo)", time.monotonic() - t)

        log("Aplicando esco_db_refatorado.sql (carga completa)...")
        t = time.monotonic()
        psql_arquivo(container, SQL_INSERT, "rbosf_db", tmp / "log_insert.sql")
        fase("INSERT (carga completa)", time.monotonic() - t)

        log("Validando contagens da carga")
        cnt = contagens(container)
        divergentes = {k: (cnt[k], v) for k, v in ESPERADO.items() if cnt[k] != v}
        if divergentes:
            sys.exit(f"ERRO: contagens divergentes do esperado: {divergentes}")
        log(f"Contagens OK: {cnt}")

        # 3. idempotência
        if not args.sem_idempotencia:
            log("Reexecutando carga para validar idempotência...")
            t = time.monotonic()
            psql_arquivo(container, SQL_INSERT, "rbosf_db", tmp / "log_insert2.sql")
            fase("INSERT (idempotência)", time.monotonic() - t)
            cnt2 = contagens(container)
            if cnt2 != cnt:
                sys.exit(f"ERRO: carga não idempotente.\nantes={cnt}\ndepois={cnt2}")
            log("Idempotência OK (contagens idênticas)")

        # 4. publicar API
        publish_dir = tmp / "publish"
        log("Publicando API (dotnet publish -c Release)...")
        t = time.monotonic()
        r = rodar(["dotnet", "publish", str(API_PROJECT), "-c", "Release",
                   "-o", str(publish_dir), "--nologo"])
        (tmp / "log_publish.txt").write_text(r.stdout + r.stderr)
        if r.returncode != 0:
            sys.exit(f"ERRO no dotnet publish; log: {tmp / 'log_publish.txt'}")
        fase("dotnet publish", time.monotonic() - t)

        # 5. .env + start
        (publish_dir / ".env").write_text(
            f'DefaultConnection="Host=127.0.0.1;Port={pg_porta};'
            f'Database=rbosf_db;Username=postgres;Password=postgres"\n')
        env = dict(os.environ)
        env["ASPNETCORE_ENVIRONMENT"] = "Development"
        env["ASPNETCORE_URLS"] = f"http://127.0.0.1:{api_porta}"
        log(f"Iniciando API em http://127.0.0.1:{api_porta}")
        log_api = open(tmp / "log_api.txt", "w")
        t = time.monotonic()
        api_proc = subprocess.Popen(
            ["dotnet", "RBOSF_API.dll"], cwd=publish_dir, env=env,
            stdout=log_api, stderr=subprocess.STDOUT)
        http = HTTP(f"http://127.0.0.1:{api_porta}")
        deadline = time.monotonic() + 120
        while True:
            if api_proc.poll() is not None:
                sys.exit(f"ERRO: API morreu no boot; log: {tmp / 'log_api.txt'}")
            try:
                s, _, _ = http.get(f"{BASE}/metadados/status", timeout=5)
                if s == 200:
                    break
            except Exception:
                pass
            if time.monotonic() > deadline:
                sys.exit(f"ERRO: API não respondeu em 120s; log: {tmp / 'log_api.txt'}")
            time.sleep(1)
        fase("API boot + readiness", time.monotonic() - t)
        log(f"API pronta em {http.base}")

        # 6. suíte
        ctx = types.SimpleNamespace(http=http, grupo_id=None, fullstack_id=None,
                                    fullstack_grupo=None, docker_id=None)
        resultados = []
        for nome, fn in CASOS:
            res = Resultado(nome)
            t = time.monotonic()
            try:
                fn(ctx, res)
            except Exception as e:
                res.falha(f"exceção: {type(e).__name__}: {e}")
            res.duracao_ms = (time.monotonic() - t) * 1000
            resultados.append(res)
            marcador = {"OK": "✓", "AVISO": "!", "FALHA": "✗"}[res.status]
            log(f"{marcador} {nome} ({res.duracao_ms:.0f}ms) {res.detalhe[:70]}")

        # 7. relatório
        n_falhas = imprimir_resultados(resultados, fases)
        if args.manter_artefatos:
            print(f"\nArtefatos mantidos em: {tmp}")
            log_api.close()
            raise SystemExit(1 if n_falhas else 0)

    finally:
        if api_proc is not None and api_proc.poll() is None:
            api_proc.terminate()
            try:
                api_proc.wait(timeout=10)
            except subprocess.TimeoutExpired:
                api_proc.kill()
        if not args.manter_artefatos:
            rodar(["docker", "rm", "-f", container])
            shutil.rmtree(tmp, ignore_errors=True)

    raise SystemExit(1 if n_falhas else 0)


if __name__ == "__main__":
    main()
