using RBOSF_API.Exceptions;
using RBOSF_API.Interfaces;
using RBOSF_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace RBOSF_API.Controllers
{
    [ApiController]
    [Route("rbosfapi/v1/busca")]
    public class BuscaController : ControllerBase
    {
        private readonly BuscaService _service;
        public BuscaController(BuscaService service) => _service = service;

        /// <summary>Busca fuzzy por habilidades e ocupações (pg_trgm, tolerante a erros de digitação).</summary>
        /// <param name="termo">Termo a pesquisar (mínimo 3 caracteres).</param>
        /// <returns>Até 20 resultados ordenados por similaridade, marcados como 'habilidade' ou 'ocupacao'.</returns>
        /// <response code="200">Resultados retornados com sucesso.</response>
        /// <response code="404">Nenhum resultado encontrado ou termo inválido.</response>
        [HttpGet]
        [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Buscar([FromQuery] string? termo)
        {
            try
            {
                return Ok(await _service.Buscar(termo));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
