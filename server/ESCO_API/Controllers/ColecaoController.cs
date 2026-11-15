using ESCO_API.DTOs.ColecaoDTO;
using ESCO_API.Exceptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/colecao")]
    [ApiController]
    [SwaggerTag("Coleções de competências e ocupações do dataset: listagem completa, busca por termo e detalhe por id.")]
    public class ColecaoController : ControllerBase
    {
        private readonly ColecaoService _service;

        public ColecaoController(ColecaoService service)
        {
            _service = service;
        }

        /// <summary>Lista todas as coleções do dataset.</summary>
        /// <returns>Lista de coleções (ex.: Competências digitais, Competências verdes).</returns>
        /// <response code="200">Coleções retornadas com sucesso.</response>
        [HttpGet]
        [ProducesResponseType(typeof(List<ListarColecaoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarColecaoDto>>> Listar()
        {
            try
            {
                return Ok(await _service.Listar());
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Busca coleções por termo livre.</summary>
        /// <remarks>Combina busca textual (tsvector em português) com similaridade de trigramas no nome.</remarks>
        /// <param name="termo">Texto a pesquisar (ex.: <c>digitais</c>, <c>verdes</c>).</param>
        /// <returns>Coleções que correspondem ao termo, ordenadas por relevância.</returns>
        /// <response code="200">Resultado da busca (pode ser vazio).</response>
        [HttpGet("termo/{termo}")]
        [ProducesResponseType(typeof(List<ListarColecaoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarColecaoDto>>> ListarPorTermo(string termo)
        {
            try
            {
                return Ok(await _service.ListarPorTermo(termo));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Obtém uma coleção pelo seu id.</summary>
        /// <param name="colecaoId">Id da coleção.</param>
        /// <returns>Dados da coleção, incluindo nome e descrição.</returns>
        /// <response code="200">Coleção encontrada.</response>
        /// <response code="404">Coleção não encontrada.</response>
        [HttpGet("{colecaoId}")]
        [ProducesResponseType(typeof(ListarColecaoDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ListarColecaoDto>> ObterPorId(int colecaoId)
        {
            try
            {
                return Ok(await _service.ObterPorId(colecaoId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
