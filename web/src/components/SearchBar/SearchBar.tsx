"use client";

import { useState } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Search } from "lucide-react";
import styles from "./SearchBar.module.css";

export default function SearchBar({
  placeholder = "Busque habilidades ou ocupações (tolerante a erros de digitação)",
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
    <form className={styles.form} onSubmit={enviar} role="search">
      <input
        className="busca-input"
        type="search"
        value={termo}
        onChange={(e) => setTermo(e.target.value)}
        placeholder={placeholder}
        aria-label="Buscar"
      />
      <button className="busca-btn" type="submit">
        <Search size={16} strokeWidth={2.4} />
        Buscar
      </button>
    </form>
  );
}
