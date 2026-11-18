using ESCO_API.Domains;
using ESCO_API.DTOs.OcupacaoDTO;
using ESCO_API.Repositories;

namespace ESCO_API.Interfaces
{
    public interface IOcupacaoRepository
    {
        public Task<List<Ocupacao>> Listar();
        public Task<List<Ocupacao>> ListarPorTermo(string palavra);
        public Task<List<ListarHabilidadePorOcupacaoDto>?> ListarHabilidadesPorOcupacaoId(int ocupacaoId);
        public Task<List<Ocupacao>?> ListarPorGrupo(int grupoId);
        public Task<List<OcupacaoRepository.ProximaOcupacaoTrilha>?> ListarProximasOcupacoes(int ocupacaoId);
        public Task<Ocupacao?> ObterPorId(int OcupacaoId);
    }
}