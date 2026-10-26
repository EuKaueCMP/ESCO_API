using ESCO_API.Domains;

namespace ESCO_API.Interfaces
{
    public interface IHabilidadeRepository
    {
        public Task<List<Habilidade>> Listar();
        public Task<List<Habilidade>> ListarPorTermo(string palavra);
        public Task<Habilidade?> ObterPorId(int habilidadeId);
    }
}