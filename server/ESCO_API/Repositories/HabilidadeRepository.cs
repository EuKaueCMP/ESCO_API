using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ESCO_API.Repositories
{
    public class HabilidadeRepository : IHabilidadeRepository
    {
        private readonly EscoContext _ctx;
        public HabilidadeRepository(EscoContext ctx) => _ctx = ctx;

        public async Task<List<Habilidade>> Listar() 
            => await _ctx.Habilidade
                .OrderByDescending(h => h.PesoRelevancia ?? 0)
                .ThenBy(h => h.Nome)
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
                .ThenByDescending(h => h.PesoRelevancia ?? 0)
                .ToListAsync();
        }

        public async Task<Habilidade?> ObterPorId(int habilidadeId) 
            => await _ctx.Habilidade.FirstOrDefaultAsync(h => h.HabilidadeId == habilidadeId);

        public async Task<List<Habilidade>> ListarPorCodigo(string codigo)
        {
            string termo = codigo.Trim().ToUpper();

            return await _ctx.Habilidade
                .Where(h => h.Codigo == termo ||
                            h.Codigo!.StartsWith(termo) ||
                            h.SearchVector.Matches(
                                EF.Functions.PlainToTsQuery("portuguese", termo)))
                .OrderBy(h => h.Codigo == termo ? 0 : 1)
                .ThenBy(h => h.Nome)
                .ToListAsync();
        }

        public async Task<List<NivelHabilidade>> ListarNiveis()
            => await _ctx.NivelHabilidade
                .OrderBy(n => n.Nivel)
                .ToListAsync();

        public async Task<List<NivelHabilidadeDescritor>> ListarNiveisPorHabilidadeId(int habilidadeId)
            => await _ctx.NivelHabilidadeDescritor
                .Include(d => d.NivelHabilidade)
                .Where(d => d.HabilidadeId == habilidadeId)
                .OrderBy(d => d.Nivel)
                .ToListAsync();
    }
}