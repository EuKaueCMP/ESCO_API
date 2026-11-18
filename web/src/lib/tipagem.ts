export interface SfiaView {
  viewId: number;
  caminho: string;
  slugPai: string | null;
  nome: string | null;
  profundidade: number;
}

export interface SfiaViewDetalhe {
  view: SfiaView;
  habilidades: { habilidadeId: number; nome: string; codigo: string | null; pesoRelevancia: number | null }[];
}

export interface Nivel {
  nivel: number;
  nome: string;
  descricao: string;
}

export interface SfiaAtributo {
  slug: string;
  codigo: string | null;
  nome: string | null;
}

export interface SfiaAtributoNivel {
  nivel: number;
  nomeNivel: string;
  descricao: string;
}

export interface HabilidadeTermo {
  habilidadeId: number;
  nome: string;
  codigo: string | null;
  descricao: string | null;
}

export interface HabilidadeNiveis {
  nivel: number;
  nomeNivel: string;
  descricaoNivel: string | null;
  descritor: string;
  rubrica: string | null;
  origem: string;
}

export interface GrupoOcupacao {
  grupoId: number;
  codigo: string;
  nome: string;
  descricao: string;
}

export interface Ocupacao {
  ocupacaoId: number;
  titulo: string;
  descricao: string;
  nomeAlternativo?: string[] | null;
}

export interface OcupacaoHabilidades {
  habilidadeId: number;
  nome: string;
  codigo: string | null;
  descricao: string | null;
  tipoRelacionamento: string | null;
  nivelHabilidade: number | null;
  descricaoNivel: string | null;
  justificativa: string | null;
  pesoRelevancia: number | null;
}

export interface ProximaOcupacao {
  ocupacaoId: number;
  titulo: string;
  compartilhadas: number;
  nivelMedioDestino: number;
  habilidadesFaltantes: string | null;
}

export interface Trilha {
  ocupacaoId: number;
  titulo: string;
  nivelMedio: number | null;
  habilidadesEssenciais: OcupacaoHabilidades[];
  proximasOcupacoes: ProximaOcupacao[];
}

export interface MercadoSalario {
  nivel: number;
  nomeNivel: string;
  amostra: number;
  p25: number;
  p50: number;
  p75: number;
  p90: number;
  moeda: string;
}

export interface MercadoHabilidade {
  habilidadeId: number;
  nome: string;
  codigo: string | null;
  vagas: number;
  pctVagas: number;
}

export interface Mercado {
  ocupacaoId: number;
  titulo: string;
  vagas: number | null;
  frequenciaPct: number | null;
  fonte: string | null;
  salarios: MercadoSalario[];
  habilidades: MercadoHabilidade[];
}

export interface ResultadoBusca {
  id: number;
  nome: string;
  codigo: string | null;
  tipo: "habilidade" | "ocupacao";
  score: number;
}
