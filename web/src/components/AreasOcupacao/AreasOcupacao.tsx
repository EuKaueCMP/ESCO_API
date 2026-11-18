import Link from "next/link";
import type { GrupoOcupacao } from "@/lib/tipagem";
import { agruparAreas } from "@/lib/areas";
import styles from "./AreasOcupacao.module.css";

export default function AreasOcupacao({ grupos }: { grupos: GrupoOcupacao[] }) {
  const areas = agruparAreas(grupos);
  if (areas.length === 0) return null;

  return (
    <section>
      <div className={styles.cabecalho}>
        <h2 className={styles.titulo}>Áreas de ocupação</h2>
        <span className={styles.meta}>
          {areas.length} áreas · grupos ISCO do banco
        </span>
        <Link href="/ocupacoes" className={styles.link}>
          ver todas →
        </Link>
      </div>

      <div className={styles.areas}>
        {areas.map((area) => (
          <section key={area.slug} className={styles.area}>
            <div className={styles.areaCabeca}>
              <h3 className={styles.areaTitulo}>{area.nome}</h3>
              <span className={styles.areaMeta}>
                {area.grupos.length} {area.grupos.length === 1 ? "grupo" : "grupos"}
              </span>
              <p className={styles.areaDesc}>{area.descricao}</p>
            </div>
            <div className={styles.grupos}>
              {area.grupos.map((grupo) => (
                <Link
                  key={grupo.grupoId}
                  href={`/ocupacoes/grupo/${grupo.grupoId}`}
                  className={styles.grupo}
                >
                  <span className={styles.codigo}>{grupo.codigo}</span>
                  <span className={styles.nome}>{grupo.nome}</span>
                  <span className={styles.seta} aria-hidden="true">→</span>
                </Link>
              ))}
            </div>
          </section>
        ))}
      </div>
    </section>
  );
}
