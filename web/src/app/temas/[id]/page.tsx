import Link from "next/link";
import { notFound } from "next/navigation";
import { ArrowUpRight, ChevronRight, Users } from "lucide-react";
import { apiGet } from "@/lib/api";
import type { SfiaView, SfiaViewDetalhe } from "@/lib/tipagem";
import CardHabilidade from "@/components/CardHabilidade/CardHabilidade";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

export default async function Tema({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const viewId = Number(id);

  const detalhe = await apiGet<SfiaViewDetalhe>(`/sfia/view/${viewId}`);
  if (!detalhe || detalhe.habilidades.length === 0 && detalhe.view.profundidade > 1) {
    // pagina sem habilidades diretas: ainda mostra sub-temas
  }
  if (!detalhe) notFound();

  const views = (await apiGet<SfiaView[]>("/sfia/view")) ?? [];
  const view = detalhe.view;
  const filhos = views.filter((v) => v.slugPai === view.caminho);

  const migalha: { nome: string; id: number | null }[] = [{ nome: "Temas", id: null }];
  let pai = views.find((v) => v.caminho === view.slugPai);
  const ancestrais: SfiaView[] = [];
  while (pai) {
    ancestrais.unshift(pai);
    pai = views.find((v) => v.caminho === pai!.slugPai);
  }
  ancestrais.forEach((a) => migalha.push({ nome: a.nome ?? a.caminho, id: a.viewId }));
  migalha.push({ nome: view.nome ?? view.caminho, id: viewId });

  return (
    <div className="container">
      <nav className={styles.migalha}>
        {migalha.map((m, i) => (
          <span key={i} className={styles.migalhaItem}>
            {i > 0 && <ChevronRight size={13} className={styles.migalhaSeta} />}
            {m.id === null || m.id === viewId ? (
              <span className={i === migalha.length - 1 ? styles.migalhaAtual : styles.migalhaLink}>
                {m.nome}
              </span>
            ) : (
              <Link href={`/temas/${m.id}`} className={styles.migalhaLink}>
                {m.nome}
              </Link>
            )}
          </span>
        ))}
      </nav>

      <h1 className="titulo-pagina">{view.nome}</h1>
      <p className="subtitulo-pagina">
        {detalhe.habilidades.length > 0
          ? `${detalhe.habilidades.length} habilidades curadas neste tema`
          : "Navegue pelos sub-temas abaixo"}
      </p>

      {filhos.length > 0 && (
        <>
          <h2 className="titulo-secao">
            <Users size={18} />
            Sub-temas
          </h2>
          <div className="grid-cards">
            {filhos.map((f) => (
              <Link key={f.viewId} href={`/temas/${f.viewId}`} className="card">
                <div className="card-titulo">{f.nome}</div>
                <p className="card-sub">
                  {(views.filter((v) => v.caminho.startsWith(f.caminho + "/")).length + 1)} páginas
                </p>
              </Link>
            ))}
          </div>
        </>
      )}

      {detalhe.habilidades.length > 0 && (
        <>
          <h2 className="titulo-secao">
            <ArrowUpRight size={18} />
            Habilidades
          </h2>
          <div className="grid-cards">
            {detalhe.habilidades.map((h) => (
              <CardHabilidade
                key={h.habilidadeId}
                habilidade={{
                  habilidadeId: h.habilidadeId,
                  nome: h.nome,
                  codigo: h.codigo,
                  descricao: null,
                }}
              />
            ))}
          </div>
        </>
      )}
    </div>
  );
}
