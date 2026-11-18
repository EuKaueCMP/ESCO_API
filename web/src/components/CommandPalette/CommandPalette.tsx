"use client";

import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import styles from "./CommandPalette.module.css";

const ATALHOS = [
  { href: "/temas", rotulo: "navegar", nome: "Temas & domínios" },
  { href: "/habilidades", rotulo: "pesquisar", nome: "Habilidades" },
  { href: "/ocupacoes", rotulo: "pesquisar", nome: "Ocupações" },
  { href: "/niveis", rotulo: "consultar", nome: "Níveis e atributos" },
];

export default function CommandPalette() {
  const [aberta, setAberta] = useState(false);
  const [termo, setTermo] = useState("");
  const inputRef = useRef<HTMLInputElement>(null);
  const router = useRouter();

  useEffect(() => {
    function aoTeclar(e: KeyboardEvent) {
      const alvo = e.target as HTMLElement | null;
      const digitando =
        !!alvo &&
        (["INPUT", "TEXTAREA", "SELECT"].includes(alvo.tagName) || alvo.isContentEditable);

      if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "k") {
        e.preventDefault();
        setAberta((a) => !a);
      } else if (e.key === "Escape") {
        setAberta(false);
      } else if (e.key === "/" && !digitando && !aberta) {
        e.preventDefault();
        setAberta(true);
      }
    }
    const abrir = () => setAberta(true);
    window.addEventListener("keydown", aoTeclar);
    window.addEventListener("abrir-paleta", abrir);
    return () => {
      window.removeEventListener("keydown", aoTeclar);
      window.removeEventListener("abrir-paleta", abrir);
    };
  }, [aberta]);

  useEffect(() => {
    if (aberta) {
      setTermo("");
      document.body.style.overflow = "hidden";
      requestAnimationFrame(() => inputRef.current?.focus());
    } else {
      document.body.style.overflow = "";
    }
    return () => {
      document.body.style.overflow = "";
    };
  }, [aberta]);

  function ir(e: React.FormEvent) {
    e.preventDefault();
    const t = termo.trim();
    setAberta(false);
    router.push(t ? `/busca?termo=${encodeURIComponent(t)}` : "/busca");
  }

  if (!aberta) return null;

  return (
    <div className={styles.veu} onClick={() => setAberta(false)}>
      <div
        className={styles.painel}
        role="dialog"
        aria-modal="true"
        aria-label="Busca rápida"
        onClick={(e) => e.stopPropagation()}
      >
        <form className={styles.campo} onSubmit={ir}>
          <span className={styles.prompt} aria-hidden="true">
            ›
          </span>
          <input
            ref={inputRef}
            value={termo}
            onChange={(e) => setTermo(e.target.value)}
            placeholder="habilidade, ocupação ou termo…"
            aria-label="Termo de busca"
            autoComplete="off"
            spellCheck={false}
          />
        </form>

        <div className={styles.lista}>
          {ATALHOS.map((a) => (
            <Link key={a.href} href={a.href} className={styles.item} onClick={() => setAberta(false)}>
              <span className={styles.itemRotulo}>{a.rotulo}</span>
              <span className={styles.itemNome}>{a.nome}</span>
              <span className={styles.itemSeta} aria-hidden="true">
                →
              </span>
            </Link>
          ))}
        </div>

        <div className={styles.rodape}>
          <span>
            <kbd>↵</kbd> buscar por termo
          </span>
          <span>
            <kbd>esc</kbd> fechar
          </span>
        </div>
      </div>
    </div>
  );
}
