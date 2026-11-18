import { notFound } from "next/navigation";
import { apiGet } from "@/lib/api";
import type { HabilidadeNiveis, HabilidadeTermo } from "@/lib/tipagem";
import styles from "../../[id]/page.module.css";

export const dynamic = "force-dynamic";

export default async function HabilidadePorCodigo({ params }: { params: Promise<{ codigo: string }> }) {
  const { codigo } = await params;
  const habilidade = await apiGet<HabilidadeTermo>(`/habilidade/codigo/${encodeURIComponent(codigo)}`);
  if (!habilidade) notFound();

  const niveis = (await apiGet<HabilidadeNiveis[]>(`/habilidade/${habilidade.habilidadeId}/niveis`)) ?? [];

  return (
    <div className="container">
      <div className={styles.cabecalho}>
        <span className={`codigo-sfia ${styles.codigo}`}>{codigo}</span>
        <h1 className="titulo-pagina">{habilidade.nome}</h1>
      </div>
      <p className="subtitulo-pagina">{habilidade.descricao}</p>
      {niveis.map((n) => (
        <div key={n.nivel} className="bloco">
          <div className={styles.cabecalhoNivel}>
            <span className={styles.numeroNivel}>{n.nivel}</span>
            <div>
              <div className={styles.nomeNivel}>{n.nomeNivel}</div>
              <span className={`chip ${n.origem === "sfia_oficial" ? "chip-verde" : "chip-cinza"}`}>
                {n.origem === "sfia_oficial" ? "descritor oficial SFIA" : "descritor sintetizado"}
              </span>
            </div>
          </div>
          <p className={styles.descritor}>{n.descritor}</p>
          {n.rubrica && (
            <div className={styles.rubrica}>
              <div className={styles.rubricaTitulo}>Como demonstrar este nível</div>
              <p>{n.rubrica}</p>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
