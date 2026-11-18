using RBOSF_API.Contexts;
using RBOSF_API.Interfaces;
using RBOSF_API.Domains;
using Microsoft.EntityFrameworkCore;

namespace RBOSF_API.Repositories
{
    public class BuscaRepository : IBuscaRepository
    {
        private readonly RbosfContext _ctx;
        public BuscaRepository(RbosfContext ctx) => _ctx = ctx;

        public async Task<List<ResultadoBusca>> Buscar(string termo)
            => await _ctx.Database
                .SqlQuery<ResultadoBusca>($"""
                    SELECT * FROM (
                        SELECT h.habilidade_id AS "Id",
                               h.nome AS "Nome",
                               h.codigo AS "Codigo",
                               'habilidade' AS "Tipo",
                               word_similarity(h.nome, {termo}) AS "Score"
                        FROM esco_dataset.habilidade h
                        WHERE h.tipo_conceito = 'habilidade'
                          AND h.nome % {termo}::text
                        UNION ALL
                        SELECT o.ocupacao_id,
                               o.titulo,
                               NULL::text,
                               'ocupacao',
                               word_similarity(o.titulo, {termo})
                        FROM esco_dataset.ocupacao o
                        WHERE o.titulo % {termo}::text
                    ) r
                    ORDER BY r."Score" DESC
                    LIMIT 20
                    """)
                .ToListAsync();
    }
}
