import Link from "next/link";
import { Compass, GraduationCap, Search } from "lucide-react";
import { apiGet } from "@/lib/api";
import type { HabilidadeTermo, SfiaView } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import CardHabilidade from "@/components/CardHabilidade/CardHabilidade";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Habilidades" };

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
      <h1 className="titulo-pagina">Habilidades</h1>
      <p className="subtitulo-pagina">
        {termo
          ? `Resultados para “${termo}” — a busca ignora acentos e erros de digitação`
          : "Busque pelo nome ou navegue pelos temas curados"}
      </p>
      <SearchBar placeholder="Buscar habilidade por nome..." destino="/habilidades" />

      {resultados && (
        <>
          <h2 className="titulo-secao">
            <Search size={18} />
            {resultados.length} resultado{resultados.length === 1 ? "" : "s"}
          </h2>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nada encontrado</strong>
              Tente um termo mais curto ou diferente.
            </div>
          ) : (
            <div className="grid-cards">
              {resultados.slice(0, 24).map((h) => (
                <CardHabilidade key={h.habilidadeId} habilidade={h} />
              ))}
            </div>
          )}
        </>
      )}

      {!resultados && (
        <>
          <h2 className="titulo-secao">
            <Compass size={18} />
            Navegue por tema
          </h2>
          <div className="grid-cards">
            {raizes.map((r) => (
              <Link key={r.viewId} href={`/temas/${r.viewId}`} className="card">
                <div className="card-titulo">{r.nome}</div>
                <p className="card-sub">Explorar tema</p>
              </Link>
            ))}
          </div>
          <h2 className="titulo-secao">
            <GraduationCap size={18} />
            Populares no mercado
          </h2>
          <div className={styles.populares}>
            {["PROG", "SQL", "PYTH", "PROW"].map((c) => (
              <Link key={c} href={`/habilidades/codigo/${c}`} className="card">
                <span className="codigo-sfia">{c}</span>
                <p className="card-sub">Ver descritores por nível</p>
              </Link>
            ))}
          </div>
        </>
      )}
    </div>
  );
}
