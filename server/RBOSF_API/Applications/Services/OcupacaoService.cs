using RBOSF_API.Conversions;
using RBOSF_API.DTOs.OcupacaoDTO;
using RBOSF_API.Exceptions;
using RBOSF_API.Interfaces;
using RBOSF_API.Domains;
using RBOSF_API.DTOs.HabilidadeDTO;
using RBOSF_API.Repositories;

namespace RBOSF_API.Services
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
       public async Task<List<ListarHabilidadePorOcupacaoDto>> ListarHabilidadesPorOcupacaoId(int ocupacaoId)
        {
            if(ocupacaoId <= 0)
                throw new DomainException("Insira o id de uma ocupação.");

            List<ListarHabilidadePorOcupacaoDto> habilidades = await _repository.ListarHabilidadesPorOcupacaoId(ocupacaoId)
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            return habilidades;
        }

        public async Task<ListarOcupacaoDto> ObterPorId(int ocupacaoId)
        {
            if (ocupacaoId <= 0)
                throw new DomainException("Insira um ID válido.");

            Ocupacao ocupacao = await _repository.ObterPorId(ocupacaoId)
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            return DomainToDto.OcupacaoToDto(ocupacao);
        }

        public async Task<ListarTrilhaPorOcupacaoDto> ListarTrilhaPorOcupacaoId(int ocupacaoId)
        {
            if (ocupacaoId <= 0)
                throw new DomainException("Insira o id de uma ocupação.");

            Ocupacao ocupacao = await _repository.ObterPorId(ocupacaoId)
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            List<ListarHabilidadePorOcupacaoDto> todas = await _repository.ListarHabilidadesPorOcupacaoId(ocupacaoId)
                ?? throw new DomainException("Nenhuma ocupação encontrada.");

            List<ListarHabilidadePorOcupacaoDto> essenciais = todas
                .Where(h => h.TipoRelacionamento == "essencial")
                .OrderBy(h => h.NivelHabilidade ?? 0)
                .ToList();

            List<OcupacaoRepository.ProximaOcupacaoTrilha> proximas = await _repository.ListarProximasOcupacoes(ocupacaoId) ?? new();

            decimal? nivelMedio = essenciais.Count > 0
                ? Math.Round(essenciais.Where(h => h.NivelHabilidade.HasValue)
                    .Select(h => (decimal)h.NivelHabilidade!.Value)
                    .DefaultIfEmpty(0).Average(), 1)
                : null;

            return new ListarTrilhaPorOcupacaoDto
            {
                OcupacaoId = ocupacaoId,
                Titulo = ocupacao.Titulo,
                NivelMedio = nivelMedio,
                HabilidadesEssenciais = essenciais,
                ProximasOcupacoes = proximas
                    .Select(p => new ListarProximaOcupacaoDto
                    {
                        OcupacaoId = p.OcupacaoId,
                        Titulo = p.Titulo,
                        Compartilhadas = p.Compartilhadas,
                        NivelMedioDestino = p.NivelMedioDestino,
                        HabilidadesFaltantes = p.HabilidadesFaltantes
                    })
                    .ToList()
            };
        }
    }
}
