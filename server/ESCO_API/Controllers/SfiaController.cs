using ESCO_API.DTOs.SfiaDTO;
using ESCO_API.Exceptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [ApiController]
    [Route("escoapi/v1/sfia")]
    public class SfiaController : ControllerBase
    {
        private readonly SfiaService _service;
        public SfiaController(SfiaService service) => _service = service;

        /// <summary>Lista os 16 atributos genéricos SFIA (autonomia, complexidade, influência...).</summary>
        /// <returns>Atributos com código e nome em português.</returns>
        /// <response code="200">Atributos retornados com sucesso.</response>
        [HttpGet("atributo")]
        [ProducesResponseType(typeof(List<ListarSfiaAtributoDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarSfiaAtributoDto>>> ListarAtributos()
        {
            try
            {
                return Ok(await _service.ListarAtributos());
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Lista os 7 níveis de um atributo genérico SFIA, com descrição oficial por nível.</summary>
        /// <param name="slug">Slug do atributo (ex.: autonomia, complexidade).</param>
        /// <returns>Níveis 1 a 7 com a descrição do atributo em cada nível.</returns>
        /// <response code="200">Níveis do atributo retornados com sucesso.</response>
        /// <response code="404">Atributo não encontrado.</response>
        [HttpGet("atributo/{slug}")]
        [ProducesResponseType(typeof(List<ListarSfiaAtributoNivelDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<List<ListarSfiaAtributoNivelDto>>> ListarNiveisDoAtributo(string slug)
        {
            try
            {
                return Ok(await _service.ListarNiveisDoAtributo(slug));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Lista a árvore de views SFIA (12 domínios, sub-views e folhas curadas).</summary>
        /// <returns>Views com caminho hierárquico (caminho/slugPai) para montar a árvore.</returns>
        /// <response code="200">Views retornadas com sucesso.</response>
        [HttpGet("view")]
        [ProducesResponseType(typeof(List<ListarSfiaViewDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarSfiaViewDto>>> ListarViews()
        {
            try
            {
                return Ok(await _service.ListarViews());
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Obtém uma view SFIA com as habilidades curadas nela.</summary>
        /// <param name="viewId">Id da view.</param>
        /// <returns>Dados da view e habilidades (nome, código SFIA, peso).</returns>
        /// <response code="200">View retornada com sucesso.</response>
        /// <response code="404">View não encontrada.</response>
        [HttpGet("view/{viewId:int}")]
        [ProducesResponseType(typeof(object), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> ObterView(int viewId)
        {
            try
            {
                var (view, habilidades) = await _service.ObterView(viewId);
                return Ok(new { view, habilidades });
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
