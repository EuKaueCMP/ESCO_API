import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { HabilidadeTermo, SfiaView } from "@/lib/tipagem";
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

export default async function Habilidades({
  searchParams,
}: {
  searchParams: Promise<{ termo?: string }>;
}) {
  const { termo } = await searchParams;

  const raizes = ((await apiGet<SfiaView[]>("/sfia/view")) ?? []).filter(
    (v) => v.profundidade === 1,
  );

  const resultados = termo
    ? ((await apiGet<HabilidadeTermo[]>(`/habilidade/termo/${encodeURIComponent(termo)}`)) ?? [])
    : null;

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">verbete de habilidade · {termo ? "resultado de busca" : "entrada"}</span>
        <h1 className="titulo-pagina">Habilidades</h1>
        <p className="subtitulo-pagina">
          {termo
            ? `Resultados para “${termo}” — a busca ignora acentos e erros de digitação.`
            : "Cada verbete traz o descritor do nível 1 ao 7 e a rubrica para demonstrar domínio."}
        </p>
        <SearchBar destino="/habilidades" />
      </div>

      {resultados && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Resultados</h2>
            <span className={styles.secaoMeta}>
              {resultados.length} {resultados.length === 1 ? "verbete" : "verbetes"}
            </span>
          </div>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nenhum verbete encontrado</strong>
              Tente um termo mais curto, ou o nome em inglês.
            </div>
          ) : (
            <div className="grid-cards">
              {resultados.slice(0, 30).map((h) => (
                <CardHabilidade key={h.habilidadeId} habilidade={h} />
              ))}
            </div>
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
