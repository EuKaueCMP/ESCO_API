using ESCO_API.Domains;
using Microsoft.AspNetCore.Mvc;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/metadados")]
    [ApiController]
    public class MetadadosController : ControllerBase
    {
        [HttpGet("status")]
        public IActionResult ListarStatus()
        {
            try
            {
                return Ok(Enum.GetNames<StatusEnum>());
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("tipo-habilidade")]
        public IActionResult ListarTipoHabilidade()
        {
            try
            {
                return Ok(Enum.GetNames<TipoHabilidadeEnum>());
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("tipo-conceito")]
        public IActionResult ListarTipoConceito()
        {
            try
            {
                return Ok(Enum.GetNames<TipoConceitoEnum>());
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("reutilizacao")]
        public IActionResult ListarReutilizacao()
        {
            try
            {
                return Ok(Enum.GetNames<NivelReutilizacaoEnum>());
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }

        [HttpGet("tipo-relacionamento")]
        public IActionResult ListarTipoRelacionamento()
        {
            try
            {
                return Ok(Enum.GetNames<TipoRelacionamentoEnum>());
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}