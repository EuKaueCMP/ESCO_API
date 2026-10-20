using ESCO_API.Domains;

namespace ESCO_API.Interfacies
{
    public interface IOcupacaoRepository
    {
        public Task<List<Ocupacao>> Listar();
        public Task<List<Ocupacao>> ListarPorPalavraChave(string palavra);
        public Task<List<Ocupacao>> ListrarPorGrupoId(int grupoId);
        public Task<Ocupacao> ObterPorId(int OcupacaoId);
    }
}