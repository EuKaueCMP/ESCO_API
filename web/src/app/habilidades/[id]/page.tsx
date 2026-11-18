import { notFound } from "next/navigation";
import { BookOpen, ClipboardCheck } from "lucide-react";
import { apiGet } from "@/lib/api";
import type { HabilidadeNiveis, HabilidadeTermo } from "@/lib/tipagem";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

export default async function Habilidade({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const habilidadeId = Number(id);
  if (!Number.isFinite(habilidadeId)) notFound();

  const [habilidade, niveis] = await Promise.all([
    apiGet<HabilidadeTermo>(`/habilidade/${habilidadeId}`),
    apiGet<HabilidadeNiveis[]>(`/habilidade/${habilidadeId}/niveis`),
  ]);

  if (!habilidade) notFound();

  return (
    <div className="container">
      <div className={styles.cabecalho}>
        {habilidade.codigo ? (
          <span className={`codigo-sfia ${styles.codigo}`}>{habilidade.codigo}</span>
        ) : (
          <span className="chip chip-cinza">ESCO</span>
        )}
        <h1 className="titulo-pagina">{habilidade.nome}</h1>
      </div>
      <p className="subtitulo-pagina">
        Descritores por nível de responsabilidade e rubrica de avaliação — tudo em uma página.
      </p>

      {habilidade.descricao && (
        <div className="bloco">
          <div className="bloco-titulo">
            <BookOpen size={16} />
            Sobre a habilidade
          </div>
          <p className="linha-mutada">{habilidade.descricao}</p>
        </div>
      )}

      {(niveis ?? []).length === 0 ? (
        <div className="vazio">
          <strong>Sem descritores publicados</strong>
          Esta habilidade não tem descritores de nível.
        </div>
      ) : (
        (niveis ?? []).map((n) => (
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
                <div className={styles.rubricaTitulo}>
                  <ClipboardCheck size={14} />
                  Como demonstrar este nível
                </div>
                <p>{n.rubrica}</p>
              </div>
            )}
          </div>
        ))
      )}
    </div>
  );
}
