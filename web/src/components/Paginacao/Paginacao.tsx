import Link from "next/link";
import { ChevronLeft, ChevronRight } from "lucide-react";
import styles from "./Paginacao.module.css";

function janela(pagina: number, total: number): (number | "…")[] {
  if (total <= 7) return Array.from({ length: total }, (_, i) => i + 1);

  const numeros = new Set<number>([1, total]);
  for (let p = pagina - 1; p <= pagina + 1; p++) {
    if (p > 1 && p < total) numeros.add(p);
  }
  if (pagina <= 3) [2, 3, 4].forEach((p) => p < total && numeros.add(p));
  if (pagina >= total - 2) [total - 3, total - 2, total - 1].forEach((p) => p > 1 && numeros.add(p));

  const ordenados = [...numeros].sort((a, b) => a - b);
  const saida: (number | "…")[] = [];
  let anterior = 0;
  for (const n of ordenados) {
    if (anterior && n - anterior > 1) saida.push("…");
    saida.push(n);
    anterior = n;
  }
  return saida;
}

export default function Paginacao({
  paginaAtual,
  totalPaginas,
  hrefPagina,
}: {
  paginaAtual: number;
  totalPaginas: number;
  hrefPagina: (pagina: number) => string;
}) {
  if (totalPaginas <= 1) return null;

  const anterior = paginaAtual > 1;
  const proxima = paginaAtual < totalPaginas;

  return (
    <nav className={styles.paginacao} aria-label="Paginação">
      {anterior ? (
        <Link href={hrefPagina(paginaAtual - 1)} className={styles.botao} rel="prev">
          <ChevronLeft size={14} strokeWidth={2.2} />
          Anterior
        </Link>
      ) : (
        <span className={`${styles.botao} ${styles.desabilitado}`} aria-disabled="true">
          <ChevronLeft size={14} strokeWidth={2.2} />
          Anterior
        </span>
      )}

      <ol className={styles.numeros}>
        {janela(paginaAtual, totalPaginas).map((n, i) =>
          n === "…" ? (
            <li key={`e${i}`} className={styles.reticencias} aria-hidden="true">
              …
            </li>
          ) : n === paginaAtual ? (
            <li key={n}>
              <span className={`${styles.numero} ${styles.ativo}`} aria-current="page">
                {n}
              </span>
            </li>
          ) : (
            <li key={n}>
              <Link href={hrefPagina(n)} className={styles.numero} aria-label={`Página ${n}`}>
                {n}
              </Link>
            </li>
          ),
        )}
      </ol>

      {proxima ? (
        <Link href={hrefPagina(paginaAtual + 1)} className={styles.botao} rel="next">
          Próximo
          <ChevronRight size={14} strokeWidth={2.2} />
        </Link>
      ) : (
        <span className={`${styles.botao} ${styles.desabilitado}`} aria-disabled="true">
          Próximo
          <ChevronRight size={14} strokeWidth={2.2} />
        </span>
      )}
    </nav>
  );
}
