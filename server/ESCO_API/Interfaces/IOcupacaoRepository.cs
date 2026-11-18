using ESCO_API.Domains;
using ESCO_API.DTOs.OcupacaoDTO;

namespace ESCO_API.Interfaces
{
    public interface IOcupacaoRepository
    {
        public Task<List<Ocupacao>> Listar();
        public Task<List<Ocupacao>> ListarPorTermo(string palavra);
        public Task<List<ListarHabilidadePorOcupacaoDto>?> ListarHabilidadesPorOcupacaoId(int ocupacaoId);
        public Task<List<Ocupacao>?> ListarPorGrupo(int grupoId);
        public Task<Ocupacao?> ObterPorId(int OcupacaoId);
    }
}