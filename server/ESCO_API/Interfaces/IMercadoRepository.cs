using ESCO_API.Domains;

namespace ESCO_API.Interfaces
{
    public interface IMercadoRepository
    {
        public Task<MercadoOcupacao?> ObterOcupacao(int ocupacaoId);
        public Task<List<MercadoSalario>> ListarSalarios(int ocupacaoId);
        public Task<List<MercadoHabilidade>> ListarHabilidades(int ocupacaoId);
    }
}
