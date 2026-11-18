using ESCO_API.Domains;
using ESCO_API.DTOs.SfiaDTO;
using ESCO_API.Exceptions;
using ESCO_API.Interfaces;

namespace ESCO_API.Services
{
    public class SfiaService
    {
        private readonly ISfiaRepository _repository;
        public SfiaService(ISfiaRepository repository) => _repository = repository;

        public async Task<List<ListarSfiaAtributoDto>> ListarAtributos()
        {
            List<SfiaAtributo> atributos = await _repository.ListarAtributos()
                ?? throw new DomainException("Nenhum atributo genérico encontrado.");

            return atributos
                .Select(a => new ListarSfiaAtributoDto
                {
                    Slug = a.Slug,
                    Codigo = a.Codigo,
                    Nome = a.NomePt ?? a.NomeEn
                })
                .ToList();
        }

        public async Task<List<ListarSfiaAtributoNivelDto>> ListarNiveisDoAtributo(string slug)
        {
            SfiaAtributo? atributo = await _repository.ObterAtributo(slug)
                ?? throw new DomainException("Nenhum atributo genérico encontrado.");

            if (atributo.Niveis.Count == 0)
                throw new DomainException("Este atributo não possui níveis publicados.");

            return atributo.Niveis
                .Select(n => new ListarSfiaAtributoNivelDto
                {
                    Nivel = n.Nivel,
                    NomeNivel = n.NivelHabilidade.Nome,
                    Descricao = n.DescricaoPt ?? n.DescricaoEn ?? string.Empty
                })
                .ToList();
        }

        public async Task<List<ListarSfiaViewDto>> ListarViews()
        {
            List<SfiaView> views = await _repository.ListarViews()
                ?? throw new DomainException("Nenhuma view encontrada.");

            return views
                .Select(v => new ListarSfiaViewDto
                {
                    ViewId = v.ViewId,
                    Caminho = v.Caminho,
                    SlugPai = v.SlugPai,
                    Nome = v.NomePt ?? v.NomeEn,
                    Profundidade = v.Profundidade
                })
                .ToList();
        }

        public async Task<(ListarSfiaViewDto view, List<ListarSfiaViewHabilidadeDto> habilidades)> ObterView(int viewId)
        {
            if (viewId <= 0)
                throw new DomainException("Insira um id de view válido.");

            SfiaView? view = await _repository.ObterView(viewId)
                ?? throw new DomainException("Nenhuma view encontrada.");

            var dto = new ListarSfiaViewDto
            {
                ViewId = view.ViewId,
                Caminho = view.Caminho,
                SlugPai = view.SlugPai,
                Nome = view.NomePt ?? view.NomeEn,
                Profundidade = view.Profundidade
            };

            List<ListarSfiaViewHabilidadeDto> habilidades = view.Habilidades
                .Where(vh => vh.Habilidade != null)
                .Select(vh => new ListarSfiaViewHabilidadeDto
                {
                    HabilidadeId = vh.HabilidadeId,
                    Nome = vh.Habilidade!.Nome,
                    Codigo = vh.Habilidade.Codigo,
                    PesoRelevancia = vh.Habilidade.PesoRelevancia
                })
                .ToList();

            return (dto, habilidades);
        }
    }
}
