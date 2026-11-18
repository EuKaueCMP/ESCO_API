using RBOSF_API.Domains;

namespace RBOSF_API.Interfaces
{
    /// <summary>Resultado de busca fuzzy (pg_trgm) por habilidades e ocupacoes.</summary>
    public class ResultadoBusca
    {
        public int Id { get; set; }

        public string Nome { get; set; } = null!;

        public string? Codigo { get; set; }

        public string Tipo { get; set; } = null!;

        public double Score { get; set; }
    }

    public interface IBuscaRepository
    {
        public Task<List<ResultadoBusca>> Buscar(string termo);
    }
}
