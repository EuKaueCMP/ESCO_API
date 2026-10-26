using ESCO_API.Domains;

namespace ESCO_API.Interfaces
{
    public interface IColecaoRepository
    {
        public Task<List<Colecao>> Listar();
        public Task<List<Colecao>> ListarPorTermo(string palavra);
        public Task<Colecao?> ObterPorId(int colecaoId);
    }
}