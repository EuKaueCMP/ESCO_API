using RBOSF_API.Contexts;
using RBOSF_API.Domains;
using RBOSF_API.DTOs.OcupacaoDTO;
using RBOSF_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace RBOSF_API.Repositories
{
    public class OcupacaoRepository : IOcupacaoRepository
    {
        private readonly RbosfContext _ctx;
        public OcupacaoRepository(RbosfContext ctx) => _ctx = ctx;

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
                .AsNoTracking()
                .FirstOrDefaultAsync(g => g.GrupoId == grupoId);

            if (grupo is null)
                return null;

            return await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .Where(o => o.GrupoOcupacao.Codigo.StartsWith(grupo.Codigo))
                .OrderByDescending(o => o.PesoRelevancia)
                .ThenBy(o => o.Titulo)
                .ToListAsync();
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
                    WITH alvo AS (
                        SELECT habilidade_id
                        FROM esco_dataset.ocupacao_habilidade
                        WHERE ocupacao_id = {ocupacaoId}
                          AND tipo_relacionamento = 'essencial'
                    ), alvo_todas AS (
                        SELECT habilidade_id
                        FROM esco_dataset.ocupacao_habilidade
                        WHERE ocupacao_id = {ocupacaoId}
                    ), alvo_media AS (
                        SELECT avg(nivel_habilidade) + 0.25 AS limite
                        FROM esco_dataset.ocupacao_habilidade
                        WHERE ocupacao_id = {ocupacaoId}
                    ), candidatas AS (
                        SELECT vh.ocupacao_id,
                               count(DISTINCT vh.habilidade_id) AS compartilhadas,
                               round(avg(vh.nivel_habilidade)::numeric, 1) AS nivel_medio
                        FROM esco_dataset.ocupacao_habilidade vh
                        JOIN alvo ON alvo.habilidade_id = vh.habilidade_id
                        JOIN esco_dataset.ocupacao o ON o.ocupacao_id = vh.ocupacao_id
                        WHERE vh.ocupacao_id <> {ocupacaoId}
                          AND vh.tipo_relacionamento = 'essencial'
                          AND o.peso_relevancia = 5
                        GROUP BY vh.ocupacao_id
                        HAVING avg(vh.nivel_habilidade) > (SELECT limite FROM alvo_media)
                        ORDER BY compartilhadas DESC
                        LIMIT 8
                    )
                    SELECT o.ocupacao_id AS "OcupacaoId",
                           o.titulo AS "Titulo",
                           c.compartilhadas AS "Compartilhadas",
                           c.nivel_medio AS "NivelMedioDestino",
                           (SELECT string_agg(f.nome, ' | ') FROM (
                                SELECT h2.nome
                                FROM esco_dataset.ocupacao_habilidade vh2
                                JOIN esco_dataset.habilidade h2 ON h2.habilidade_id = vh2.habilidade_id
                                WHERE vh2.ocupacao_id = c.ocupacao_id
                                  AND vh2.tipo_relacionamento = 'essencial'
                                  AND NOT EXISTS (
                                      SELECT 1 FROM alvo_todas
                                      WHERE alvo_todas.habilidade_id = vh2.habilidade_id)
                                ORDER BY vh2.nivel_habilidade, h2.nome
                                LIMIT 5
                           ) f) AS "HabilidadesFaltantes"
                    FROM candidatas c
                    JOIN esco_dataset.ocupacao o ON o.ocupacao_id = c.ocupacao_id
                    ORDER BY c.compartilhadas DESC
                    """)
                .ToListAsync();
        }

        public async Task<Ocupacao?> ObterPorId(int ocupacaoId)
            => await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .FirstOrDefaultAsync(h => h.OcupacaoId == ocupacaoId);
    }
}