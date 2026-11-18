using ESCO_API.Domains;
using ESCO_API.Exceptions;
using ESCO_API.Interfaces;

namespace ESCO_API.Services
{
    public class BuscaService
    {
        private readonly IBuscaRepository _repository;
        public BuscaService(IBuscaRepository repository) => _repository = repository;

        public async Task<List<ResultadoBusca>> Buscar(string? termo)
        {
            if (string.IsNullOrWhiteSpace(termo) || termo.Length < 3)
                throw new DomainException("Insira um termo com pelo menos 3 caracteres.");

            List<ResultadoBusca> resultados = await _repository.Buscar(termo.Trim());

            if (resultados.Count == 0)
                throw new DomainException("Nenhum resultado encontrado.");

            return resultados;
        }
    }
}
