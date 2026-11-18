"use client";

import { useEffect, useState } from "react";
import { Moon, Sun } from "lucide-react";
import styles from "./ThemeToggle.module.css";

const CHAVE = "rbosf-tema";

type Tema = "claro" | "escuro";

export default function ThemeToggle() {
  const [tema, setTema] = useState<Tema | null>(null);

  useEffect(() => {
    setTema(document.documentElement.dataset.theme === "claro" ? "claro" : "escuro");
  }, []);

  const claro = tema === "claro";

  function alternar() {
    const proximo: Tema = claro ? "escuro" : "claro";
    setTema(proximo);
    document.documentElement.dataset.theme = proximo;
    localStorage.setItem(CHAVE, proximo);
  }

  const rotulo = tema === null
    ? "Alternar tema"
    : claro
      ? "Ativar modo escuro"
      : "Ativar modo claro";

  return (
    <button
      type="button"
      className={styles.botao}
      onClick={alternar}
      aria-label={rotulo}
      title={rotulo}
      aria-pressed={claro}
    >
      {claro ? <Moon size={13} aria-hidden="true" /> : <Sun size={13} aria-hidden="true" />}
      <span className={styles.texto}>{tema === null ? "tema" : claro ? "escuro" : "claro"}</span>
    </button>
  );
}
