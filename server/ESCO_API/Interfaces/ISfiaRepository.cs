using ESCO_API.Domains;

namespace ESCO_API.Interfaces
{
    public interface ISfiaRepository
    {
        public Task<List<SfiaAtributo>> ListarAtributos();
        public Task<SfiaAtributo?> ObterAtributo(string slug);
        public Task<List<SfiaView>> ListarViews();
        public Task<SfiaView?> ObterView(int viewId);
    }
}
