using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.DTOs.OcupacaoDTO;
using ESCO_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ESCO_API.Repositories
{
    public class OcupacaoRepository : IOcupacaoRepository
    {
        private readonly EscoContext _ctx;
        public OcupacaoRepository(EscoContext ctx) => _ctx = ctx;

        public async Task<List<Ocupacao>> Listar()
            => await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .OrderByDescending(o => o.PesoRelevancia)
                .ThenBy(o => o.Titulo)
                .ToListAsync();

        public async Task<List<Ocupacao>> ListarPorTermo(string termo)
        {
            return await _ctx.Ocupacao
                .Where(h => h.SearchVector.Matches(
                    EF.Functions.PlainToTsQuery("portuguese", termo)) ||
                    EF.Functions.TrigramsSimilarity(h.Titulo, termo) >= 0.3)
                .Include(o => o.GrupoOcupacao)
                .OrderByDescending(h => h.SearchVector.Rank(
                    EF.Functions.PlainToTsQuery("portuguese", termo)))
                .ThenByDescending(h => EF.Functions.TrigramsSimilarity(h.Titulo, termo))
                .ThenByDescending(h => h.PesoRelevancia)
                .ToListAsync();
        }

        public async Task<List<Ocupacao>?> ListarPorGrupo(int grupoId)
        {
            var grupo = await _ctx.GrupoOcupacao
                .FirstOrDefaultAsync(g => g.GrupoId == grupoId);

            if (grupo is null)
                return null;

            return grupo.Ocupacao
                .OrderByDescending(o => o.PesoRelevancia)
                .ThenBy(o => o.Titulo)
                .ToList();
        }

        public async Task<List<ListarHabilidadePorOcupacaoDto>?> ListarHabilidadesPorOcupacaoId(int ocupacaoId)
        {
            bool existe = await _ctx.Ocupacao.AnyAsync(o => o.OcupacaoId == ocupacaoId);

            if (!existe)
                return null;

            List<Habilidade> habilidades = await _ctx.Habilidade
                .Where(h => h.Ocupacao.Any(o => o.OcupacaoId == ocupacaoId))
                .ToListAsync();

            List<VinculoOcupacaoHabilidade> vinculos = await _ctx.Database
                .SqlQuery<VinculoOcupacaoHabilidade>($"""
                    SELECT habilidade_id AS "HabilidadeId",
                           nivel_habilidade AS "NivelHabilidade",
                           tipo_relacionamento::text AS "TipoRelacionamento",
                           descricao AS "DescricaoNivel"
                    FROM esco_dataset.ocupacao_habilidade
                    WHERE ocupacao_id = {ocupacaoId}
                    """)
                .ToListAsync();

            Dictionary<int, (short? nivel, string tipo, string desc)> porHabilidade = vinculos
                .GroupBy(v => v.HabilidadeId)
                .ToDictionary(
                    g => g.Key,
                    g => (g.First().NivelHabilidade, g.First().TipoRelacionamento ?? "opcional",
                          g.First().DescricaoNivel));

            return habilidades
                .Select(h =>
                {
                    porHabilidade.TryGetValue(h.HabilidadeId, out (short? nivel, string tipo, string desc) vinculo);
                    return new ListarHabilidadePorOcupacaoDto
                    {
                        HabilidadeId = h.HabilidadeId,
                        Nome = h.Nome,
                        Codigo = h.Codigo,
                        Descricao = h.Descricao,
                        TipoRelacionamento = vinculo.tipo,
                        NivelHabilidade = vinculo.nivel,
                        DescricaoNivel = vinculo.desc,
                        PesoRelevancia = h.PesoRelevancia
                    };
                })
                .OrderByDescending(h => h.PesoRelevancia ?? 0)
                .ThenBy(h => h.Nome)
                .ToList();
        }

        /// <summary>Projecao do vinculo ocupacao-habilidade lido por SQL bruto.</summary>
        public class VinculoOcupacaoHabilidade
        {
            public int HabilidadeId { get; set; }

            public short? NivelHabilidade { get; set; }

            public string? TipoRelacionamento { get; set; }

            public string? DescricaoNivel { get; set; }
        }

        public async Task<Ocupacao?> ObterPorId(int ocupacaoId)
            => await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .FirstOrDefaultAsync(h => h.OcupacaoId == ocupacaoId);
    }
}