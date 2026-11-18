import Link from "next/link";
import { Briefcase, Search, TrendingUp } from "lucide-react";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Ocupacao, Mercado } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import CardOcupacao from "@/components/CardOcupacao/CardOcupacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Ocupações" };

const COM_MERCADO = [
  { ocupacaoId: 482, titulo: "Cientista de Dados" },
  { ocupacaoId: 414, titulo: "Engenheiro de Dados" },
  { ocupacaoId: 3058, titulo: "Engenheiro de Software" },
  { ocupacaoId: 3050, titulo: "Engenheiro de Machine Learning" },
  { ocupacaoId: 2577, titulo: "Analista de Dados" },
  { ocupacaoId: 3022, titulo: "Analista de Negócios de TI" },
  { ocupacaoId: 662, titulo: "Engenheiro de Computação na Cloud" },
];

export default async function Ocupacoes({
  searchParams,
}: {
  searchParams: Promise<{ termo?: string }>;
}) {
  const { termo } = await searchParams;

  const resultados = termo
    ? ((await apiGet<Ocupacao[]>(`/ocupacao/termo/${encodeURIComponent(termo)}`)) ?? [])
    : null;

  const grupos = resultados ? [] : ((await apiGet<GrupoOcupacao[]>("/grupoOcupacao")) ?? []);
  const destaque = resultados ? [] : COM_MERCADO;

  return (
    <div className="container">
      <h1 className="titulo-pagina">Ocupações</h1>
      <p className="subtitulo-pagina">
        {termo
          ? `Resultados para “${termo}”`
          : "3.071 ocupações — busque pelo cargo ou comece pelas com dado real de mercado"}
      </p>
      <SearchBar placeholder="Buscar ocupação por cargo (ex.: analista, engenheiro)..." destino="/ocupacoes" />

      {resultados && (
        <>
          <h2 className="titulo-secao">
            <Search size={18} />
            {resultados.length} resultado{resultados.length === 1 ? "" : "s"}
          </h2>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nada encontrado</strong>
              Tente um termo mais curto.
            </div>
          ) : (
            <div className="grid-cards">
              {resultados.slice(0, 24).map((o) => (
                <CardOcupacao key={o.ocupacaoId} ocupacao={o} />
              ))}
            </div>
          )}
        </>
      )}

      {!resultados && (
        <>
          <h2 className="titulo-secao">
            <TrendingUp size={18} />
            Com dado real de mercado
          </h2>
          <div className="grid-cards">
            {destaque.map((o) => (
              <CardOcupacao key={o.ocupacaoId} ocupacao={o} extra="mercado" />
            ))}
          </div>

          <h2 className="titulo-secao">
            <Briefcase size={18} />
            Todos os grupos ocupacionais
          </h2>
          <div className={styles.grupos}>
            {grupos.slice(0, 120).map((g) => (
              <LinkGrupo key={g.grupoId} grupo={g} />
            ))}
          </div>
          {grupos.length > 120 && (
            <p className={styles.maisGrupos}>
              Mostrando 120 de {grupos.length} grupos — refine com a busca acima.
            </p>
          )}
        </>
      )}
    </div>
  );
}

function LinkGrupo({ grupo }: { grupo: GrupoOcupacao }) {
  return (
    <Link href={`/ocupacoes/grupo/${grupo.grupoId}`} className={`card ${styles.grupo}`}>

      <span className={styles.grupoCodigo}>{grupo.codigo}</span>
      <span className={styles.grupoNome}>{grupo.nome}</span>
    </Link>
  );
}
