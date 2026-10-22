using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfacies;
using Microsoft.EntityFrameworkCore;

namespace ESCO_API.Repositories
{
    public class ColecaoRepository : IColecaoRepository
    {
        private readonly EscoContext _ctx;
        public ColecaoRepository(EscoContext ctx) => _ctx = ctx;

        public async Task<List<Colecao>> Listar() 
            => await _ctx.Colecao.ToListAsync();

        public async Task<List<Colecao>> ListarPorTermo(string termo)
        {
            var termoBuscado = EF.Functions.PlainToTsQuery("portuguese", termo);

            return await _ctx.Colecao
                .Where(c =>
                    c.SearchVector.Matches(termoBuscado) ||
                    EF.Functions.TrigramsSimilarity(c.Nome, termo) >= 0.3)
                .OrderByDescending(c => c.SearchVector.Rank(termoBuscado))
                .ThenByDescending(c =>
                    EF.Functions.TrigramsSimilarity(c.Nome, termo))
                .ToListAsync();
        }

        public async Task<Colecao> ObterPorId(int colecaoId) 
            => await _ctx.Colecao.FirstAsync(c => c.ColecaoId == colecaoId); 
    }
}