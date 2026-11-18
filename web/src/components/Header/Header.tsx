"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { Compass, Briefcase, GraduationCap, Map } from "lucide-react";
import styles from "./Header.module.css";

const LINKS = [
  { href: "/temas", label: "Temas", icone: Compass },
  { href: "/habilidades", label: "Habilidades", icone: GraduationCap },
  { href: "/ocupacoes", label: "Ocupações", icone: Briefcase },
  { href: "/niveis", label: "Níveis", icone: Map },
];

export default function Header() {
  const caminho = usePathname();

  return (
    <header className={styles.header}>
      <div className={`container ${styles.conteudo}`}>
        <Link href="/" className={styles.logo}>
          ESCO<span className={styles.logoPonto}>·</span>SFIA
        </Link>
        <nav className={styles.nav}>
          {LINKS.map(({ href, label, icone: Icone }) => (
            <Link
              key={href}
              href={href}
              className={`${styles.link} ${caminho.startsWith(href) ? styles.ativo : ""}`}
            >
              <Icone size={15} strokeWidth={2.2} />
              <span>{label}</span>
            </Link>
          ))}
        </nav>
      </div>
    </header>
  );
}
