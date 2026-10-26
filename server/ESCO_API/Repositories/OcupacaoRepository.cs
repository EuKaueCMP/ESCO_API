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
            return await _ctx.Ocupacao
                .Where(h => h.SearchVector.Matches(
                    EF.Functions.PlainToTsQuery("portuguese", termo)) ||
                    EF.Functions.TrigramsSimilarity(h.Titulo, termo) >= 0.3)
                .Include(o => o.GrupoOcupacao)
                .OrderByDescending(h => h.SearchVector.Rank(
                    EF.Functions.PlainToTsQuery("portuguese", termo)))
                .ThenByDescending(h => EF.Functions.TrigramsSimilarity(h.Titulo, termo))
                .ToListAsync();
        }

        public async Task<List<Ocupacao>?> ListarPorGrupo(int grupoId)
        {
            var grupo = await _ctx.GrupoOcupacao
                .FirstOrDefaultAsync(g => g.GrupoId == grupoId);

            if (grupo is null)
                return null;

            return grupo.Ocupacao
                .OrderBy(o => o.Titulo)
                .ToList();
        }

        public async Task<List<Habilidade>?> ListarHabilidadesPorOcupacaoId(int ocupacaoId)
        {
            var ocupacao = await _ctx.Ocupacao
                .Include(o => o.Habilidade)
                .FirstOrDefaultAsync(o => o.OcupacaoId == ocupacaoId);

            if (ocupacao is null)
                return null;

            return ocupacao.Habilidade.ToList();
        }

        public async Task<Ocupacao?> ObterPorId(int ocupacaoId)
            => await _ctx.Ocupacao
                .Include(o => o.GrupoOcupacao)
                .FirstOrDefaultAsync(h => h.OcupacaoId == ocupacaoId);
    }
}