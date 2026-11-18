import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Mercado, Ocupacao } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import CardOcupacao from "@/components/CardOcupacao/CardOcupacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Ocupações" };

const DESTAQUE = [
  { ocupacaoId: 482, titulo: "Cientista de Dados" },
  { ocupacaoId: 414, titulo: "Engenheiro de Dados" },
  { ocupacaoId: 3058, titulo: "Engenheiro de Software" },
  { ocupacaoId: 3050, titulo: "Engenheiro de ML" },
  { ocupacaoId: 2577, titulo: "Analista de Dados" },
  { ocupacaoId: 662, titulo: "Engenheiro de Cloud" },
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
  const mercados = resultados
    ? []
    : await Promise.all(DESTAQUE.map((d) => apiGet<Mercado>(`/mercado/ocupacao/${d.ocupacaoId}`)));

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">
          {termo ? "resultado de busca" : "3.071 ocupações · classificadas por função"}
        </span>
        <h1 className="titulo-pagina">Ocupações</h1>
        <p className="subtitulo-pagina">
          {termo
            ? `Cargos que correspondem a “${termo}”.`
            : "Cada ocupação reúne as habilidades exigidas com nível, o que o mercado paga e para onde a carreira pode ir."}
        </p>
        <SearchBar placeholder="Ex.: analista, engenheiro, suporte…" destino="/ocupacoes" />
      </div>

      {resultados && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Resultados</h2>
            <span className={styles.secaoMeta}>
              {resultados.length} {resultados.length === 1 ? "ocupação" : "ocupações"}
            </span>
          </div>
          {resultados.length === 0 ? (
            <div className="vazio">
              <strong>Nenhuma ocupação encontrada</strong>
              Tente outro termo ou navegue pelos grupos abaixo.
            </div>
          ) : (
            <div className="grid-cards">
              {resultados.slice(0, 30).map((o) => (
                <CardOcupacao key={o.ocupacaoId} ocupacao={o} />
              ))}
            </div>
          )}
        </>
      )}

      {!resultados && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Com dado real de mercado</h2>
            <span className={styles.secaoMeta}>salário mediano por nível</span>
          </div>
          <div className="grid-cards">
            {DESTAQUE.map((d, i) => {
              const m = mercados[i];
              const inicial = m?.salarios?.[0];
              return (
                <CardOcupacao
                  key={d.ocupacaoId}
                  ocupacao={d}
                  extra={m ? `${m.habilidades.length} skills` : undefined}
                  sub={
                    inicial
                      ? `Mediana inicial US$ ${Math.round(inicial.p50).toLocaleString("en-US")} · ${m?.salarios.length} faixas de nível`
                      : "Painel de mercado em breve"
                  }
                />
              );
            })}
          </div>

          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Grupos ocupacionais</h2>
            <span className={styles.secaoMeta}>classificação ISCO · {grupos.length} grupos</span>
          </div>
          <div className={styles.grupos}>
            {grupos.slice(0, 60).map((g) => (
              <Link key={g.grupoId} href={`/ocupacoes/grupo/${g.grupoId}`} className={styles.grupo}>
                <span className={styles.grupoCodigo}>{g.codigo}</span>
                <span className={styles.grupoNome}>{g.nome}</span>
                <span className={styles.seta} aria-hidden="true">→</span>
              </Link>
            ))}
          </div>
          {grupos.length > 60 && (
            <p className={styles.maisGrupos}>
              Mostrando 60 de {grupos.length} grupos — refine com a busca acima.
            </p>
          )}
        </>
      )}
    </div>
  );
}
