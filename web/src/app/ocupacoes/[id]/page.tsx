import Link from "next/link";
import { notFound } from "next/navigation";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Mercado, OcupacaoHabilidades, Ocupacao, Trilha } from "@/lib/tipagem";
import BarrasSalario from "@/components/BarrasSalario/BarrasSalario";
import BadgeNivel from "@/components/BadgeNivel/BadgeNivel";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

const usd = (n: number) => `$${Math.round(n).toLocaleString("en-US")}`;

export default async function OcupacaoPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const ocupacaoId = Number(id);
  if (!Number.isFinite(ocupacaoId)) notFound();

  const [ocupacao, vinculos, mercado, trilha, grupos] = await Promise.all([
    apiGet<Ocupacao>(`/ocupacao/${ocupacaoId}`),
    apiGet<OcupacaoHabilidades[]>(`/ocupacao/ocupacaoId/${ocupacaoId}/habilidades`),
    apiGet<Mercado>(`/mercado/ocupacao/${ocupacaoId}`),
    apiGet<Trilha>(`/ocupacao/ocupacaoId/${ocupacaoId}/trilha`),
    apiGet<GrupoOcupacao[]>("/grupoOcupacao"),
  ]);

  if (!ocupacao) notFound();

  const essenciais = (vinculos ?? []).filter((v) => v.tipoRelacionamento === "essencial");
  const complementares = (vinculos ?? []).filter(
    (v) => v.tipoRelacionamento !== "essencial" && v.pesoRelevancia !== null && v.pesoRelevancia > 2,
  );
  const grupo = (grupos ?? []).find((g) => g.grupoId === (ocupacao as { grupoId?: number }).grupoId);
  const topSkills = (mercado?.habilidades ?? []).slice(0, 10);
  const inicial = mercado?.salarios?.[0];

  return (
    <div className="container">
      <div className={styles.cabeca}>
        <div className={styles.metaTopo}>
          <Link href="/ocupacoes" className={styles.voltar}>← ocupações</Link>
          {grupo && (
            <>
              <span className={styles.separador}>/</span>
              <Link href={`/ocupacoes/grupo/${grupo.grupoId}`} className={styles.grupoLink}>
                {grupo.codigo} · {grupo.nome}
              </Link>
            </>
          )}
        </div>
        <h1 className="titulo-pagina">{ocupacao.titulo}</h1>
        {ocupacao.descricao && <p className={styles.resumo}>{ocupacao.descricao}</p>}
      </div>

      {mercado && (
        <>
          <div className={styles.painel}>
            <div className={styles.painelCelula}>
              <span className="rotulo">vagas agregadas</span>
              <strong className={styles.painelNumero}>
                {mercado.vagas !== null ? mercado.vagas.toLocaleString("pt-BR") : "—"}
              </strong>
            </div>
            <div className={styles.painelCelula}>
              <span className="rotulo">frequência no dataset</span>
              <strong className={styles.painelNumero}>
                {mercado.frequenciaPct !== null ? `${mercado.frequenciaPct.toFixed(1)}%` : "—"}
              </strong>
            </div>
            <div className={styles.painelCelula}>
              <span className="rotulo">mediana inicial</span>
              <strong className={styles.painelNumero}>{inicial ? usd(inicial.p50) : "—"}</strong>
            </div>
            <div className={styles.painelCelula}>
              <span className="rotulo">faixas de nível</span>
              <strong className={styles.painelNumero}>{mercado.salarios.length}</strong>
            </div>
          </div>
          {mercado.fonte && <p className={styles.fonte}>Fonte: {mercado.fonte} · valores em USD</p>}

          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Salário por senioridade</h2>
            <span className={styles.secaoMeta}>percentis p25 · mediana · p75 · p90</span>
          </div>
          <div className={styles.corpoBloco}>
            <BarrasSalario salarios={mercado.salarios} />
          </div>

          {topSkills.length > 0 && (
            <>
              <div className={styles.cabecalhoSecao}>
                <h2 className={styles.secaoTitulo}>Habilidades mais pedidas</h2>
                <span className={styles.secaoMeta}>% das vagas da ocupação que citam a skill</span>
              </div>
              <div className={styles.corpoBloco}>
                <div className={styles.skillsMercado}>
                  {topSkills.map((h) => (
                    <Link key={h.habilidadeId} href={`/habilidades/${h.habilidadeId}`} className={styles.skillMercado}>
                      <span className={styles.skillNome}>{h.nome}</span>
                      <span className={styles.skillTrilha} aria-hidden="true">
                        <span style={{ width: `${Math.min(h.pctVagas, 100)}%` }} />
                      </span>
                      <span className={styles.skillPct}>{h.pctVagas.toFixed(1)}%</span>
                    </Link>
                  ))}
                </div>
              </div>
            </>
          )}
        </>
      )}

      {trilha && trilha.proximasOcupacoes.length > 0 && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Trilha de progressão</h2>
            <span className={styles.secaoMeta}>mesmas habilidades essenciais, nível acima</span>
          </div>
          <p className={styles.nota}>
            Ocupações que compartilham a base desta função e o que falta para chegar lá.
          </p>
          <div className={styles.trilha}>
            {trilha.proximasOcupacoes.map((p, i) => (
              <Link key={p.ocupacaoId} href={`/ocupacoes/${p.ocupacaoId}`} className={styles.trilhaLinha}>
                <span className={styles.numero}>{String(i + 1).padStart(2, "0")}</span>
                <span className={styles.trilhaNome}>{p.titulo}</span>
                <span className={styles.trilhaMeta}>
                  {p.compartilhadas} skills em comum · nível médio {p.nivelMedioDestino}
                </span>
                <span className={styles.trilhaGap}>
                  {p.habilidadesFaltantes ? `a aprender: ${p.habilidadesFaltantes}` : "sem gap essencial"}
                </span>
              </Link>
            ))}
          </div>
        </>
      )}

      {(essenciais.length > 0 || complementares.length > 0) && (
        <>
          <div className={styles.cabecalhoSecao}>
            <h2 className={styles.secaoTitulo}>Habilidades da ocupação</h2>
            <span className={styles.secaoMeta}>
              {essenciais.length} essenciais · {complementares.length} complementares
            </span>
          </div>
          <div className={styles.skills}>
            {essenciais.map((v) => (
              <SkillVinculo key={v.habilidadeId} vinculo={v} />
            ))}
          </div>

          {complementares.length > 0 && (
            <details className={`acordeao ${styles.complementares}`}>
              <summary>
                <span className="rotulo">complementares</span>
                <span>{complementares.length} habilidades de apoio</span>
              </summary>
              <div className={`acordeao-corpo ${styles.skills}`}>
                {complementares.map((v) => (
                  <SkillVinculo key={v.habilidadeId} vinculo={v} />
                ))}
              </div>
            </details>
          )}
        </>
      )}
    </div>
  );
}

function SkillVinculo({ vinculo }: { vinculo: OcupacaoHabilidades }) {
  return (
    <Link href={`/habilidades/${vinculo.habilidadeId}`} className={styles.skill}>
      <div className={styles.skillTopo}>
        <span className={styles.skillNome}>{vinculo.nome}</span>
        {vinculo.codigo && <span className="codigo-sfia">{vinculo.codigo}</span>}
        <BadgeNivel nivel={vinculo.nivelHabilidade} />
      </div>
      {vinculo.justificativa && <p className={styles.skillJust}>{vinculo.justificativa}</p>}
    </Link>
  );
}
