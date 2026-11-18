"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import styles from "./Header.module.css";

const LINKS = [
  { href: "/temas", label: "temas" },
  { href: "/habilidades", label: "habilidades" },
  { href: "/ocupacoes", label: "ocupações" },
  { href: "/niveis", label: "níveis" },
  { href: "/docs", label: "docs" },
];

export default function Header() {
  const caminho = usePathname();

  return (
    <header className={styles.header}>
      <div className={`container ${styles.conteudo}`}>
        <Link href="/" className={styles.logo}>
          <span className={styles.marca}>RBOSF</span>
          <span className={styles.tag}>índice aberto</span>
        </Link>

        <nav className={styles.nav} aria-label="Principal">
          {LINKS.map(({ href, label }) => (
            <Link
              key={href}
              href={href}
              className={`${styles.link} ${caminho.startsWith(href) ? styles.ativo : ""}`}
            >
              {label}
            </Link>
          ))}
        </nav>

        <button
          type="button"
          className={styles.paleta}
          onClick={() => window.dispatchEvent(new CustomEvent("abrir-paleta"))}
          aria-label="Abrir busca rápida (Cmd K)"
        >
          <span className={styles.paletaTexto}>buscar</span>
          <kbd>⌘K</kbd>
        </button>
      </div>
    </header>
  );
}
