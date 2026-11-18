import Link from "next/link";
import { notFound } from "next/navigation";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Ocupacao } from "@/lib/tipagem";
import CardOcupacao from "@/components/CardOcupacao/CardOcupacao";
import Paginacao from "@/components/Paginacao/Paginacao";
import { fatiar, hrefCom, paginaValida, totalDePaginas } from "@/lib/paginacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

export default async function GrupoOcupacaoPage({
  params,
  searchParams,
}: {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ pagina?: string }>;
}) {
  const { id } = await params;
  const { pagina } = await searchParams;
  const grupoId = Number(id);
  if (!Number.isFinite(grupoId)) notFound();

  const [grupos, ocupacoes] = await Promise.all([
    apiGet<GrupoOcupacao[]>("/grupoOcupacao"),
    apiGet<Ocupacao[]>(`/ocupacao/grupo/${grupoId}`),
  ]);

  const grupo = (grupos ?? []).find((g) => g.grupoId === grupoId);
  if (!grupo) notFound();

  const todas = ocupacoes ?? [];
  const totalPaginas = totalDePaginas(todas.length);
  const paginaAtual = paginaValida(pagina, totalPaginas);
  const lista = fatiar(todas, paginaAtual);

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
          {todas.length} {todas.length === 1 ? "ocupação classificada" : "ocupações classificadas"}{" "}
          neste grupo · página {paginaAtual} de {totalPaginas}.
        </p>
      </div>
      {lista.length === 0 ? (
        <div className="vazio">
          <strong>Sem ocupações listadas</strong>
          Este grupo não possui ocupações mapeadas.
        </div>
      ) : (
        <>
          <div className="grid-cards">
            {lista.map((o) => (
              <CardOcupacao key={o.ocupacaoId} ocupacao={o} />
            ))}
          </div>
          <Paginacao
            paginaAtual={paginaAtual}
            totalPaginas={totalPaginas}
            hrefPagina={(n) => hrefCom(`/ocupacoes/grupo/${grupoId}`, { pagina: n })}
          />
        </>
      )}
    </div>
  );
}
