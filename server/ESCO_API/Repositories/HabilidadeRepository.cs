using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfacies;
using Microsoft.EntityFrameworkCore;

namespace ESCO_API.Repositories
{
    public class HabilidadeRepository : IHabilidadeRepository
    {
        private readonly EscoContext _ctx;
        public HabilidadeRepository(EscoContext ctx) => _ctx = ctx;

        public async Task<List<Habilidade>> Listar() 
            => await _ctx.Habilidade
                .OrderBy(h => h.Nome)
                .ToListAsync();

        public async Task<List<Habilidade>> ListarPorTermo(string termo)
        {
            return await _ctx.Habilidade
                .Where(h => h.SearchVector.Matches(
                    EF.Functions.PlainToTsQuery("portuguese", termo)) ||
                    EF.Functions.TrigramsSimilarity(h.Nome, termo) >= 0.3)
                .OrderByDescending(h => h.SearchVector.Rank(
                    EF.Functions.PlainToTsQuery("portuguese", termo)))
                .ThenByDescending(h => EF.Functions.TrigramsSimilarity(h.Nome, termo))
                .ToListAsync();
        }

        public async Task<Habilidade?> ObterPorId(int habilidadeId) 
            => await _ctx.Habilidade.FirstOrDefaultAsync(h => h.HabilidadeId == habilidadeId);
    }
}