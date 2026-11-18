import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, SfiaView } from "@/lib/tipagem";
import { agruparTemas } from "@/lib/temas";
import AreasOcupacao from "@/components/AreasOcupacao/AreasOcupacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Temas & domínios" };

export default async function Temas() {
  const [views, grupos] = await Promise.all([
    apiGet<SfiaView[]>("/sfia/view"),
    apiGet<GrupoOcupacao[]>("/grupoOcupacao"),
  ]);
  const listaViews = views ?? [];
  const gruposTemas = agruparTemas(listaViews);
  const totalDominios = listaViews.filter((v) => v.profundidade === 1).length;

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">índice · nível 01</span>
        <h1 className="titulo-pagina">Temas &amp; domínios</h1>
        <p className="subtitulo-pagina">
          A curadoria começa em {totalDominios} domínios organizados em {gruposTemas.length}{" "}
          macroáreas — de IA e cibersegurança a tecnologia sustentável. Cada tema abre em
          sub-temas e termina nas habilidades, uma a uma.
        </p>
      </div>

      <div className={styles.macroareas}>
        {gruposTemas.map((grupo) => (
          <section key={grupo.slug} className={styles.macroarea}>
            <div className={styles.macroareaCabeca}>
              <h2 className={styles.macroareaTitulo}>{grupo.nome}</h2>
              <span className={styles.macroareaMeta}>
                {grupo.temas.length} {grupo.temas.length === 1 ? "domínio" : "domínios"}
              </span>
            </div>
            <p className={styles.macroareaDesc}>{grupo.descricao}</p>
            <div className={styles.indice}>
              {grupo.temas.map((raiz, i) => {
                const descendentes = listaViews.filter((v) =>
                  v.caminho.startsWith(raiz.caminho + "/"),
                );
                return (
                  <Link key={raiz.viewId} href={`/temas/${raiz.viewId}`} className={styles.linha}>
                    <span className={styles.numero}>{String(i + 1).padStart(2, "0")}</span>
                    <span className={styles.nome}>{raiz.nome}</span>
                    <span className={styles.meta}>
                      {descendentes.length}{" "}
                      {descendentes.length === 1 ? "página filha" : "páginas filhas"}
                    </span>
                    <span className={styles.seta} aria-hidden="true">→</span>
                  </Link>
                );
              })}
            </div>
          </section>
        ))}
      </div>

      <AreasOcupacao grupos={grupos ?? []} />
    </div>
  );
}
