using RBOSF_API.Contexts;
using RBOSF_API.Domains;
using RBOSF_API.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace RBOSF_API.Repositories
{
    public class SfiaRepository : ISfiaRepository
    {
        private readonly RbosfContext _ctx;
        public SfiaRepository(RbosfContext ctx) => _ctx = ctx;

        public async Task<List<SfiaAtributo>> ListarAtributos()
            => await _ctx.SfiaAtributo.OrderBy(a => a.NomePt).ToListAsync();

        public async Task<SfiaAtributo?> ObterAtributo(string slug)
            => await _ctx.SfiaAtributo
                .Include(a => a.Niveis.OrderBy(n => n.Nivel))
                .ThenInclude(n => n.NivelHabilidade)
                .FirstOrDefaultAsync(a => a.Slug == slug);

        public async Task<List<SfiaView>> ListarViews()
            => await _ctx.SfiaView
                .OrderBy(v => v.Caminho)
                .ToListAsync();

        public async Task<SfiaView?> ObterView(int viewId)
        {
            SfiaView? view = await _ctx.SfiaView
                .FirstOrDefaultAsync(v => v.ViewId == viewId);

            if (view is null)
                return null;

            string prefixo = view.Caminho + "/";
            List<SfiaViewHabilidade> vinculos = await _ctx.SfiaViewHabilidade
                .Include(vh => vh.Habilidade)
                .Where(vh => vh.Caminho == view.Caminho || vh.Caminho.StartsWith(prefixo))
                .ToListAsync();

            view.Habilidades = vinculos
                .GroupBy(vh => vh.HabilidadeId)
                .Select(g => g.First())
                .OrderBy(vh => vh.Habilidade!.Nome)
                .ToList();

            return view;
        }
   
        public async Task<List<SfiaAtributoNivel>> ListarFrasesAtributo(short nivel)
            => await _ctx.SfiaAtributoNivel
                .Include(n => n.Atributo)
                .Where(n => n.Nivel == nivel
                    && (n.Slug == "autonomy" || n.Slug == "complexity" || n.Slug == "influence"))
                .ToListAsync();
    }
}
