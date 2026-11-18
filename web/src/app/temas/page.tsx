import Link from "next/link";
import { Compass } from "lucide-react";
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
      <h1 className="titulo-pagina">Temas &amp; domínios</h1>
      <p className="subtitulo-pagina">
        A curadoria de habilidades em {raizes.length} domínios — de IA e cibersegurança a tecnologia
        sustentável. Abra um tema e desça pelos sub-temas até as habilidades.
      </p>
      <div className="grid-cards">
        {raizes.map((raiz) => {
          const filhos = views.filter((v) => v.slugPai === raiz.caminho);
          return (
            <Link key={raiz.viewId} href={`/temas/${raiz.viewId}`} className={`card ${styles.card}`}>
              <div className="card-titulo">{raiz.nome}</div>
              <p className="card-sub">
                {filhos.length > 0
                  ? `${filhos.length} sub-temas · ${(views.filter((v) => v.caminho.startsWith(raiz.caminho + "/")).length + 1)} páginas`
                  : "Tema raiz"}
              </p>
            </Link>
          );
        })}
      </div>
    </div>
  );
}
