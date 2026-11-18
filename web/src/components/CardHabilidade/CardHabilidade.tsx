import Link from "next/link";
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
      <div className="card-titulo">{habilidade.nome}</div>
      {habilidade.descricao && <p className="card-sub">{habilidade.descricao}</p>}
      <div className="card-meta">
        {habilidade.codigo ? (
          <span className="codigo-sfia">{habilidade.codigo}</span>
        ) : (
          <span className="chip chip-cinza">ESCO</span>
        )}
        {habilidade.classificacaoHabilidade === "softskill" && (
          <span className="chip chip-rosa">soft</span>
        )}
        <BadgeNivel nivel={nivel ?? null} />
      </div>
    </Link>
  );
}
