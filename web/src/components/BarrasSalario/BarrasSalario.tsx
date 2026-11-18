import type { MercadoSalario } from "@/lib/tipagem";
import BadgeNivel from "@/components/BadgeNivel/BadgeNivel";
import styles from "./BarrasSalario.module.css";

export default function BarrasSalario({ salarios }: { salarios: MercadoSalario[] }) {
  if (salarios.length === 0) return null;

  const max = Math.max(...salarios.map((s) => s.p90));

  return (
    <div className={styles.grade}>
      {salarios.map((s) => (
        <div key={s.nivel} className={styles.linha}>
          <div className={styles.cabecalho}>
            <span className={styles.nome}>
              Nível {s.nivel} · {s.nomeNivel}
            </span>
            <BadgeNivel nivel={s.nivel} />
          </div>
          <div className={styles.barra}>
            <span className={styles.p90} style={{ width: `${(s.p90 / max) * 100}%` }} />
            <span className={styles.p75} style={{ width: `${(s.p75 / max) * 100}%` }} />
            <span className={styles.p50} style={{ width: `${(s.p50 / max) * 100}%` }} />
            <span className={styles.p25} style={{ width: `${(s.p25 / max) * 100}%` }} />
          </div>
          <div className={styles.valores}>
            <span>p25 ${Math.round(s.p25).toLocaleString("en-US")}</span>
            <span className={styles.mediana}>mediana ${Math.round(s.p50).toLocaleString("en-US")}</span>
            <span>p90 ${Math.round(s.p90).toLocaleString("en-US")}</span>
          </div>
          <div className={styles.amostra}>
            {s.amostra.toLocaleString("pt-BR")} vagas com salário informado · {s.moeda}
          </div>
        </div>
      ))}
    </div>
  );
}
