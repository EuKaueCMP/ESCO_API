using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfacies;
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
                .OrderBy(h => h.Titulo)
                .ToListAsync();

        public async Task<List<Ocupacao>> ListarPorTermo(string termo)
        {
            var termoBuscado = EF.Functions.PlainToTsQuery("portuguese", termo);

            return await _ctx.Ocupacao
                .Where(h => h.SearchVector.Matches(termoBuscado) ||
                    EF.Functions.TrigramsSimilarity(h.Titulo, termo) >= 0.3)
                .Include(o => o.GrupoOcupacao)
                .OrderByDescending(h => h.SearchVector.Rank(termoBuscado))
                .ThenByDescending(h => EF.Functions.TrigramsSimilarity(h.Titulo, termo) >= 0.3)
                .ToListAsync();
        }

        public async Task<List<Ocupacao>> ListarPorGrupo(int grupoId)
        {
            GrupoOcupacao grupo = await _ctx.GrupoOcupacao
                .FirstAsync(g => g.GrupoId == grupoId);

            return grupo.Ocupacao
                .OrderBy(o => o.Titulo)
                .ToList();
        }

        public async Task<Ocupacao> ObterPorId(int ocupacaoId)
            => await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .FirstAsync(h => h.OcupacaoId == ocupacaoId);
    }
}