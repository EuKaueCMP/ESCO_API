
using ESCO_API.Conversions;
using ESCO_API.Domains;
using ESCO_API.DTOs.GrupoOcupacaoDTO;
using ESCO_API.Excptions;
using ESCO_API.Interfacies;

namespace ESCO_API.Services
{
    public class GrupoOcupacaoService
    {
        private readonly IGrupoOcupacaoRepository _repository;

        public GrupoOcupacaoService(IGrupoOcupacaoRepository repository)
            => _repository = repository;

        public async Task<List<ListarGrupoOcupacaoDto>> Listar()
        {
            List<GrupoOcupacao> grupos = await _repository.Listar()
                ?? throw new DomainException("Nenhum grupo de ocupação encontrado.");

            return grupos
                .Select(g => DomainToDto.GrupoOcupacaoToDto(g))
                .ToList();
        }

        public async Task<List<ListarGrupoOcupacaoDto>> ListarPorTermo(string termo)
        {
            if (string.IsNullOrWhiteSpace(termo))
                throw new DomainException("Insira um termo.");

            List<GrupoOcupacao> grupos = await _repository.ListarPorTermo(termo)
                ?? throw new DomainException("Nenhum grupo de ocupação encontrado.");

            return grupos
                .Select(g => DomainToDto.GrupoOcupacaoToDto(g))
                .ToList();
        }

        public async Task<ListarGrupoOcupacaoDto> ObterPorId(int grupoId)
        {
            if (grupoId <= 0)
                throw new DomainException("Insira um ID válido.");

            GrupoOcupacao grupo = await _repository.ObterPorId(grupoId)
                ?? throw new DomainException("Nenhum grupo de ocupação encontrado.");

            return DomainToDto.GrupoOcupacaoToDto(grupo);
        }
    }
}
