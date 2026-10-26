
using ESCO_API.DTOs.ColecaoDTO;
using ESCO_API.Excptions;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/colecao")]
    [ApiController]
    public class ColecaoController : ControllerBase
    {
        private readonly ColecaoService _service;

        public ColecaoController(ColecaoService service)
        {
            _service = service;
        }

        [HttpGet]
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

        [HttpGet("termo/{termo}")]
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

        [HttpGet("{colecaoId}")]
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