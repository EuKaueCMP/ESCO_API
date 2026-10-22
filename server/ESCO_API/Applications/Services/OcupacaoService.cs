using ESCO_API.Conversions;
using ESCO_API.DTOs.OcupacaoDTO;
using ESCO_API.Excptions;
using ESCO_API.Interfacies;

namespace ESCO_API.Services
{
    public class OcupacaoService
    {
        private readonly IOcupacaoRepository _repository;

        public OcupacaoService(IOcupacaoRepository repository)
            => _repository = repository;

        public async Task<List<ListarOcupacaoDto>> Listar()
        {
            List<Ocupacao> ocupacoes = await _repository.Listar()
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            return ocupacoes
                .Select(o => DomainToDto.OcupacaoToDto(o))
                .ToList();
        }

        public async Task<List<ListarOcupacaoDto>> ListarPorTermo(string termo)
        {
            if (string.IsNullOrWhiteSpace(termo))
                throw new DomainException("Insira um termo.");

            List<Ocupacao> ocupacoes = await _repository.ListarPorTermo(termo)
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            return ocupacoes
                .Select(o => DomainToDto.OcupacaoToDto(o))
                .ToList();
        }

        public async Task<List<ListarOcupacaoDto>> ListarPorGrupo(int grupoId)
        {
            if (grupoId <= 0)
                throw new DomainException("Insira um ID de grupo válido.");

            List<Ocupacao> ocupacoes = await _repository.ListarPorGrupo(grupoId)
                ?? throw new DomainException("Nenhuma ocupação encontrada para este grupo.");

            return ocupacoes
                .Select(o => DomainToDto.OcupacaoToDto(o))
                .ToList();
        }

        public async Task<ListarOcupacaoDto> ObterPorId(int ocupacaoId)
        {
            if (ocupacaoId <= 0)
                throw new DomainException("Insira um ID válido.");

            Ocupacao ocupacao = await _repository.ObterPorId(ocupacaoId)
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            return DomainToDto.OcupacaoToDto(ocupacao);
        }
    }
}
