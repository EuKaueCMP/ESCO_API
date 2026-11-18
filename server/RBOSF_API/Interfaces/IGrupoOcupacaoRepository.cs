using RBOSF_API.Domains;

namespace RBOSF_API.Interfaces
{
    public interface IGrupoOcupacaoRepository
    {
        public Task<List<GrupoOcupacao>> Listar();
        public Task<List<GrupoOcupacao>> ListarPorTermo(string palavra);
        public Task<GrupoOcupacao?> ObterPorId(int grupoOcupacaoId);
    }
}