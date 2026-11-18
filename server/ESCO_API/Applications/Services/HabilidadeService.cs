using ESCO_API.Conversions;
using ESCO_API.Domains;
using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.Exceptions;
using ESCO_API.Interfaces;

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

        public async Task<List<ListarHabilidadeDto>> ListarPorCodigo(string codigo)
        {
            if (string.IsNullOrWhiteSpace(codigo))
                throw new DomainException("Insira um código.");

            codigo = codigo.Trim();

            if (codigo.Length < 3 || codigo.Length > 8)
                throw new DomainException("Insira um código com 3 a 8 caracteres.");

            List<Habilidade> habilidades = await _repository.ListarPorCodigo(codigo)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }

        public async Task<List<ListarNivelHabilidadeDto>> ListarNiveis()
        {
            List<NivelHabilidade> niveis = await _repository.ListarNiveis()
                ?? throw new DomainException("Nenhum nível de habilidade encontrado.");

            return niveis
                .Select(n => DomainToDto.NivelHabilidadeToDto(n))
                .ToList();
        }

        public async Task<List<ListarNiveisPorHabilidadeDto>> ListarNiveisPorHabilidadeId(int habilidadeId)
        {
            if (habilidadeId <= 0)
                throw new DomainException("Insira o id de uma habilidade.");

            Habilidade habilidade = await _repository.ObterPorId(habilidadeId)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            List<NivelHabilidadeDescritor> descritores = await _repository.ListarNiveisPorHabilidadeId(habilidadeId);

            if (descritores.Count == 0)
                throw new DomainException("Esta habilidade não possui descritores de nível publicados.");

            return descritores
                .Select(d => new ListarNiveisPorHabilidadeDto
                {
                    Nivel = d.Nivel,
                    NomeNivel = d.NivelHabilidade.Nome,
                    DescricaoNivel = d.NivelHabilidade.Descricao,
                    Descritor = d.Descricao,
                    Origem = d.Origem
                })
                .ToList();
        }
    }
}
