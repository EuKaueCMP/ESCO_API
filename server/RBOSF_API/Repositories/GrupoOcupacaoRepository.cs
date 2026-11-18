using RBOSF_API.Contexts;
using RBOSF_API.Domains;
using RBOSF_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace RBOSF_API.Repositories
{
    public class GrupoOcupacaoRepository : IGrupoOcupacaoRepository
    {
        private readonly RbosfContext _ctx;
        public GrupoOcupacaoRepository(RbosfContext ctx) => _ctx = ctx;

        public async Task<List<GrupoOcupacao>> Listar() 
            => await _ctx.GrupoOcupacao
                .OrderBy(g => g.Nome)
                .ToListAsync();

        public async Task<List<GrupoOcupacao>> ListarPorTermo(string termo)
        {
            return await _ctx.GrupoOcupacao
                .Where(g => g.SearchVector.Matches(
                    EF.Functions.PlainToTsQuery("portuguese", termo)) ||
                    EF.Functions.TrigramsSimilarity(g.Nome, termo) >= 0.3)
                .OrderByDescending(g => g.SearchVector.Rank(
                    EF.Functions.PlainToTsQuery("portuguese", termo)))
                .ThenByDescending(g => EF.Functions.TrigramsSimilarity(g.Nome, termo))
                .ToListAsync();
        }

        public async Task<GrupoOcupacao?> ObterPorId(int grupoId) 
            => await _ctx.GrupoOcupacao.FirstOrDefaultAsync(g => g.GrupoId == grupoId);
    }
}