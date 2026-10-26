using ESCO_API.Domains;

namespace ESCO_API.Interfaces
{
    public interface IGrupoOcupacaoRepository
    {
        public Task<List<GrupoOcupacao>> Listar();
        public Task<List<GrupoOcupacao>> ListarPorTermo(string palavra);
        public Task<GrupoOcupacao?> ObterPorId(int grupoOcupacaoId);
    }
}