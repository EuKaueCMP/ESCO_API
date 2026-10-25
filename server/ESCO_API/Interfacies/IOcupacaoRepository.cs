using ESCO_API.Domains;

namespace ESCO_API.Interfacies
{
    public interface IOcupacaoRepository
    {
        public Task<List<Ocupacao>> Listar();
        public Task<List<Ocupacao>> ListarPorTermo(string palavra);
        public Task<List<Ocupacao>> ListarHabilidadesPorOcupacaoId(int ocupacaoId);
        public Task<List<Ocupacao>> ListarPorGrupo(int grupoId);
        public Task<Ocupacao> ObterPorId(int OcupacaoId);
    }
}