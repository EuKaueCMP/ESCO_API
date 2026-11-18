using ESCO_API.DTOs.MercadoDTO;
using ESCO_API.Exceptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [ApiController]
    [Route("escoapi/v1/mercado")]
    public class MercadoController : ControllerBase
    {
        private readonly MercadoService _service;
        public MercadoController(MercadoService service) => _service = service;

        /// <summary>Painel de mercado real de uma ocupação: volume de vagas, salários por senioridade e habilidades mais pedidas.</summary>
        /// <param name="ocupacaoId">Id da ocupação.</param>
        /// <returns>Vagas agregadas, percentis salariais (por nível) e top habilidades por demanda.</returns>
        /// <response code="200">Dados de mercado retornados com sucesso.</response>
        /// <response code="404">Ocupação sem dado de mercado ou inexistente.</response>
        [HttpGet("ocupacao/{ocupacaoId:int}")]
        [ProducesResponseType(typeof(ListarMercadoPorOcupacaoDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ListarMercadoPorOcupacaoDto>> ListarPorOcupacao(int ocupacaoId)
        {
            try
            {
                return Ok(await _service.ListarPorOcupacao(ocupacaoId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
