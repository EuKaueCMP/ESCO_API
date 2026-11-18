using RBOSF_API.Domains;
using RBOSF_API.DTOs.OcupacaoDTO;
using RBOSF_API.Repositories;

namespace RBOSF_API.Interfaces
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