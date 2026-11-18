using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.DTOs.OcupacaoDTO;
using ESCO_API.Exceptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/ocupacao")]
    [ApiController]
    [SwaggerTag("Ocupações do dataset ESCO e do mercado Next Hire: listagem completa, busca por termo, filtro por grupo ocupacional e habilidades vinculadas a uma ocupação.")]
    public class OcupacaoController : ControllerBase
    {
        private readonly OcupacaoService _service;

        public OcupacaoController(OcupacaoService service)
            => _service = service;

        /// <summary>Lista todas as ocupações (ESCO e mercado Next Hire), ordenadas por título.</summary>
        /// <returns>Lista completa de ocupações, cada uma com grupo ocupacional e nomes alternativos.</returns>
        /// <response code="200">Ocupações retornadas com sucesso.</response>
        [HttpGet]
        [ProducesResponseType(typeof(List<ListarOcupacaoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarOcupacaoDto>>> Listar()
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

        /// <summary>Busca ocupações por termo livre.</summary>
        /// <remarks>Combina busca textual (tsvector em português) com similaridade de trigramas no título.</remarks>
        /// <param name="termo">Texto a pesquisar (ex.: <c>desenvolvedor</c>, <c>full-stack</c>).</param>
        /// <returns>Ocupações que correspondem ao termo, ordenadas por relevância.</returns>
        /// <response code="200">Resultado da busca (pode ser vazio).</response>
        [HttpGet("termo/{termo}")]
        [ProducesResponseType(typeof(List<ListarOcupacaoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarOcupacaoDto>>> ListarPorTermo(string termo)
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

        /// <summary>Lista as ocupações pertencentes a um grupo ocupacional.</summary>
        /// <param name="grupoId">Id do grupo ocupacional (ISCO).</param>
        /// <returns>Ocupações do grupo, ordenadas por título.</returns>
        /// <response code="200">Ocupações do grupo retornadas com sucesso.</response>
        /// <response code="404">Grupo ocupacional não encontrado.</response>
        [HttpGet("grupo/{grupoId}")]
        [ProducesResponseType(typeof(List<ListarOcupacaoDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<List<ListarOcupacaoDto>>> ListarPorGrupo(int grupoId)
        {
            try
            {
                return Ok(await _service.ListarPorGrupo(grupoId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Lista todas as habilidades vinculadas a uma ocupação.</summary>
        /// <param name="ocupacaoId">Id da ocupação.</param>
        /// <returns>Habilidades (conhecimentos e competências) associadas à ocupação.</returns>
        /// <response code="200">Habilidades da ocupação retornadas com sucesso.</response>
        /// <response code="404">Ocupação não encontrada.</response>
        [HttpGet("ocupacaoId/{ocupacaoId}/habilidades")]
        [ProducesResponseType(typeof(List<ListarHabilidadePorOcupacaoDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<List<ListarHabilidadePorOcupacaoDto>>> ListarPorOcupacaoId(int ocupacaoId)
        {
            try
            {
                return Ok(await _service.ListarHabilidadesPorOcupacaoId(ocupacaoId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Obtém uma ocupação pelo seu id.</summary>
        /// <param name="ocupacaoId">Id da ocupação.</param>
        /// <returns>Dados da ocupação, incluindo grupo ocupacional e nomes alternativos.</returns>
        /// <response code="200">Ocupação encontrada.</response>
        /// <response code="404">Ocupação não encontrada.</response>
        [HttpGet("{ocupacaoId}")]
        [ProducesResponseType(typeof(ListarOcupacaoDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ListarOcupacaoDto>> ObterPorId(int ocupacaoId)
        {
            try
            {
                return Ok(await _service.ObterPorId(ocupacaoId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
