import Link from "next/link";
import { Briefcase, GraduationCap, Search } from "lucide-react";
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
      <h1 className="titulo-pagina" style={{ paddingTop: 30 }}>Busca inteligente</h1>
      <p className="subtitulo-pagina">
        Acha habilidades e ocupações mesmo com erro de digitação ou sem acento.
      </p>
      <SearchBar placeholder="Ex.: kubernet, cienista de dados, phyton..." />

      {termo && (
        <>
          <h2 className="titulo-secao">
            <Search size={18} />
            {resultados.length} resultado{resultados.length === 1 ? "" : "s"} para “{termo}”
          </h2>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nada encontrado</strong>
              Tente outro termo — a busca tolera erros, mas precisa de alguma semelhança.
            </div>
          ) : (
            <div className={styles.lista}>
              {resultados.map((r) => (
                <Link
                  key={`${r.tipo}-${r.id}`}
                  href={r.tipo === "ocupacao" ? `/ocupacoes/${r.id}` : `/habilidades/${r.id}`}
                  className={`card ${styles.item}`}
                >
                  <span className={r.tipo === "ocupacao" ? styles.iconeOcup : styles.iconeHab}>
                    {r.tipo === "ocupacao" ? <Briefcase size={15} /> : <GraduationCap size={15} />}
                  </span>
                  <span className={styles.nome}>{r.nome}</span>
                  {r.codigo && <span className="codigo-sfia">{r.codigo}</span>}
                  <span className={`chip chip-cinza ${styles.tipo}`}>
                    {r.tipo === "ocupacao" ? "ocupação" : "habilidade"}
                  </span>
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
