using ESCO_API.Domains;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace ESCO_API.Controllers
{
    [Route("escoapi/v1/metadados")]
    [ApiController]
    [SwaggerTag("Valores de referência (enums) do dataset, usados nos filtros e nos payloads da API.")]
    public class MetadadosController : ControllerBase
    {
        /// <summary>Lista os valores possíveis de status de ocupação/habilidade.</summary>
        /// <returns>Valores do enum de status (ex.: <c>released</c>, <c>deprecated</c>).</returns>
        /// <response code="200">Valores retornados com sucesso.</response>
        [HttpGet("status")]
        [ProducesResponseType(typeof(string[]), StatusCodes.Status200OK)]
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

        /// <summary>Lista os tipos de habilidade do dataset.</summary>
        /// <returns>Valores do enum de tipo de habilidade (ex.: <c>conhecimento</c>, <c>competencia</c>).</returns>
        /// <response code="200">Valores retornados com sucesso.</response>
        [HttpGet("tipo-habilidade")]
        [ProducesResponseType(typeof(string[]), StatusCodes.Status200OK)]
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

        /// <summary>Lista os tipos de conceito de habilidade.</summary>
        /// <returns>Valores do enum de tipo de conceito (ex.: <c>habilidade</c>, <c>grupo_habilidade</c>).</returns>
        /// <response code="200">Valores retornados com sucesso.</response>
        [HttpGet("tipo-conceito")]
        [ProducesResponseType(typeof(string[]), StatusCodes.Status200OK)]
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

        /// <summary>Lista os níveis de reutilização de uma habilidade.</summary>
        /// <returns>Valores do enum de nível de reutilização (ex.: <c>transversal</c>, <c>especifico_ocupacao</c>).</returns>
        /// <response code="200">Valores retornados com sucesso.</response>
        [HttpGet("reutilizacao")]
        [ProducesResponseType(typeof(string[]), StatusCodes.Status200OK)]
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

        /// <summary>Lista os tipos de relacionamento entre ocupação e habilidade.</summary>
        /// <returns>Valores do enum de tipo de relacionamento (ex.: <c>essencial</c>, <c>opcional</c>).</returns>
        /// <response code="200">Valores retornados com sucesso.</response>
        [HttpGet("tipo-relacionamento")]
        [ProducesResponseType(typeof(string[]), StatusCodes.Status200OK)]
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
