import Link from "next/link";
import { notFound } from "next/navigation";
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
      <div className={styles.cabeca}>
        <div className={styles.metaTopo}>
          <Link href="/habilidades" className={styles.voltar}>← habilidades</Link>
          <span className={styles.separador}>/</span>
          <span className="rotulo">
            {habilidade.codigo ? `código ${habilidade.codigo}` : "verbete ESCO"} · ID {habilidade.habilidadeId}
          </span>
          <span
            className={`chip ${habilidade.classificacaoHabilidade === "softskill" ? "chip-rosa" : "chip-cinza"}`}
          >
            {habilidade.classificacaoHabilidade === "softskill" ? "soft skill" : "hard skill"}
          </span>
        </div>
        <h1 className="titulo-pagina">{habilidade.nome}</h1>
        {habilidade.descricao && <p className={styles.resumo}>{habilidade.descricao}</p>}
      </div>

      {(niveis ?? []).length === 0 ? (
        <div className="vazio">
          <strong>Sem descritores publicados</strong>
          Esta habilidade não possui descritores de nível.
        </div>
      ) : (
        <div className={styles.niveis}>
          {(niveis ?? []).map((n) => (
            <article key={n.nivel} className={styles.nivel}>
              <div className={styles.nivelLateral}>
                <span className={styles.nivelNumero}>{n.nivel}</span>
                <span className={styles.nivelRotulo}>nível</span>
                <span className={styles.nivelNome}>{n.nomeNivel}</span>
              </div>
              <div className={styles.nivelCorpo}>
                <span
                  className={`chip ${n.origem === "sfia_oficial" ? "chip-verde" : "chip-cinza"} ${styles.selo}`}
                >
                  {n.origem === "sfia_oficial" ? "descritor oficial SFIA" : "descritor sintetizado"}
                </span>
                <p className={styles.descritor}>{n.descritor}</p>
                {n.rubrica && (
                  <div className={styles.rubrica}>
                    <span className={styles.rubricaRotulo}>como demonstrar</span>
                    <p>{n.rubrica}</p>
                  </div>
                )}
              </div>
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
