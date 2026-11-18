import Link from "next/link";
import styles from "./CardOcupacao.module.css";

export default function CardOcupacao({
  ocupacao,
  extra,
  sub,
}: {
  ocupacao: { ocupacaoId: number; titulo: string };
  extra?: string;
  sub?: string;
}) {
  return (
    <Link href={`/ocupacoes/${ocupacao.ocupacaoId}`} className={`card ${styles.card}`}>
      <div className="card-titulo">{ocupacao.titulo}</div>
      {sub ? <p className={styles.sub}>{sub}</p> : null}
      {extra ? (
        <div className="card-meta">
          <span className="chip chip-verde">{extra}</span>
        </div>
      ) : null}
    </Link>
  );
}
