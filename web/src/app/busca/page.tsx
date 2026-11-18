import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { ResultadoBusca } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Busca" };

export default async function Busca({
  searchParams,
}: {
  searchParams: Promise<{ termo?: string }>;
}) {
  const { termo } = await searchParams;
  const resultados = termo
    ? (await apiGet<ResultadoBusca[]>(`/busca?termo=${encodeURIComponent(termo)}`)) ?? []
    : [];

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">busca única · habilidades e ocupações</span>
        <h1 className="titulo-pagina">Busca inteligente</h1>
        <p className="subtitulo-pagina">
          Ignora acentos, maiúsculas e erros de digitação — “kubernet” encontra Kubernetes.
        </p>
        <SearchBar />
      </div>

      {termo && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>“{termo}”</h2>
            <span className={styles.secaoMeta}>
              {resultados.length} {resultados.length === 1 ? "resultado" : "resultados"}
            </span>
          </div>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nada encontrado</strong>
              Tente um termo mais curto ou o nome em inglês; a busca tolera erros, mas precisa de alguma semelhança.
            </div>
          ) : (
            <div className={styles.lista}>
              {resultados.map((r) => (
                <Link
                  key={`${r.tipo}-${r.id}`}
                  href={r.tipo === "ocupacao" ? `/ocupacoes/${r.id}` : `/habilidades/${r.id}`}
                  className={`card ${styles.item}`}
                >
                  <span className={styles.tipo}>{r.tipo === "ocupacao" ? "ocupa" : "habil"}</span>
                  <span className={styles.nome}>{r.nome}</span>
                  {r.codigo && <span className="codigo-sfia">{r.codigo}</span>}
                  <span className={styles.score}>{Math.round(r.score * 100)}%</span>
                </Link>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}
