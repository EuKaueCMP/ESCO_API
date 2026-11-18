using RBOSF_API.Domains;

namespace RBOSF_API.Interfaces
{
    public interface IMercadoRepository
    {
        public Task<MercadoOcupacao?> ObterOcupacao(int ocupacaoId);
        public Task<List<MercadoSalario>> ListarSalarios(int ocupacaoId);
        public Task<List<MercadoHabilidade>> ListarHabilidades(int ocupacaoId);
    }
}
