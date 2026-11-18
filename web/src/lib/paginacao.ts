export const ITENS_POR_PAGINA = 24;

export function totalDePaginas(total: number, porPagina = ITENS_POR_PAGINA) {
  return Math.max(1, Math.ceil(total / porPagina));
}

export function paginaValida(bruta: string | undefined, totalPaginas: number) {
  const n = Number(bruta);
  if (!Number.isFinite(n)) return 1;
  return Math.min(Math.max(Math.trunc(n), 1), totalPaginas);
}

export function fatiar<T>(itens: T[], pagina: number, porPagina = ITENS_POR_PAGINA) {
  const inicio = (pagina - 1) * porPagina;
  return itens.slice(inicio, inicio + porPagina);
}

export function hrefCom(
  base: string,
  params: Record<string, string | number | undefined | null>,
) {
  const qs = new URLSearchParams();
  for (const [chave, valor] of Object.entries(params)) {
    if (valor === undefined || valor === null || valor === "") continue;
    qs.set(chave, String(valor));
  }
  const s = qs.toString();
  return s ? `${base}?${s}` : base;
}
