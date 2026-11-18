import type { GrupoOcupacao } from "./tipagem";

interface DefinicaoArea {
  slug: string;
  nome: string;
  descricao: string;
  codigos: string[];
}

export interface AreaOcupacao {
  slug: string;
  nome: string;
  descricao: string;
  grupos: GrupoOcupacao[];
}

const AREAS: DefinicaoArea[] = [
  {
    slug: "tecnologia-comunicacao",
    nome: "Tecnologia & comunicação",
    descricao: "TIC, telecomunicações, software e infraestrutura digital.",
    codigos: ["25", "35", "133", "742"],
  },
  {
    slug: "saude",
    nome: "Saúde",
    descricao: "Medicina, enfermagem, terapias e apoio à saúde.",
    codigos: ["22", "32"],
  },
  {
    slug: "educacao",
    nome: "Educação",
    descricao: "Docência, formação e apoio educacional.",
    codigos: ["23"],
  },
  {
    slug: "engenharia-industria",
    nome: "Engenharia, indústria & construção",
    descricao: "Ciências, engenharia, construção, metalurgia e eletricidade.",
    codigos: ["21", "31", "71", "72", "74", "75"],
  },
  {
    slug: "negocios-financas",
    nome: "Negócios, finanças & gestão",
    descricao: "Direção, finanças, administração, escritórios e atendimento.",
    codigos: ["11", "12", "13", "24", "33", "41", "42", "43", "44"],
  },
  {
    slug: "servicos-vendas",
    nome: "Serviços, vendas & turismo",
    descricao: "Hotelaria, restauração, comércio, cuidados pessoais e proteção.",
    codigos: ["14", "51", "52", "53", "54"],
  },
  {
    slug: "agricultura-ambiente",
    nome: "Agricultura, ambiente & produção",
    descricao: "Agricultura, silvicultura, pesca e trabalho rural.",
    codigos: ["61", "62", "63", "92"],
  },
  {
    slug: "logistica-operacao",
    nome: "Logística, operação & manutenção",
    descricao: "Máquinas, montagem, transporte e operação industrial.",
    codigos: ["81", "82", "83", "93"],
  },
  {
    slug: "cultura-direito",
    nome: "Cultura, direito & sociedade",
    descricao: "Direito, ciências sociais, artes, jornalismo e cultura.",
    codigos: ["26", "34"],
  },
  {
    slug: "defesa-seguranca",
    nome: "Defesa & segurança",
    descricao: "Forças armadas e carreiras militares.",
    codigos: ["01", "02", "03"],
  },
];

export function agruparAreas(grupos: GrupoOcupacao[]): AreaOcupacao[] {
  const porCodigo = new Map(grupos.map((g) => [g.codigo, g]));

  return AREAS.map(({ codigos, ...area }) => ({
    ...area,
    grupos: codigos
      .map((codigo) => porCodigo.get(codigo))
      .filter((grupo): grupo is GrupoOcupacao => grupo !== undefined),
  })).filter((area) => area.grupos.length > 0);
}
