
using ESCO_API.DTOs.OcupacaoDTO;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/ocupacao")]
    [ApiController]
    public class OcupacaoController : ControllerBase
    {
        private readonly OcupacaoService _service;

        public OcupacaoController(OcupacaoService service)
            => _service = service;

        [HttpGet]
        public async Task<ActionResult<List<ListarOcupacaoDto>>> Listar()
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
        public async Task<ActionResult<List<ListarOcupacaoDto>>> ListarPorTermo(string termo)
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

        [HttpGet("grupo/{grupoId}")]
        public async Task<ActionResult<List<ListarOcupacaoDto>>> ListarPorGrupo(int grupoId)
        {
            try
            {
                return Ok(await _service.ListarPorGrupo(grupoId));
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("ocupacaoId/{ocupacaoId}/habilidades")]
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

        [HttpGet("{ocupacaoId}")]
        public async Task<ActionResult<ListarOcupacaoDto>> ObterPorId(int ocupacaoId)
        {
            try
            {
                return Ok(await _service.ObterPorId(ocupacaoId));
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
