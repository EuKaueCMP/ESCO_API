import Link from "next/link";
import { GraduationCap } from "lucide-react";
import type { HabilidadeTermo } from "@/lib/tipagem";
import BadgeNivel from "@/components/BadgeNivel/BadgeNivel";
import styles from "./CardHabilidade.module.css";

export default function CardHabilidade({
  habilidade,
  nivel,
}: {
  habilidade: HabilidadeTermo;
  nivel?: number | null;
}) {
  return (
    <Link href={`/habilidades/${habilidade.habilidadeId}`} className={`card ${styles.card}`}>
      <div className={styles.topo}>
        <GraduationCap size={16} className={styles.icone} />
        {habilidade.codigo ? (
          <span className="codigo-sfia">{habilidade.codigo}</span>
        ) : (
          <span className="chip chip-cinza">ESCO</span>
        )}
      </div>
      <div className="card-titulo">{habilidade.nome}</div>
      <p className="card-sub">{habilidade.descricao}</p>
      <div className="card-meta">
        <BadgeNivel nivel={nivel ?? null} />
      </div>
    </Link>
  );
}
