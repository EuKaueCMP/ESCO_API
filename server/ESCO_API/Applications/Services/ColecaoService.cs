using ESCO_API.Conversions;
using ESCO_API.DTOs.ColecaoDTO;
using ESCO_API.Excptions;
using ESCO_API.Interfacies;

namespace ESCO_API.Services
{
    public class ColecaoService
    {
        private readonly IColecaoRepository _repository;
        public ColecaoService(IColecaoRepository repository)
            => _repository = repository;

        public async Task<List<ListarColecaoDto>> Listar()
        {
            List<Colecao> colecoes = await _repository.Listar()
                 ?? throw new DomainException("Nenhuma colecao encontrada.");

            return colecoes.Select(c => DomainToDto.ColecaoToDto(c)).ToList();
        }

        public async Task<List<ListarColecaoDto>> ListarPorTermo(string termo)
        {
            if (string.IsNullOrWhiteSpace(termo))
                throw new DomainException("Insira um termo.");

            List<Colecao> colecoes = await _repository.ListarPorTermo(termo)
                ?? throw new DomainException("Nenhuma colecao encontrada.");

            return colecoes.Select(c => DomainToDto.ColecaoToDto(c)).ToList();
        }

        public async Task<ListarColecaoDto> ObterPorId(int colecaoId)
        {
            if(colecaoId <= 0)
                throw new DomainException("Insira um id válido.");

            Colecao colecao = await _repository.ObterPorId(colecaoId) 
                ?? throw new DomainException("Nenhuma colecao encontrada.");

            return DomainToDto.ColecaoToDto(colecao);
        }
    }
}