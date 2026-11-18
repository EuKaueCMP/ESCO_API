import Link from "next/link";
import { apiGet } from "@/lib/api";
import type { Mercado, Nivel, ResumoClassificacao, SfiaView } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

const DESTAQUE = [
  { ocupacaoId: 482, titulo: "Cientista de Dados" },
  { ocupacaoId: 414, titulo: "Engenheiro de Dados" },
  { ocupacaoId: 3058, titulo: "Engenheiro de Software" },
  { ocupacaoId: 3050, titulo: "Engenheiro de ML" },
  { ocupacaoId: 2577, titulo: "Analista de Dados" },
  { ocupacaoId: 662, titulo: "Engenheiro de Cloud" },
];

const inteiro = (n: number) => n.toLocaleString("pt-BR");
const usd = (n: number) => `$${Math.round(n).toLocaleString("en-US")}`;

export default async function Home() {
  const [views, niveis, mercados, resumo] = await Promise.all([
    apiGet<SfiaView[]>("/sfia/view"),
    apiGet<Nivel[]>("/habilidade/niveis"),
    Promise.all(DESTAQUE.map((d) => apiGet<Mercado>(`/mercado/ocupacao/${d.ocupacaoId}`))),
    apiGet<ResumoClassificacao>("/habilidade/resumo"),
  ]);

  const raizes = (views ?? []).filter((v) => v.profundidade === 1).slice(0, 12);

  return (
    <div className="container">
      <section className={styles.hero}>
        <div className={styles.heroTexto}>
          <span className={styles.sobretitulo}>
            SFIA 9 · ESCO · 785.741 vagas analisadas
          </span>
          <h1 className={styles.titulo}>
            Todo trabalho é feito de <em>habilidades</em>. Aqui, cada uma tem nome, nível e preço.
          </h1>
          <p className={styles.sub}>
            O framework de competências europeu somado ao padrão SFIA, com descritores por nível,
            rubrica de avaliação, salários reais e trilhas de progressão. Busca tolerante a erro de
            digitação.
          </p>
          <SearchBar />
        </div>

        <aside className={styles.ficha} aria-label="Números do acervo">
          <span className="rotulo">o acervo</span>
          <div className={styles.fichaLinha}>
            <span>habilidades</span>
            <strong>16.048</strong>
          </div>
          <div className={styles.fichaLinha}>
            <span>ocupações</span>
            <strong>3.071</strong>
          </div>
          <div className={styles.fichaLinha}>
            <span>vagas analisadas</span>
            <strong>785.741</strong>
          </div>
          <Link href="/habilidades?tipo=hard" className={styles.fichaLinha}>
            <span>hard skills</span>
            <strong>{(resumo?.hardSkill ?? 0).toLocaleString("pt-BR")}</strong>
          </Link>
          <Link href="/habilidades?tipo=soft" className={styles.fichaLinha}>
            <span>soft skills</span>
            <strong>{(resumo?.softSkill ?? 0).toLocaleString("pt-BR")}</strong>
          </Link>
          <div className={styles.fichaLinha}>
            <span>níveis</span>
            <strong>7</strong>
          </div>
          <div className={styles.fichaLinha}>
            <span>atributos de nível</span>
            <strong>16</strong>
          </div>
        </aside>
      </section>

      <div className={styles.estatisticas}>
        <div className={styles.estatistica}>
          <span className={styles.estatisticaNumero}>16.048</span>
          <span className="rotulo">habilidades com descritores</span>
        </div>
        <div className={styles.estatistica}>
          <span className={styles.estatisticaNumero}>3.071</span>
          <span className="rotulo">ocupações mapeadas</span>
        </div>
        <div className={styles.estatistica}>
          <span className={styles.estatisticaNumero}>785.741</span>
          <span className="rotulo">vagas reais analisadas</span>
        </div>
        <div className={styles.estatistica}>
          <span className={styles.estatisticaNumero}>7</span>
          <span className="rotulo">níveis de responsabilidade</span>
        </div>
      </div>

      <section>
        <div className={styles.cabecalhoSecao}>
          <span className={styles.secaoNum}>01</span>
          <h2 className={styles.secaoTitulo}>Temas &amp; domínios</h2>
          <span className={styles.secaoMeta}>
            {raizes.length} domínios · árvore curada
          </span>
          <Link href="/temas" className={styles.secaoLink}>
            ver tudo →
          </Link>
        </div>
        <div className="grid-cards">
          {raizes.map((v) => (
            <Link key={v.viewId} href={`/temas/${v.viewId}`} className="card">
              <div className="card-titulo">{v.nome}</div>
              <p className="card-sub">
                {(views ?? []).filter((x) => x.caminho.startsWith(v.caminho + "/")).length} sub-temas
              </p>
            </Link>
          ))}
        </div>
      </section>

      <section>
        <div className={styles.cabecalhoSecao}>
          <span className={styles.secaoNum}>02</span>
          <h2 className={styles.secaoTitulo}>A escala de responsabilidade</h2>
          <span className={styles.secaoMeta}>do executor ao estrategista</span>
          <Link href="/niveis" className={styles.secaoLink}>
            os 16 atributos →
          </Link>
        </div>
        <div className={styles.escada}>
          {(niveis ?? []).map((n) => (
            <Link key={n.nivel} href="/niveis" className={styles.escadaCelula}>
              <span className={styles.escadaNumero}>{n.nivel}</span>
              <span className={styles.escadaNome}>{n.nome}</span>
              <span className={styles.escadaDesc}>{n.descricao.split(".")[0]}.</span>
            </Link>
          ))}
        </div>
      </section>

      <section>
        <div className={styles.cabecalhoSecao}>
          <span className={styles.secaoNum}>03</span>
          <h2 className={styles.secaoTitulo}>Ocupações com mercado real</h2>
          <span className={styles.secaoMeta}>salário mediano e skills mais pedidas</span>
          <Link href="/ocupacoes" className={styles.secaoLink}>
            ver todas →
          </Link>
        </div>
        <div className="grid-cards">
          {DESTAQUE.map((d, i) => {
            const m = mercados[i];
            const inicial = m?.salarios?.[0];
            return (
              <Link key={d.ocupacaoId} href={`/ocupacoes/${d.ocupacaoId}`} className="card">
                <div className="card-titulo">{d.titulo}</div>
                <p className="card-sub">
                  {m ? `${m.habilidades.length} habilidades exigidas` : "painel de mercado"}
                  {inicial ? ` · mediana inicial ${usd(inicial.p50)}` : ""}
                </p>
              </Link>
            );
          })}
        </div>
      </section>

      <section className={styles.comecar}>
        <div className={styles.cabecalhoSecao}>
          <span className={styles.secaoNum}>04</span>
          <h2 className={styles.secaoTitulo}>Comece por onde fizer sentido</h2>
          <span className={styles.secaoMeta}>três entradas, nenhum cadastro</span>
        </div>
        <div className={styles.atalhos}>
          <Link href="/habilidades" className={styles.atalho}>
            <span className="rotulo">se você quer aprender</span>
            <span className={styles.atalhoNome}>Habilidades</span>
            <span className={styles.atalhoDesc}>
              Descritores por nível e rubrica para provar o que sabe.
            </span>
            <span className={styles.atalhoSeta}>→</span>
          </Link>
          <Link href="/ocupacoes" className={styles.atalho}>
            <span className="rotulo">se você contrata</span>
            <span className={styles.atalhoNome}>Ocupações</span>
            <span className={styles.atalhoDesc}>
              O que cada cargo exige, em que nível e por quanto.
            </span>
            <span className={styles.atalhoSeta}>→</span>
          </Link>
          <Link href="/niveis" className={styles.atalho}>
            <span className="rotulo">se você lidera</span>
            <span className={styles.atalhoNome}>Níveis</span>
            <span className={styles.atalhoDesc}>
              Os 16 atributos que separam um júnior de um principal.
            </span>
            <span className={styles.atalhoSeta}>→</span>
          </Link>
        </div>
      </section>
    </div>
  );
}
