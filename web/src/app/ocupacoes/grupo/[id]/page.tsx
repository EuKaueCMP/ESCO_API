import { notFound } from "next/navigation";
import { Briefcase } from "lucide-react";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Ocupacao } from "@/lib/tipagem";
import CardOcupacao from "@/components/CardOcupacao/CardOcupacao";
import styles from "../../page.module.css";

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
      <h1 className="titulo-pagina">
        <span className={styles.grupoCodigo} style={{ marginRight: 12 }}>{grupo.codigo}</span>
        {grupo.nome}
      </h1>
      <p className="subtitulo-pagina">
        {ocupacoes?.length ?? 0} ocupações neste grupo ocupacional
      </p>
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
