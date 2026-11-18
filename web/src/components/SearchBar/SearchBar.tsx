"use client";

import { useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import styles from "./SearchBar.module.css";

export default function SearchBar({
  placeholder = "Ex.: kubernet, analista de dados, phyton…",
  destino = "/busca",
}: {
  placeholder?: string;
  destino?: string;
}) {
  const router = useRouter();
  const params = useSearchParams();
  const [termo, setTermo] = useState(params.get("termo") ?? "");

  function enviar(e: React.FormEvent) {
    e.preventDefault();
    const t = termo.trim();
    router.push(t ? `${destino}?termo=${encodeURIComponent(t)}` : destino);
  }

  return (
    <form className={`busca-form ${styles.form}`} onSubmit={enviar} role="search">
      <span className={styles.chevron} aria-hidden="true">›</span>
      <input
        className="busca-input"
        type="search"
        value={termo}
        onChange={(e) => setTermo(e.target.value)}
        placeholder={placeholder}
        aria-label="Buscar"
      />
      <button className="busca-btn" type="submit">
        buscar
      </button>
    </form>
  );
}
