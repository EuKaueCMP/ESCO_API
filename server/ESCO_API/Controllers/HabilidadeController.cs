using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.Exceptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/habilidade")]
    [ApiController]
    [SwaggerTag("Habilidades do dataset ESCO e da camada Next Hire: listagem completa, busca por termo e detalhe por id.")]
    public class HabilidadeController : ControllerBase
    {
        private readonly HabilidadeService _service;

        public HabilidadeController(HabilidadeService service)
        {
            _service = service;
        }

        /// <summary>Lista todas as habilidades e grupos de habilidade (ESCO e Next Hire), ordenadas por nome.</summary>
        /// <returns>Lista completa de habilidades, incluindo tipo, nível de reutilização e nomes alternativos.</returns>
        /// <response code="200">Habilidades retornadas com sucesso.</response>
        [HttpGet]
        [ProducesResponseType(typeof(List<ListarHabilidadeDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> Listar()
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

        /// <summary>Busca habilidades por termo livre.</summary>
        /// <remarks>Combina busca textual (tsvector em português) com similaridade de trigramas no nome.</remarks>
        /// <param name="termo">Texto a pesquisar (ex.: <c>docker</c>, <c>lgpd</c>).</param>
        /// <returns>Habilidades que correspondem ao termo, ordenadas por relevância.</returns>
        /// <response code="200">Resultado da busca (pode ser vazio).</response>
        [HttpGet("termo/{termo}")]
        [ProducesResponseType(typeof(List<ListarHabilidadeDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> ListarPorTermo(string termo)
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


        /// <summary>Obtém uma habilidade pelo seu id.</summary>
        /// <param name="habilidadeId">Id da habilidade.</param>
        /// <returns>Dados da habilidade, incluindo tipo, classificação e nomes alternativos.</returns>
        /// <response code="200">Habilidade encontrada.</response>
        /// <response code="404">Habilidade não encontrada.</response>
        [HttpGet("{habilidadeId}")]
        [ProducesResponseType(typeof(ListarHabilidadeDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ListarHabilidadeDto>> ObterPorId(int habilidadeId)
        {
            try
            {
                return Ok(await _service.ObterPorId(habilidadeId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
