import Link from "next/link";
import { ArrowRight, Briefcase, Compass, GraduationCap, Layers, Sparkles, TrendingUp } from "lucide-react";
import { apiGet } from "@/lib/api";
import type { Nivel, SfiaView } from "@/lib/tipagem";
import SearchBar from "@/components/SearchBar/SearchBar";
import styles from "./page.module.css";

export const dynamic = "force-dynamic";

const OCUPACOES_DESTAQUE = [
  { ocupacaoId: 482, titulo: "Cientista de Dados" },
  { ocupacaoId: 414, titulo: "Engenheiro de Dados" },
  { ocupacaoId: 3058, titulo: "Engenheiro de Software" },
  { ocupacaoId: 3050, titulo: "Engenheiro de Machine Learning" },
  { ocupacaoId: 2577, titulo: "Analista de Dados" },
  { ocupacaoId: 662, titulo: "Engenheiro de Computação na Cloud" },
];

export default async function Home() {
  const [views, niveis] = await Promise.all([
    apiGet<SfiaView[]>("/sfia/view"),
    apiGet<Nivel[]>("/habilidade/niveis"),
  ]);

  const raizes = (views ?? []).filter((v) => v.profundidade === 1);

  return (
    <div className="container">
      <section className={styles.hero}>
        <span className={`chip chip-rosa ${styles.sel}`}>SFIA 9 + ESCO + mercado real</span>
        <h1 className={styles.titulo}>
          Encontre a <em>habilidade</em>, o <em>nível</em> e a <em>carreira</em> que cabem em você
        </h1>
        <p className={styles.sub}>
          16 mil habilidades e 3 mil ocupações organizadas por nível de responsabilidade, com salários
          reais e trilhas de progressão. Simples para quem busca — poderoso para analistas e gestores.
        </p>
        <SearchBar />
      </section>

      <h2 className="titulo-secao">
        <Sparkles size={18} />
        Explore por tema
      </h2>
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

      <h2 className="titulo-secao">
        <Layers size={18} />
        Os 7 níveis de responsabilidade
      </h2>
      <div className={styles.niveis}>
        {(niveis ?? []).map((n) => (
          <Link key={n.nivel} href="/niveis" className={styles.nivelCard}>
            <span className={styles.nivelNumero}>{n.nivel}</span>
            <span className={styles.nivelNome}>{n.nome}</span>
            <span className={styles.nivelDesc}>{n.descricao.split(".")[0]}</span>
          </Link>
        ))}
      </div>

      <h2 className="titulo-secao">
        <TrendingUp size={18} />
        Ocupações com dado real de mercado
      </h2>
      <div className="grid-cards">
        {OCUPACOES_DESTAQUE.map((o) => (
          <Link key={o.ocupacaoId} href={`/ocupacoes/${o.ocupacaoId}`} className="card">
            <div className="card-titulo">{o.titulo}</div>
            <p className="card-sub">Salários reais, demanda por habilidades e trilha de progressão</p>
          </Link>
        ))}
      </div>

      <section className={styles.acoes}>
        <Link href="/temas" className={styles.acao}>
          <Compass size={18} />
          <div>
            <strong>Temas &amp; domínios</strong>
            <span>Navegue pela árvore curada de habilidades</span>
          </div>
          <ArrowRight size={16} />
        </Link>
        <Link href="/ocupacoes" className={styles.acao}>
          <Briefcase size={18} />
          <div>
            <strong>Ocupações</strong>
            <span>Busque por cargo e veja o painel de mercado</span>
          </div>
          <ArrowRight size={16} />
        </Link>
        <Link href="/habilidades" className={styles.acao}>
          <GraduationCap size={18} />
          <div>
            <strong>Habilidades</strong>
            <span>Pesquise com tolerância a erro de digitação</span>
          </div>
          <ArrowRight size={16} />
        </Link>
      </section>
    </div>
  );
}
