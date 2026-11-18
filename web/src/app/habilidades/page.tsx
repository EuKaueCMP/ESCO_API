import Link from "next/link";
import { apiGet } from "@/lib/api";
import type {
  GrupoOcupacao,
  HabilidadeTermo,
  ResumoClassificacao,
  SfiaView,
} from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import CardHabilidade from "@/components/CardHabilidade/CardHabilidade";
import AreasOcupacao from "@/components/AreasOcupacao/AreasOcupacao";
import Paginacao from "@/components/Paginacao/Paginacao";
import { ITENS_POR_PAGINA, fatiar, hrefCom, paginaValida, totalDePaginas } from "@/lib/paginacao";
import { agruparTemas } from "@/lib/temas";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Habilidades" };

const POPULARES = [
  { codigo: "PROG", nome: "Programação" },
  { codigo: "SQL", nome: "Linguagens de consulta" },
  { codigo: "PYTH", nome: "Python" },
  { codigo: "PROW", nome: "Programação web" },
];

type Filtro = "todas" | "hard" | "soft";

function normalizar(tipo?: string): Filtro {
  if (tipo === "hard" || tipo === "hardskill") return "hard";
  if (tipo === "soft" || tipo === "softskill") return "soft";
  return "todas";
}

export default async function Habilidades({
  searchParams,
}: {
  searchParams: Promise<{ termo?: string; tipo?: string; pagina?: string }>;
}) {
  const { termo, tipo, pagina } = await searchParams;
  const filtro = normalizar(tipo);

  const resumo = await apiGet<ResumoClassificacao>("/habilidade/resumo");

  const exibirTemas = filtro === "todas" && !termo;
  const [views, grupos]: [SfiaView[] | null, GrupoOcupacao[] | null] = exibirTemas
    ? await Promise.all([
        apiGet<SfiaView[]>("/sfia/view"),
        apiGet<GrupoOcupacao[]>("/grupoOcupacao"),
      ])
    : [null, null];
  const gruposTemas = agruparTemas(views ?? []);
  const totalDominios = (views ?? []).filter((v) => v.profundidade === 1).length;

  let resultados: HabilidadeTermo[] | null = null;
  let total = 0;
  let totalPaginas = 1;
  let paginaAtual = 1;

  if (termo) {
    const qs = filtro === "todas" ? "" : `?classificacao=${filtro}`;
    const todos =
      (await apiGet<HabilidadeTermo[]>(
        `/habilidade/termo/${encodeURIComponent(termo)}${qs}`,
      )) ?? [];
    total = todos.length;
    totalPaginas = totalDePaginas(total);
    paginaAtual = paginaValida(pagina, totalPaginas);
    resultados = fatiar(todos, paginaAtual);
  } else if (filtro !== "todas") {
    total = (filtro === "hard" ? resumo?.hardSkill : resumo?.softSkill) ?? 0;
    totalPaginas = totalDePaginas(total);
    paginaAtual = paginaValida(pagina, totalPaginas);
    resultados =
      (await apiGet<HabilidadeTermo[]>(
        `/habilidade/classificacao/${filtro}?limite=${ITENS_POR_PAGINA}&pagina=${paginaAtual}`,
      )) ?? [];
  }

  const tituloLista =
    filtro === "soft" ? "Soft skills" : filtro === "hard" ? "Hard skills" : "Resultados";

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">
          verbete de habilidade · {termo ? "resultado de busca" : "hard & soft skills"}
        </span>
        <h1 className="titulo-pagina">Habilidades</h1>
        <p className="subtitulo-pagina">
          {termo
            ? `Resultados para “${termo}” — a busca ignora acentos e erros de digitação.`
            : "Hard skills são técnicas e ferramentas. Soft skills são competências comportamentais — as duas têm descritor por nível e rubrica."}
        </p>
        <SearchBar destino="/habilidades" />

        <div className={styles.abas} role="tablist" aria-label="Filtrar por tipo de habilidade">
          {(
            [
              { valor: "todas", rotulo: "todas", contagem: resumo?.total },
              { valor: "hard", rotulo: "hard", contagem: resumo?.hardSkill },
              { valor: "soft", rotulo: "soft", contagem: resumo?.softSkill },
            ] as const
          ).map((aba) => {
            const ativa = filtro === aba.valor;
            return (
              <Link
                key={aba.valor}
                href={hrefCom("/habilidades", {
                  termo,
                  tipo: aba.valor === "todas" ? undefined : aba.valor,
                })}
                className={`${styles.aba} ${ativa ? styles.abaAtiva : ""}`}
                role="tab"
                aria-selected={ativa}
              >
                {aba.rotulo}
                <span className={styles.abaContagem}>
                  {aba.contagem !== undefined ? aba.contagem.toLocaleString("pt-BR") : "—"}
                </span>
              </Link>
            );
          })}
        </div>
      </div>

      {resultados && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>{tituloLista}</h2>
            <span className={styles.secaoMeta}>
              {total.toLocaleString("pt-BR")} {total === 1 ? "verbete" : "verbetes"} · página{" "}
              {paginaAtual} de {totalPaginas}
            </span>
          </div>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nenhum verbete encontrado</strong>
              {termo
                ? "Tente um termo mais curto, ou o nome em inglês."
                : "Nenhuma habilidade nesta classificação."}
            </div>
          ) : (
            <div className="grid-cards">
              {resultados.map((h) => (
                <CardHabilidade key={h.habilidadeId} habilidade={h} />
              ))}
            </div>
          )}
          <Paginacao
            paginaAtual={paginaAtual}
            totalPaginas={totalPaginas}
            hrefPagina={(n) =>
              hrefCom("/habilidades", {
                termo,
                tipo: filtro === "todas" ? undefined : filtro,
                pagina: n,
              })
            }
          />
        </>
      )}

      {!resultados && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Navegue por tema</h2>
            <span className={styles.secaoMeta}>
              {gruposTemas.length} macroáreas · {totalDominios} domínios · sub-temas em árvore
            </span>
          </div>
          <div className={styles.macroareas}>
            {gruposTemas.map((grupo) => (
              <section key={grupo.slug} className={styles.macroarea}>
                <div className={styles.macroareaCabeca}>
                  <span className={styles.macroareaTitulo}>{grupo.nome}</span>
                  <span className={styles.macroareaMeta}>
                    {grupo.temas.length} {grupo.temas.length === 1 ? "domínio" : "domínios"}
                  </span>
                  <p className={styles.macroareaDesc}>{grupo.descricao}</p>
                </div>
                <div className={styles.listaTemas}>
                  {grupo.temas.map((r, i) => (
                    <Link key={r.viewId} href={`/temas/${r.viewId}`} className={styles.tema}>
                      <span className={styles.numero}>{String(i + 1).padStart(2, "0")}</span>
                      <span className={styles.temaNome}>{r.nome}</span>
                      <span className={styles.seta} aria-hidden="true">→</span>
                    </Link>
                  ))}
                </div>
              </section>
            ))}
          </div>

          <AreasOcupacao grupos={grupos ?? []} />

          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Atalhos por código</h2>
            <span className={styles.secaoMeta}>códigos SFIA frequentes</span>
          </div>
          <div className={styles.populares}>
            {POPULARES.map((p) => (
              <Link key={p.codigo} href={`/habilidades/codigo/${p.codigo}`} className={styles.popular}>
                <span className="codigo-sfia">{p.codigo}</span>
                <span className={styles.popularNome}>{p.nome}</span>
                <span className={styles.seta} aria-hidden="true">→</span>
              </Link>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
