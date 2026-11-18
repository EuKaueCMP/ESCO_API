import Link from "next/link";
import { notFound } from "next/navigation";
import {
  Briefcase, ClipboardList, GraduationCap, Map, Coins, Users, TrendingUp,
} from "lucide-react";
import { apiGet } from "@/lib/api";
import type { GrupoOcupacao, Mercado, OcupacaoHabilidades, Ocupacao, Trilha } from "@/lib/tipagem";
import BarrasSalario from "@/components/BarrasSalario/BarrasSalario";
import BadgeNivel from "@/components/BadgeNivel/BadgeNivel";
import CardOcupacao from "@/components/CardOcupacao/CardOcupacao";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

export default async function Ocupacao({ params }: { params: Promise<{ id: string }> }) {
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
  const grupo = (grupos ?? []).find((g) => g.grupoId === (ocupacao as any).grupoId);
  const topSkills = (mercado?.habilidades ?? []).slice(0, 8);

  return (
    <div className="container">
      <h1 className="titulo-pagina" style={{ paddingTop: 30 }}>{ocupacao.titulo}</h1>
      {grupo && (
        <span className={`chip chip-verde ${styles.chipGrupo}`}>
          <Briefcase size={12} /> {grupo.nome}
        </span>
      )}
      <p className="subtitulo-pagina">{ocupacao.descricao}</p>

      {mercado && (
        <section>
          <h2 className="titulo-secao">
            <TrendingUp size={18} />
            Mercado real
          </h2>
          <div className={styles.mercadoResumo}>
            {mercado.vagas !== null && (
              <div className={styles.resumoCard}>
                <strong>{mercado.vagas.toLocaleString("pt-BR")}</strong>
                <span>vagas agregadas</span>
              </div>
            )}
            {mercado.frequenciaPct !== null && (
              <div className={styles.resumoCard}>
                <strong>{mercado.frequenciaPct.toFixed(1)}%</strong>
                <span>do dataset de vagas</span>
              </div>
            )}
            {mercado.salarios.length > 0 && (
              <div className={styles.resumoCard}>
                <strong>
                  ${Math.round(mercado.salarios[0].p50).toLocaleString("en-US")}
                </strong>
                <span>mediana inicial ({mercado.salarios[0].moeda})</span>
              </div>
            )}
          </div>

          <div className="bloco">
            <div className="bloco-titulo">
              <Coins size={16} />
              Salários por nível de senioridade
            </div>
            <BarrasSalario salarios={mercado.salarios} />
            <p className={styles.fonte}>Fonte: {mercado.fonte}</p>
          </div>

          {topSkills.length > 0 && (
            <div className="bloco">
              <div className="bloco-titulo">
                <ClipboardList size={16} />
                Habilidades mais pedidas nas vagas reais
              </div>
              <div className={styles.topSkills}>
                {topSkills.map((h) => (
                  <Link
                    key={h.habilidadeId}
                    href={`/habilidades/${h.habilidadeId}`}
                    className={styles.topSkill}
                  >
                    <span className={styles.topSkillNome}>{h.nome}</span>
                    <span className={styles.topSkillPct}>{h.pctVagas.toFixed(1)}%</span>
                  </Link>
                ))}
              </div>
            </div>
          )}
        </section>
      )}

      {trilha && trilha.proximasOcupacoes.length > 0 && (
        <section>
          <h2 className="titulo-secao">
            <Map size={18} />
            Trilha de progressão
          </h2>
          <p className={styles.secaoSub}>
            Ocupações que usam as mesmas habilidades essenciais em nível superior — e o que você
            ainda precisaria aprender.
          </p>
          <div className="grid-cards">
            {trilha.proximasOcupacoes.map((p) => (
              <CardOcupacao
                key={p.ocupacaoId}
                ocupacao={{ ocupacaoId: p.ocupacaoId, titulo: p.titulo }}
                extra={`${p.compartilhadas} skills em comum`}
                sub={
                  p.habilidadesFaltantes
                    ? `A aprender: ${p.habilidadesFaltantes}`
                    : undefined
                }
              />
            ))}
          </div>
        </section>
      )}

      {(essenciais.length > 0 || complementares.length > 0) && (
        <section>
          <h2 className="titulo-secao">
            <GraduationCap size={18} />
            Habilidades da ocupação
          </h2>
          <h3 className={styles.subLista}>
            <Users size={14} /> Essenciais ({essenciais.length})
          </h3>
          <div className={styles.listaSkills}>
            {essenciais.map((v) => (
              <SkillVinculo key={v.habilidadeId} vinculo={v} />
            ))}
          </div>
          {complementares.length > 0 && (
            <details className="acordeao" style={{ marginTop: 16 }}>
              <summary>Complementares ({complementares.length})</summary>
              <div className={`acordeao-corpo ${styles.listaSkills}`}>
                {complementares.map((v) => (
                  <SkillVinculo key={v.habilidadeId} vinculo={v} />
                ))}
              </div>
            </details>
          )}
        </section>
      )}
    </div>
  );
}

function SkillVinculo({ vinculo }: { vinculo: OcupacaoHabilidades }) {
  return (
    <Link href={`/habilidades/${vinculo.habilidadeId}`} className={styles.skill}>
      <div className={styles.skillTopo}>
        <span className={styles.skillNome}>{vinculo.nome}</span>
        <BadgeNivel nivel={vinculo.nivelHabilidade} />
      </div>
      {vinculo.justificativa && (
        <p className={styles.skillJust}>{vinculo.justificativa}</p>
      )}
    </Link>
  );
}
