using ESCO_API.Contexts;
using ESCO_API.Domains;
using ESCO_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ESCO_API.Repositories
{
    public class MercadoRepository : IMercadoRepository
    {
        private readonly EscoContext _ctx;
        public MercadoRepository(EscoContext ctx) => _ctx = ctx;

        public async Task<MercadoOcupacao?> ObterOcupacao(int ocupacaoId)
            => await _ctx.MercadoOcupacao
                .Include(m => m.Ocupacao)
                .FirstOrDefaultAsync(m => m.OcupacaoId == ocupacaoId);

        public async Task<List<MercadoSalario>> ListarSalarios(int ocupacaoId)
            => await _ctx.MercadoSalario
                .Include(s => s.NivelHabilidade)
                .Where(s => s.OcupacaoId == ocupacaoId)
                .OrderBy(s => s.Nivel)
                .ToListAsync();

        public async Task<List<MercadoHabilidade>> ListarHabilidades(int ocupacaoId)
            => await _ctx.MercadoHabilidade
                .Include(m => m.Habilidade)
                .Where(m => m.OcupacaoId == ocupacaoId)
                .OrderByDescending(m => m.Vagas)
                .ToListAsync();
    }
}
