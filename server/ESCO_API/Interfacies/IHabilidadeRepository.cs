using ESCO_API.Domains;

namespace ESCO_API.Interfacies
{
    public interface IHabilidadeRepository
    {
        public Task<List<Habilidade>> Listar();
        public Task<List<Habilidade>> ListarPorTermo(string palavra);
        public Task<List<Habilidade>> LitarPorOcupacao(int ocupacaoId);
        public Task<Habilidade> ObterPorId(int habilidadeId);
    }
}