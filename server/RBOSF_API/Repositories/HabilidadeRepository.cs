using RBOSF_API.Contexts;
using RBOSF_API.Domains;
using RBOSF_API.Interfaces;
using RBOSF_API.DTOs.HabilidadeDTO;
using Microsoft.EntityFrameworkCore;

namespace RBOSF_API.Repositories
{
    public class HabilidadeRepository : IHabilidadeRepository
    {
        private readonly RbosfContext _ctx;
        public HabilidadeRepository(RbosfContext ctx) => _ctx = ctx;

        public async Task<List<Habilidade>> Listar() 
            => await _ctx.Habilidade
                .OrderByDescending(h => h.PesoRelevancia ?? 0)
                .ThenBy(h => h.Nome)
                .ToListAsync();

        public async Task<List<Habilidade>> ListarPorTermo(string termo, ClassificacaoHabilidadeEnum? classificacao = null)
        {
            IQueryable<Habilidade> query = _ctx.Habilidade
                .Where(h => h.SearchVector.Matches(
                    EF.Functions.PlainToTsQuery("portuguese", termo)) ||
                    EF.Functions.TrigramsSimilarity(h.Nome, termo) >= 0.3);

            if (classificacao.HasValue)
                query = query.Where(h => h.ClassificacaoHabilidade == classificacao.Value);

            return await query
                .OrderByDescending(h => h.SearchVector.Rank(
                    EF.Functions.PlainToTsQuery("portuguese", termo)))
                .ThenByDescending(h => EF.Functions.TrigramsSimilarity(h.Nome, termo))
                .ThenByDescending(h => h.PesoRelevancia ?? 0)
                .ToListAsync();
        }

        public async Task<List<Habilidade>> ListarPorClassificacao(ClassificacaoHabilidadeEnum classificacao, int limite, int deslocamento)
            => await _ctx.Habilidade
                .Where(h => h.ClassificacaoHabilidade == classificacao)
                .OrderByDescending(h => h.PesoRelevancia ?? 0)
                .ThenBy(h => h.Nome)
                .Skip(deslocamento)
                .Take(limite)
                .ToListAsync();

        public async Task<ResumoClassificacaoDto> ContarPorClassificacao()
        {
            int hard = await _ctx.Habilidade.CountAsync(h => h.ClassificacaoHabilidade == ClassificacaoHabilidadeEnum.hardskill);
            int soft = await _ctx.Habilidade.CountAsync(h => h.ClassificacaoHabilidade == ClassificacaoHabilidadeEnum.softskill);
            int grupos = await _ctx.Habilidade.CountAsync(h => h.TipoConceito == TipoConceitoEnum.grupo_habilidade);

            return new ResumoClassificacaoDto
            {
                HardSkill = hard,
                SoftSkill = soft,
                Total = hard + soft,
                Grupos = grupos
            };
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