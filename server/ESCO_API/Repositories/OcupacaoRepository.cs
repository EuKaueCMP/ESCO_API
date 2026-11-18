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
                           descricao AS "DescricaoNivel",
                           justificativa AS "Justificativa"
                    FROM esco_dataset.ocupacao_habilidade
                    WHERE ocupacao_id = {ocupacaoId}
                    """)
                .ToListAsync();

            Dictionary<int, (short? nivel, string tipo, string desc, string? just)> porHabilidade = vinculos
                .GroupBy(v => v.HabilidadeId)
                .ToDictionary(
                    g => g.Key,
                    g => (g.First().NivelHabilidade, g.First().TipoRelacionamento ?? "opcional",
                          g.First().DescricaoNivel, g.First().Justificativa));

            return habilidades
                .Select(h =>
                {
                    porHabilidade.TryGetValue(h.HabilidadeId, out (short? nivel, string tipo, string desc, string? just) vinculo);
                    return new ListarHabilidadePorOcupacaoDto
                    {
                        HabilidadeId = h.HabilidadeId,
                        Nome = h.Nome,
                        Codigo = h.Codigo,
                        Descricao = h.Descricao,
                        TipoRelacionamento = vinculo.tipo,
                        NivelHabilidade = vinculo.nivel,
                        DescricaoNivel = vinculo.desc,
                        Justificativa = vinculo.just,
                        PesoRelevancia = h.PesoRelevancia,
                        ClassificacaoHabilidade = h.ClassificacaoHabilidade
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

            public string? Justificativa { get; set; }
        }

        /// <summary>Ocupacao seguinte na trilha de carreira (SQL bruto, agregado sobre skills essenciais).</summary>
        public class ProximaOcupacaoTrilha
        {
            public int OcupacaoId { get; set; }

            public string Titulo { get; set; } = null!;

            public int Compartilhadas { get; set; }

            public decimal NivelMedioDestino { get; set; }

            public string? HabilidadesFaltantes { get; set; }
        }

        public async Task<List<ProximaOcupacaoTrilha>?> ListarProximasOcupacoes(int ocupacaoId)
        {
            bool existe = await _ctx.Ocupacao.AnyAsync(o => o.OcupacaoId == ocupacaoId);

            if (!existe)
                return null;

            return await _ctx.Database
                .SqlQuery<ProximaOcupacaoTrilha>($"""
                    SELECT o.ocupacao_id AS "OcupacaoId",
                           o.titulo AS "Titulo",
                           count(DISTINCT vh.habilidade_id) AS "Compartilhadas",
                           round(avg(vh.nivel_habilidade)::numeric, 1) AS "NivelMedioDestino",
                           (SELECT string_agg(f.nome, ' | ') FROM (
                                SELECT h2.nome
                                FROM esco_dataset.ocupacao_habilidade vh2
                                JOIN esco_dataset.habilidade h2 ON h2.habilidade_id = vh2.habilidade_id
                                WHERE vh2.ocupacao_id = o.ocupacao_id
                                  AND vh2.tipo_relacionamento = 'essencial'
                                  AND vh2.habilidade_id NOT IN (
                                      SELECT habilidade_id FROM esco_dataset.ocupacao_habilidade
                                      WHERE ocupacao_id = {ocupacaoId})
                                ORDER BY vh2.nivel_habilidade
                                LIMIT 5
                           ) f) AS "HabilidadesFaltantes"
                    FROM esco_dataset.ocupacao_habilidade vh
                    JOIN esco_dataset.ocupacao o ON o.ocupacao_id = vh.ocupacao_id
                    JOIN (SELECT habilidade_id
                          FROM esco_dataset.ocupacao_habilidade
                          WHERE ocupacao_id = {ocupacaoId} AND tipo_relacionamento = 'essencial') e
                         ON e.habilidade_id = vh.habilidade_id
                    WHERE vh.ocupacao_id <> {ocupacaoId}
                      AND vh.tipo_relacionamento = 'essencial'
                    GROUP BY o.ocupacao_id, o.titulo
                    HAVING avg(vh.nivel_habilidade) > (SELECT avg(nivel_habilidade) + 0.25
                                                       FROM esco_dataset.ocupacao_habilidade
                                                       WHERE ocupacao_id = {ocupacaoId} AND peso_relevancia = 5)
                    ORDER BY count(DISTINCT vh.habilidade_id) DESC
                    LIMIT 8
                    """)
                .ToListAsync();
        }

        public async Task<Ocupacao?> ObterPorId(int ocupacaoId)
            => await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .FirstOrDefaultAsync(h => h.OcupacaoId == ocupacaoId);
    }
}