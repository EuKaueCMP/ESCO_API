using RBOSF_API.Contexts;
using RBOSF_API.Domains;
using RBOSF_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace RBOSF_API.Repositories
{
    public class ColecaoRepository : IColecaoRepository
    {
        private readonly RbosfContext _ctx;
        public ColecaoRepository(RbosfContext ctx) => _ctx = ctx;

        public async Task<List<Colecao>> Listar() 
            => await _ctx.Colecao.ToListAsync();

        public async Task<List<Colecao>> ListarPorTermo(string termo)
        {
            return await _ctx.Colecao
                .Where(c =>
                    c.SearchVector.Matches(
                        EF.Functions.PlainToTsQuery("portuguese", termo)) ||
                    EF.Functions.TrigramsSimilarity(c.Nome, termo) >= 0.3)
                .OrderByDescending(c => c.SearchVector.Rank(
                    EF.Functions.PlainToTsQuery("portuguese", termo)))
                .ThenByDescending(c =>
                    EF.Functions.TrigramsSimilarity(c.Nome, termo))
                .ToListAsync();
        }

        public async Task<Colecao?> ObterPorId(int colecaoId) 
            => await _ctx.Colecao.FirstOrDefaultAsync(c => c.ColecaoId == colecaoId); 
    }
}