import Link from "next/link";
import styles from "./Footer.module.css";

export default function Footer() {
  return (
    <footer className={styles.footer}>
      <div className={`container ${styles.colunas}`}>
        <div className={styles.manifesto}>
          <p className={styles.frase}>
            Um índice aberto do trabalho: <em>o que</em> se sabe fazer, <em>em que nível</em> e{" "}
            <em>por quanto</em>.
          </p>
          <span className={styles.edicao}>RBOSF · edição 2026 · pt-BR</span>
          <span className={styles.sigla}>
            Relation Between Occupations and Skills Framework
          </span>
        </div>

        <div className={styles.coluna}>
          <span className="rotulo">o framework</span>
          <span>Ocupações e habilidades em uma só estrutura de relação.</span>
          <span className={styles.fonte}>SFIA 9 + ESCO · 7 níveis · 16 atributos</span>
        </div>

        <div className={styles.coluna}>
          <span className="rotulo">dados</span>
          <a href="https://esco.ec.europa.eu" target="_blank" rel="noreferrer">ESCO — Comissão Europeia</a>
          <a href="https://sfia-online.org" target="_blank" rel="noreferrer">SFIA 9 — SFIA Foundation</a>
          <span className={styles.fonte}>Vagas: 785.741 anúncios (2023–2024)</span>
        </div>

        <div className={styles.coluna}>
          <span className="rotulo">colofão</span>
          <span>Instrument Serif · IBM Plex Sans/Mono</span>
          <span>Hairlines de 1px · algarismos tabulares</span>
          <span>Sem sombras. Sem gradientes decorativos.</span>
        </div>
      </div>

      <div className={`container ${styles.base}`}>
        <span>16.048 habilidades · 3.071 ocupações · 7 níveis · 16 atributos</span>
        <nav className={styles.links}>
          <Link href="/temas">temas</Link>
          <Link href="/habilidades">habilidades</Link>
          <Link href="/ocupacoes">ocupações</Link>
          <Link href="/niveis">níveis</Link>
        </nav>
      </div>
    </footer>
  );
}
