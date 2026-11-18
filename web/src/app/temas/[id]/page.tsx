import Link from "next/link";
import { notFound } from "next/navigation";
import { apiGet } from "@/lib/api";
import type { SfiaView, SfiaViewDetalhe } from "@/lib/tipagem";
import CardHabilidade from "@/components/CardHabilidade/CardHabilidade";
import Paginacao from "@/components/Paginacao/Paginacao";
import { fatiar, hrefCom, paginaValida, totalDePaginas } from "@/lib/paginacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

export default async function Tema({
  params,
  searchParams,
}: {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ pagina?: string }>;
}) {
  const { id } = await params;
  const { pagina } = await searchParams;
  const viewId = Number(id);
  if (!Number.isFinite(viewId)) notFound();

  const detalhe = await apiGet<SfiaViewDetalhe>(`/sfia/view/${viewId}`);
  if (!detalhe) notFound();

  const views = (await apiGet<SfiaView[]>("/sfia/view")) ?? [];
  const view = detalhe.view;
  const filhos = views.filter((v) => v.slugPai === view.caminho);

  const totalSkills = detalhe.habilidades.length;
  const totalPaginas = totalDePaginas(totalSkills);
  const paginaAtual = paginaValida(pagina, totalPaginas);
  const habilidades = fatiar(detalhe.habilidades, paginaAtual);

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
      <nav className={styles.migalha} aria-label="Trilha de navegação">
        {migalha.map((m, i) => (
          <span key={i} className={styles.migalhaItem}>
            {i > 0 && <span className={styles.separador}>/</span>}
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

      <div className={styles.cabeca}>
        <span className="rotulo">
          nível {String(view.profundidade).padStart(2, "0")} · {view.caminho}
        </span>
        <h1 className="titulo-pagina">{view.nome}</h1>
        <p className="subtitulo-pagina">
          {totalSkills > 0
            ? `${totalSkills} habilidades curadas neste tema${filhos.length ? ` · ${filhos.length} sub-temas` : ""}.`
            : "Este tema se abre em sub-temas — nenhuma habilidade listada diretamente."}
        </p>
      </div>

      {filhos.length > 0 && (
        <section>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Sub-temas</h2>
            <span className={styles.secaoMeta}>{filhos.length} páginas</span>
          </div>
          <div className={styles.listaSubtemas}>
            {filhos.map((f, i) => (
              <Link key={f.viewId} href={`/temas/${f.viewId}`} className={styles.linhaSubtema}>
                <span className={styles.numero}>{String(i + 1).padStart(2, "0")}</span>
                <span className={styles.nomeSubtema}>{f.nome}</span>
                <span className={styles.metaSubtema}>
                  {views.filter((v) => v.caminho.startsWith(f.caminho + "/")).length + 1} pág.
                </span>
                <span className={styles.seta} aria-hidden="true">→</span>
              </Link>
            ))}
          </div>
        </section>
      )}

      {totalSkills > 0 && (
        <section>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Habilidades</h2>
            <span className={styles.secaoMeta}>
              {totalSkills} verbetes · página {paginaAtual} de {totalPaginas}
            </span>
          </div>
          <div className="grid-cards">
            {habilidades.map((h) => (
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
          <Paginacao
            paginaAtual={paginaAtual}
            totalPaginas={totalPaginas}
            hrefPagina={(n) => hrefCom(`/temas/${viewId}`, { pagina: n })}
          />
        </section>
      )}
    </div>
  );
}
