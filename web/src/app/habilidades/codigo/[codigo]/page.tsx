import Link from "next/link";
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
      <div className={styles.cabeca}>
        <div className={styles.metaTopo}>
          <Link href="/habilidades" className={styles.voltar}>← habilidades</Link>
          <span className={styles.separador}>/</span>
          <span className="rotulo">código {codigo}</span>
        </div>
        <h1 className="titulo-pagina">{habilidade.nome}</h1>
        {habilidade.descricao && <p className={styles.resumo}>{habilidade.descricao}</p>}
      </div>

      <div className={styles.niveis}>
        {niveis.map((n) => (
          <article key={n.nivel} className={styles.nivel}>
            <div className={styles.nivelLateral}>
              <span className={styles.nivelNumero}>{n.nivel}</span>
              <span className={styles.nivelRotulo}>nível</span>
              <span className={styles.nivelNome}>{n.nomeNivel}</span>
            </div>
            <div className={styles.nivelCorpo}>
              <span className={`chip ${n.origem === "sfia_oficial" ? "chip-verde" : "chip-cinza"} ${styles.selo}`}>
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
    </div>
  );
}
