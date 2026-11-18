import Link from "next/link";
import { notFound } from "next/navigation";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Ocupacao } from "@/lib/tipagem";
import CardOcupacao from "@/components/CardOcupacao/CardOcupacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

export default async function GrupoOcupacaoPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const grupoId = Number(id);
  if (!Number.isFinite(grupoId)) notFound();

  const [grupos, ocupacoes] = await Promise.all([
    apiGet<GrupoOcupacao[]>("/grupoOcupacao"),
    apiGet<Ocupacao[]>(`/ocupacao/grupo/${grupoId}`),
  ]);

  const grupo = (grupos ?? []).find((g) => g.grupoId === grupoId);
  if (!grupo) notFound();

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <div className={styles.metaTopo}>
          <Link href="/ocupacoes" className={styles.voltar}>← ocupações</Link>
          <span className={styles.separador}>/</span>
          <span className="rotulo">grupo {grupo.codigo}</span>
        </div>
        <h1 className="titulo-pagina">{grupo.nome}</h1>
        <p className="subtitulo-pagina">
          {ocupacoes?.length ?? 0} ocupações classificadas neste grupo.
        </p>
      </div>
      {(ocupacoes ?? []).length === 0 ? (
        <div className="vazio">
          <strong>Sem ocupações listadas</strong>
          Este grupo não possui ocupações mapeadas.
        </div>
      ) : (
        <div className="grid-cards">
          {ocupacoes!.map((o) => (
            <CardOcupacao key={o.ocupacaoId} ocupacao={o} />
          ))}
        </div>
      )}
    </div>
  );
}
