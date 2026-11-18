import type { SfiaView } from "./tipagem";

interface DefinicaoMacroarea {
  slug: string;
  nome: string;
  descricao: string;
  caminhos: string[];
}

export interface GrupoTemas {
  slug: string;
  nome: string;
  descricao: string;
  temas: SfiaView[];
}

const MACROAREAS: DefinicaoMacroarea[] = [
  {
    slug: "tecnologia-engenharia",
    nome: "Tecnologia & engenharia",
    descricao: "Engenharia de software, DevOps e TI empresarial.",
    caminhos: [
      "software-engineering-competencies",
      "devops-view",
      "enterprise-it-view",
    ],
  },
  {
    slug: "dados-ia",
    nome: "Dados & IA",
    descricao: "IA, aprendizado de máquina, big data e análise de dados.",
    caminhos: ["ai-and-ml-view", "big-data-data-science"],
  },
  {
    slug: "seguranca-sustentabilidade",
    nome: "Segurança & sustentabilidade",
    descricao: "Cibersegurança, privacidade e tecnologia sustentável.",
    caminhos: [
      "information-and-cyber-security",
      "sustainable-technology-and-greenops",
    ],
  },
  {
    slug: "transformacao-gestao",
    nome: "Transformação & gestão",
    descricao: "Transformação digital, framework completo e visões integradas.",
    caminhos: ["digital-transformation", "full-framework-view", "sfia-9-multi-view"],
  },
  {
    slug: "comunicacao-colaboracao",
    nome: "Comunicação & colaboração",
    descricao: "Colaboração, fluxo de trabalho e comunicação entre times.",
    caminhos: ["agile-skills"],
  },
];

export function agruparTemas(views: SfiaView[]): GrupoTemas[] {
  const raizes = views.filter((v) => v.profundidade === 1);
  const usados = new Set<string>();

  const grupos: GrupoTemas[] = MACROAREAS.map(({ caminhos, ...macro }) => {
    const temas = raizes
      .filter((v) => caminhos.includes(v.caminho))
      .sort((a, b) => caminhos.indexOf(a.caminho) - caminhos.indexOf(b.caminho));
    temas.forEach((t) => usados.add(t.caminho));
    return { ...macro, temas };
  }).filter((g) => g.temas.length > 0);

  const restantes = raizes.filter((v) => !usados.has(v.caminho));
  if (restantes.length > 0) {
    grupos.push({
      slug: "outros",
      nome: "Outros domínios",
      descricao: "Demais temas disponíveis no acervo.",
      temas: restantes,
    });
  }

  return grupos;
}
