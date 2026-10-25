using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/habilidade")]
    [ApiController]
    public class HabilidadeController : ControllerBase
    {
        private readonly HabilidadeService _service;

        public HabilidadeController(HabilidadeService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> Listar()
        {
            try
            {
                return Ok(await _service.Listar());
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("termo/{termo}")]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> ListarPorTermo(string termo)
        {
            try
            {
                return Ok(await _service.ListarPorTermo(termo));
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("ocupacao/{ocupacaoId}/habilidades")]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> ListarPorOcupacaoId(int ocupacaoId)
        {
            try
            {
                return Ok(await _service.ListarPorOcupacaoId(ocupacaoId));
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }


        [HttpGet("{habilidadeId}")]
        public async Task<ActionResult<ListarHabilidadeDto>> ObterPorId(int habilidadeId)
        {
            try
            {
                return Ok(await _service.ObterPorId(habilidadeId));
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}