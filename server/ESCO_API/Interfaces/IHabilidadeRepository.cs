using ESCO_API.Domains;
using ESCO_API.DTOs.HabilidadeDTO;

namespace ESCO_API.Interfaces
{
    public interface IHabilidadeRepository
    {
        public Task<List<Habilidade>> Listar();
        public Task<List<Habilidade>> ListarPorTermo(string palavra);
        public Task<List<Habilidade>> ListarPorCodigo(string codigo);
        public Task<Habilidade?> ObterPorId(int habilidadeId);
        public Task<List<NivelHabilidade>> ListarNiveis();
        public Task<List<NivelHabilidadeDescritor>> ListarNiveisPorHabilidadeId(int habilidadeId);
    }
}