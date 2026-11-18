import Link from "next/link";
import ExploradorEndpoints from "@/components/ExploradorEndpoints/ExploradorEndpoints";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Documentação da API" };

const base = process.env.API_BASE_URL ?? "http://localhost:5116/escoapi/v1";
const raiz = base.replace(/\/escoapi\/v1\/?$/, "");
const swagger = `${raiz}/swagger`;

const GRUPOS: { titulo: string; rotas: { rota: string; desc: string }[] }[] = [
  {
    titulo: "Busca",
    rotas: [
      { rota: "GET /busca?termo={termo}", desc: "Busca única em habilidades e ocupações, tolerante a acentos e erros de digitação." },
    ],
  },
  {
    titulo: "Habilidades",
    rotas: [
      { rota: "GET /habilidade", desc: "Lista o acervo completo de habilidades." },
      { rota: "GET /habilidade/resumo", desc: "Totais de hard skill, soft skill, verbetes e agrupamentos." },
      { rota: "GET /habilidade/{id}", desc: "Detalhe de uma habilidade." },
      { rota: "GET /habilidade/codigo/{codigo}", desc: "Habilidades por código SFIA (ex.: PROG)." },
      { rota: "GET /habilidade/termo/{termo}?classificacao=hard|soft", desc: "Busca por termo, com filtro opcional de classificação." },
      { rota: "GET /habilidade/classificacao/{hard|soft}?limite=24&pagina=1", desc: "Lista paginada por classificação, ordenada por relevância." },
      { rota: "GET /habilidade/{id}/niveis", desc: "Descritores de nível 1–7 com rubrica de demonstração." },
      { rota: "GET /habilidade/niveis", desc: "Os sete níveis com nome e descrição em português." },
    ],
  },
  {
    titulo: "Ocupações",
    rotas: [
      { rota: "GET /ocupacao", desc: "Todas as ocupações, ordenadas por relevância." },
      { rota: "GET /ocupacao/termo/{termo}", desc: "Busca textual e por similaridade no título." },
      { rota: "GET /ocupacao/{id}", desc: "Detalhe da ocupação, incluindo grupo ISCO." },
      { rota: "GET /ocupacao/grupo/{grupoId}", desc: "Ocupações de um grupo ocupacional." },
      { rota: "GET /ocupacao/ocupacaoId/{id}/habilidades", desc: "Habilidades exigidas, com peso, nível e classificação hard/soft." },
      { rota: "GET /ocupacao/ocupacaoId/{id}/trilha", desc: "Próximas ocupações na carreira e habilidades faltantes." },
    ],
  },
  {
    titulo: "Temas e níveis SFIA",
    rotas: [
      { rota: "GET /sfia/view", desc: "Árvore de temas (views) com profundidade e caminho." },
      { rota: "GET /sfia/view/{viewId}", desc: "Tema com sub-temas e habilidades." },
      { rota: "GET /sfia/atributo", desc: "Os 16 atributos comportamentais por nível." },
      { rota: "GET /sfia/atributo/{slug}", desc: "Atributo com descritores de 1 a 7." },
    ],
  },
  {
    titulo: "Mercado, grupos e metadados",
    rotas: [
      { rota: "GET /mercado/ocupacao/{id}", desc: "Faixas salariais por nível e skills mais pedidas em vagas reais." },
      { rota: "GET /grupoOcupacao", desc: "Grupos ocupacionais (classificação ISCO)." },
      { rota: "GET /grupoOcupacao/{grupoId}", desc: "Detalhe de um grupo." },
      { rota: "GET /metadados/tipo-habilidade", desc: "Valores de enumeração usados nos filtros (e assim por diante)." },
    ],
  },
];

const EXEMPLO_CURL = `curl "${base}/habilidade/resumo"

curl "${base}/habilidade/classificacao/soft?limite=10&pagina=1"

curl "${base}/ocupacao/termo/cientista"`;

const EXEMPLO_JS = `const base = "${base}";

const resumo = await fetch(\`\${base}/habilidade/resumo\`).then((r) => r.json());
// { hardSkill: 14636, softSkill: 63, total: 14699, grupos: 661 }

const soft = await fetch(
  \`\${base}/habilidade/classificacao/soft?limite=10&pagina=1\`,
).then((r) => r.json());`;

const EXEMPLO_PY = `import requests

base = "${base}"

r = requests.get(f"{base}/habilidade/classificacao/hard", params={"limite": 10, "pagina": 1})
r.raise_for_status()
habilidades = r.json()

for h in habilidades:
    print(h["codigo"], h["nome"], h["classificacaoHabilidade"])`;

export default function Docs() {
  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">integração · api pública · v1</span>
        <h1 className="titulo-pagina">Documentação</h1>
        <p className="subtitulo-pagina">
          A API do RBOSF é REST, responde em JSON e não exige autenticação. Todos os
          endpoints são <code className={styles.inline}>GET</code> e ficam sob{" "}
          <code className={styles.inline}>{base}</code>.
        </p>
      </div>

      <div className={styles.destaques}>
        <div className={styles.destaque}>
          <span className="rotulo">base url</span>
          <code className={styles.url}>{base}</code>
          <span className={styles.destaqueNota}>Produção e desenvolvimento usam o mesmo contrato.</span>
        </div>
        <div className={styles.destaque}>
          <span className="rotulo">referência interativa</span>
          <a href={swagger} className={styles.botaoSwagger} target="_blank" rel="noreferrer">
            Abrir Swagger UI <span aria-hidden="true">↗</span>
          </a>
          <span className={styles.destaqueNota}>Tente cada endpoint direto no navegador.</span>
        </div>
      </div>

      <section className={styles.secao}>
        <span className={styles.numero}>01</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Comece em uma chamada</h2>
          <p className={styles.texto}>
            O resumo do acervo é o jeito mais rápido de confirmar que você está falando com a
            API certa. Não há chave, token ou cabeçalho obrigatório — só a URL.
          </p>
          <pre className={styles.codigo}><code>{EXEMPLO_CURL}</code></pre>
        </div>
      </section>

      <section className={styles.secao}>
        <span className={styles.numero}>02</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Autenticação, CORS e limites</h2>
          <p className={styles.texto}>
            Não há autenticação nesta versão. O CORS está liberado para consumo direto do
            navegador. O único limite explícito é o da listagem por classificação: de 1 a 200
            itens por página (<code className={styles.inline}>limite</code>, padrão 60).
            Faça requisições com moderação e cacheie o que não muda com frequência — o acervo
            é grande e quase todo estável.
          </p>
        </div>
      </section>

      <section className={styles.secao}>
        <span className={styles.numero}>03</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Como o acervo está organizado</h2>
          <dl className={styles.conceitos}>
            <div>
              <dt>Habilidade</dt>
              <dd>
                Competência ou conhecimento com descritor por nível. Pode ser{" "}
                <strong>hard skill</strong> (técnica, ferramenta, domínio) ou{" "}
                <strong>soft skill</strong> (comportamental). Agrupamentos não recebem
                classificação.
              </dd>
            </div>
            <div>
              <dt>Ocupação</dt>
              <dd>
                Cargo com habilidades essenciais e complementares, cada uma com peso e nível
                esperado. Ocupações pertencem a um grupo ISCO e podem ter trilha de progressão.
              </dd>
            </div>
            <div>
              <dt>Tema (view SFIA)</dt>
              <dd>
                Árvore de domínios que organiza habilidades em 12 raízes e seus sub-temas.
                Cada tema aponta para as habilidades curadas que contém.
              </dd>
            </div>
            <div>
              <dt>Nível e atributo</dt>
              <dd>
                Sete níveis de proficiência (1 Seguir → 7 Definir estratégia) e 16 atributos
                comportamentais, ambos com descritores oficiais ou sintetizados.
              </dd>
            </div>
            <div>
              <dt>Mercado</dt>
              <dd>
                Faixas salariais por nível (p25, p50, p75) e habilidades mais pedidas,
                derivadas de vagas reais.
              </dd>
            </div>
          </dl>
        </div>
      </section>

      <section className={styles.secao}>
        <span className={styles.numero}>04</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Endpoints</h2>
          <p className={styles.texto}>
            Todos os caminhos abaixo são relativos à base. Respostas em lista não são
            paginadas, exceto quando indicado; use os filtros para reduzir o volume.
          </p>
          <ExploradorEndpoints grupos={GRUPOS} />
        </div>
      </section>

      <section className={styles.secao}>
        <span className={styles.numero}>05</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Paginação e filtros</h2>
          <p className={styles.texto}>
            Por enquanto a paginação de servidor existe em{" "}
            <code className={styles.inline}>/habilidade/classificacao/{"{tipo}"}</code>. Combine{" "}
            <code className={styles.inline}>limite</code> e{" "}
            <code className={styles.inline}>pagina</code> (base 1). Para saber quantas
            páginas existem, consulte <code className={styles.inline}>/habilidade/resumo</code>{" "}
            e divida o total pelo limite. Termos e classificações inválidas retornam{" "}
            <code className={styles.inline}>404</code>.
          </p>
          <p className={styles.texto}>
            A classificação aceita <code className={styles.inline}>hard</code>,{" "}
            <code className={styles.inline}>hardskill</code>, <code className={styles.inline}>soft</code>{" "}
            e <code className={styles.inline}>softskill</code>; enums são serializados como
            texto em minúsculas (ex.: <code className={styles.inline}>softskill</code>,{" "}
            <code className={styles.inline}>especifico_ocupacao</code>).
          </p>
        </div>
      </section>

      <section className={styles.secao}>
        <span className={styles.numero}>06</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Exemplos</h2>
          <h3 className={styles.subtituloCodigo}>JavaScript</h3>
          <pre className={styles.codigo}><code>{EXEMPLO_JS}</code></pre>
          <h3 className={styles.subtituloCodigo}>Python</h3>
          <pre className={styles.codigo}><code>{EXEMPLO_PY}</code></pre>
        </div>
      </section>

      <section className={styles.secao}>
        <span className={styles.numero}>07</span>
        <div className={styles.corpo}>
          <h2 className={styles.titulo}>Erros e quando acontecem</h2>
          <ul className={styles.erros}>
            <li>
              <code>404</code> — recurso inexistente, termo vazio, classificação inválida ou
              ocupação não encontrada. O corpo traz a mensagem em texto.
            </li>
            <li>
              <code>500</code> — falha inesperada no servidor. Repita a chamada; se persistir,
              registre a URL e o horário.
            </li>
          </ul>
          <p className={styles.texto}>
            Precisa experimentar sem escrever código?{" "}
            <a href={swagger} className={styles.link} target="_blank" rel="noreferrer">
              Abra o Swagger UI
            </a>{" "}
            ou explore o acervo pelo{" "}
            <Link href="/" className={styles.link}>site do RBOSF</Link>.
          </p>
        </div>
      </section>
    </div>
  );
}
