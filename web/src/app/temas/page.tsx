import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { SfiaView } from "@/lib/tipagem";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Temas & domínios" };

export default async function Temas() {
  const views = (await apiGet<SfiaView[]>("/sfia/view")) ?? [];
  const raizes = views.filter((v) => v.profundidade === 1);

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <span className="rotulo">índice · nível 01</span>
        <h1 className="titulo-pagina">Temas &amp; domínios</h1>
        <p className="subtitulo-pagina">
          A curadoria começa em {raizes.length} domínios — de IA e cibersegurança a tecnologia
          sustentável. Cada tema abre em sub-temas e termina nas habilidades, uma a uma.
        </p>
      </div>

      <div className={styles.indice}>
        {raizes.map((raiz, i) => {
          const descendentes = views.filter((v) => v.caminho.startsWith(raiz.caminho + "/"));
          return (
            <Link key={raiz.viewId} href={`/temas/${raiz.viewId}`} className={styles.linha}>
              <span className={styles.numero}>{String(i + 1).padStart(2, "0")}</span>
              <span className={styles.nome}>{raiz.nome}</span>
              <span className={styles.meta}>
                {descendentes.length} {descendentes.length === 1 ? "página filha" : "páginas filhas"}
              </span>
              <span className={styles.seta} aria-hidden="true">→</span>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
