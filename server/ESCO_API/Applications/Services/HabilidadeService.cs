using ESCO_API.Conversions;
using ESCO_API.Domains;
using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.Excptions;
using ESCO_API.Interfacies;

namespace ESCO_API.Services
{
    public class HabilidadeService
    {
        private readonly IHabilidadeRepository _repository;
        
        public HabilidadeService(IHabilidadeRepository repository) => _repository = repository;

        public async Task<List<ListarHabilidadeDto>> Listar()
        {
            List<Habilidade> habilidades = await _repository.Listar()
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }

        public async Task<List<ListarHabilidadeDto>> ListarPorTermo(string termo)
        {
            if (string.IsNullOrWhiteSpace(termo))
                throw new DomainException("Insira um termo.");

            List<Habilidade> habilidades = await _repository.ListarPorTermo(termo)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }



        public async Task<ListarHabilidadeDto> ObterPorId(int habilidadeId)
        {
            if (habilidadeId <= 0)
                throw new DomainException("Insira um ID válido.");

            Habilidade habilidade = await _repository.ObterPorId(habilidadeId)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return DomainToDto.HabilidadeToDto(habilidade);
        }
    }
}
