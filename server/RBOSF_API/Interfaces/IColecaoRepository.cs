using RBOSF_API.Domains;

namespace RBOSF_API.Interfaces
{
    public interface IColecaoRepository
    {
        public Task<List<Colecao>> Listar();
        public Task<List<Colecao>> ListarPorTermo(string palavra);
        public Task<Colecao?> ObterPorId(int colecaoId);
    }
}