using RBOSF_API.Domains;
using RBOSF_API.DTOs.HabilidadeDTO;

namespace RBOSF_API.Interfaces
{
    public interface IHabilidadeRepository
    {
        public Task<List<Habilidade>> Listar();
        public Task<List<Habilidade>> ListarPorTermo(string palavra, ClassificacaoHabilidadeEnum? classificacao = null);
        public Task<List<Habilidade>> ListarPorClassificacao(ClassificacaoHabilidadeEnum classificacao, int limite, int deslocamento);
        public Task<ResumoClassificacaoDto> ContarPorClassificacao();
        public Task<List<Habilidade>> ListarPorCodigo(string codigo);
        public Task<Habilidade?> ObterPorId(int habilidadeId);
        public Task<List<NivelHabilidade>> ListarNiveis();
        public Task<List<NivelHabilidadeDescritor>> ListarNiveisPorHabilidadeId(int habilidadeId);
    }
}