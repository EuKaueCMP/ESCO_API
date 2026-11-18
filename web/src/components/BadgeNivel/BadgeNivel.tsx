import styles from "./BadgeNivel.module.css";

export default function BadgeNivel({ nivel }: { nivel: number | null }) {
  if (nivel === null) return null;

  return (
    <span className={styles.faixa} title={`Nível ${nivel} de 7`}>
      <span className={styles.tiques} aria-hidden="true">
        {[1, 2, 3, 4, 5, 6, 7].map((n) => (
          <span key={n} className={`${styles.tique} ${n <= nivel ? styles.ativo : ""}`} />
        ))}
      </span>
      <span className={styles.rotulo}>N{nivel}</span>
    </span>
  );
}
