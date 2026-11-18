import styles from "./BadgeNivel.module.css";

export default function BadgeNivel({ nivel }: { nivel: number | null }) {
  if (nivel === null) return null;

  return (
    <span className={styles.faixa} title={`Nível ${nivel} (escala 1–7)`}>
      {[1, 2, 3, 4, 5, 6, 7].map((n) => (
        <span key={n} className={`${styles.ponto} ${n <= nivel ? styles.ativo : ""}`} />
      ))}
      <span className={styles.rotulo}>{nivel}</span>
    </span>
  );
}
