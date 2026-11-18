import Link from "next/link";
import { Briefcase } from "lucide-react";

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
      <div className={styles.topo}>
        <Briefcase size={16} className={styles.icone} />
        {extra ? <span className="chip chip-verde">{extra}</span> : null}
      </div>
      <div className="card-titulo">{ocupacao.titulo}</div>
      {sub ? <p className={styles.sub}>{sub}</p> : null}
    </Link>
  );
}
