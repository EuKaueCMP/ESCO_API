import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { HabilidadeTermo, ResumoClassificacao, SfiaView } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import CardHabilidade from "@/components/CardHabilidade/CardHabilidade";
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

function urlBase(termo: string | undefined, filtro: Filtro) {
  const params = new URLSearchParams();
  if (termo) params.set("termo", termo);
  if (filtro !== "todas") params.set("tipo", filtro);
  const qs = params.toString();
  return `/habilidades${qs ? `?${qs}` : ""}`;
}

export default async function Habilidades({
  searchParams,
}: {
  searchParams: Promise<{ termo?: string; tipo?: string }>;
}) {
  const { termo, tipo } = await searchParams;
  const filtro = normalizar(tipo);

  const resumo = await apiGet<ResumoClassificacao>("/habilidade/resumo");

  const raizes =
    filtro === "todas" && !termo
      ? ((await apiGet<SfiaView[]>("/sfia/view")) ?? []).filter((v) => v.profundidade === 1)
      : [];

  let resultados: HabilidadeTermo[] | null = null;
  if (termo) {
    const qs = filtro === "todas" ? "" : `?classificacao=${filtro}`;
    resultados =
      (await apiGet<HabilidadeTermo[]>(
        `/habilidade/termo/${encodeURIComponent(termo)}${qs}`,
      )) ?? [];
  } else if (filtro !== "todas") {
    resultados =
      (await apiGet<HabilidadeTermo[]>(`/habilidade/classificacao/${filtro}?limite=60`)) ?? [];
  }

  const totalFiltro =
    filtro === "hard" ? resumo?.hardSkill : filtro === "soft" ? resumo?.softSkill : undefined;

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
                href={urlBase(termo, aba.valor)}
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
            <h2 className={styles.secaoTitulo}>
              {termo ? "Resultados" : filtro === "soft" ? "Soft skills" : "Hard skills"}
            </h2>
            <span className={styles.secaoMeta}>
              {termo
                ? `${resultados.length} ${resultados.length === 1 ? "verbete" : "verbetes"}`
                : `${resultados.length} de ${(totalFiltro ?? 0).toLocaleString("pt-BR")} · mais relevantes`}
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
              {resultados.slice(0, termo ? 30 : 60).map((h) => (
                <CardHabilidade key={h.habilidadeId} habilidade={h} />
              ))}
            </div>
          )}
          {!termo && filtro !== "todas" && (
            <p className={styles.nota}>
              Exibindo as {resultados.length} mais relevantes. Use a busca para encontrar uma
              habilidade específica dentro de {filtro === "soft" ? "soft" : "hard"} skills.
            </p>
          )}
        </>
      )}

      {!resultados && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Navegue por tema</h2>
            <span className={styles.secaoMeta}>12 domínios · sub-temas em árvore</span>
          </div>
          <div className={styles.temas}>
            {raizes.map((r, i) => (
              <Link key={r.viewId} href={`/temas/${r.viewId}`} className={styles.tema}>
                <span className={styles.numero}>{String(i + 1).padStart(2, "0")}</span>
                <span className={styles.temaNome}>{r.nome}</span>
                <span className={styles.seta} aria-hidden="true">→</span>
              </Link>
            ))}
          </div>

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
