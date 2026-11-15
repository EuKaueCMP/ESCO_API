using ESCO_API.DTOs.GrupoOcupacaoDTO;
using ESCO_API.Exceptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/grupoOcupacao")]
    [ApiController]
    [SwaggerTag("Grupos ocupacionais ISCO: listagem completa, busca por termo e detalhe por id.")]
    public class GrupoOcupacaoController : ControllerBase
    {
        private readonly GrupoOcupacaoService _service;

        public GrupoOcupacaoController(GrupoOcupacaoService service)
        {
            _service = service;
        }

        /// <summary>Lista todos os grupos ocupacionais ISCO, ordenados por nome.</summary>
        /// <returns>Lista completa de grupos com código ISCO e descrição.</returns>
        /// <response code="200">Grupos retornados com sucesso.</response>
        [HttpGet]
        [ProducesResponseType(typeof(List<ListarGrupoOcupacaoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarGrupoOcupacaoDto>>> Listar()
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

        /// <summary>Busca grupos ocupacionais por termo livre.</summary>
        /// <remarks>Combina busca textual (tsvector em português) com similaridade de trigramas no nome.</remarks>
        /// <param name="termo">Texto a pesquisar (ex.: <c>software</c>, <c>saúde</c>).</param>
        /// <returns>Grupos que correspondem ao termo, ordenados por relevância.</returns>
        /// <response code="200">Resultado da busca (pode ser vazio).</response>
        [HttpGet("termo/{termo}")]
        [ProducesResponseType(typeof(List<ListarGrupoOcupacaoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarGrupoOcupacaoDto>>> ListarPorTermo(string termo)
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

        /// <summary>Obtém um grupo ocupacional pelo seu id.</summary>
        /// <param name="grupoId">Id do grupo ocupacional.</param>
        /// <returns>Dados do grupo, incluindo código ISCO e descrição.</returns>
        /// <response code="200">Grupo encontrado.</response>
        /// <response code="404">Grupo não encontrado.</response>
        [HttpGet("{grupoId}")]
        [ProducesResponseType(typeof(ListarGrupoOcupacaoDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ListarGrupoOcupacaoDto>> ObterPorId(int grupoId)
        {
            try
            {
                return Ok(await _service.ObterPorId(grupoId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
