using RBOSF_API.Domains;

namespace RBOSF_API.Interfaces
{
    public interface ISfiaRepository
    {
        public Task<List<SfiaAtributo>> ListarAtributos();
        public Task<SfiaAtributo?> ObterAtributo(string slug);
        public Task<List<SfiaView>> ListarViews();
        public Task<SfiaView?> ObterView(int viewId);
        public Task<List<SfiaAtributoNivel>> ListarFrasesAtributo(short nivel);
    }
}
