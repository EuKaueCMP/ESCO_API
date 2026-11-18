import type { MercadoSalario } from "@/lib/tipagem";
import styles from "./BarrasSalario.module.css";

const usd = (n: number) => `$${Math.round(n).toLocaleString("en-US")}`;

export default function BarrasSalario({ salarios }: { salarios: MercadoSalario[] }) {
  if (salarios.length === 0) return null;

  const max = Math.max(...salarios.map((s) => s.p90));

  return (
    <div className={styles.grade}>
      {salarios.map((s) => (
        <div key={s.nivel} className={styles.linha}>
          <div className={styles.rotulo}>
            <span className={styles.nivel}>N{s.nivel}</span>
            <span className={styles.nome}>{s.nomeNivel}</span>
          </div>
          <div className={styles.barra}>
            <span className={styles.faixa} style={{ width: `${(s.p90 / max) * 100}%` }} />
            <span className={styles.aterro} style={{ width: `${(s.p50 / max) * 100}%` }} />
            <span className={styles.mediana} style={{ left: `${(s.p50 / max) * 100}%` }} />
          </div>
          <div className={styles.valores}>
            <span className={styles.p25}>{usd(s.p25)}</span>
            <span className={styles.p50}>{usd(s.p50)}</span>
            <span className={styles.p75}>{usd(s.p75)}</span>
            <span className={styles.p90}>{usd(s.p90)}</span>
          </div>
          <div className={styles.amostra}>
            {s.amostra.toLocaleString("pt-BR")} vagas com salário · {s.moeda}
          </div>
        </div>
      ))}
    </div>
  );
}
