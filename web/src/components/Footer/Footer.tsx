import styles from "./Footer.module.css";

export default function Footer() {
  return (
    <footer className={styles.footer}>
      <div className={`container ${styles.conteudo}`}>
        <p>
          Dados integrados de{" "}
          <a href="https://esco.ec.europa.eu" target="_blank" rel="noreferrer">ESCO</a> e{" "}
          <a href="https://sfia-online.org" target="_blank" rel="noreferrer">SFIA 9</a>,
          enriquecidos com dado real de mercado (785 mil vagas agregadas).
        </p>
        <p className={styles.creditos}>
          Salários em USD · níveis 1–7 · descritores por habilidade e ocupação
        </p>
      </div>
    </footer>
  );
}
