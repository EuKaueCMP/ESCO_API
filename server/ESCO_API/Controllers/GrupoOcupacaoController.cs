using ESCO_API.DTOs.GrupoOcupacaoDTO;
using ESCO_API.Services;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/grupoOcupacao")]
    [ApiController]
    public class GrupoOcupacaoController : ControllerBase
    {
        private readonly GrupoOcupacaoService _service;

        public GrupoOcupacaoController(GrupoOcupacaoService service)
        {
            _service = service;
        }

        [HttpGet]
        public async Task<ActionResult<List<ListarGrupoOcupacaoDto>>> Listar()
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
        public async Task<ActionResult<List<ListarGrupoOcupacaoDto>>> ListarPorTermo(string termo)
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

        [HttpGet("{grupoId}")]
        public async Task<ActionResult<ListarGrupoOcupacaoDto>> ObterPorId(int grupoId)
        {
            try
            {
                return Ok(await _service.ObterPorId(grupoId));
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}