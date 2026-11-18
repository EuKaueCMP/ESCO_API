using RBOSF_API.DTOs.HabilidadeDTO;
using RBOSF_API.Exceptions;
using RBOSF_API.Services;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace RBOSF_API.Controllers
{
    [Route("rbosfapi/v1/habilidade")]
    [ApiController]
    [SwaggerTag("Habilidades do dataset ESCO e da camada Next Hire: listagem completa, busca por termo e detalhe por id.")]
    public class HabilidadeController : ControllerBase
    {
        private readonly HabilidadeService _service;

        public HabilidadeController(HabilidadeService service)
        {
            _service = service;
        }

        /// <summary>Lista todas as habilidades e grupos de habilidade (ESCO e Next Hire), ordenadas por nome.</summary>
        /// <returns>Lista completa de habilidades, incluindo tipo, nível de reutilização e nomes alternativos.</returns>
        /// <response code="200">Habilidades retornadas com sucesso.</response>
        [HttpGet]
        [ProducesResponseType(typeof(List<ListarHabilidadeDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> Listar()
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

        /// <summary>Busca habilidades por termo livre.</summary>
        /// <remarks>Combina busca textual (tsvector em português) com similaridade de trigramas no nome.</remarks>
        /// <param name="termo">Texto a pesquisar (ex.: <c>docker</c>, <c>lgpd</c>).</param>
        /// <param name="classificacao">Filtro opcional por tipo de skill: <c>hard</c> ou <c>soft</c>.</param>
        /// <returns>Habilidades que correspondem ao termo, ordenadas por relevância.</returns>
        /// <response code="200">Resultado da busca (pode ser vazio).</response>
        [HttpGet("termo/{termo}")]
        [ProducesResponseType(typeof(List<ListarHabilidadeDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> ListarPorTermo(string termo, [FromQuery] string? classificacao = null)
        {
            try
            {
                return Ok(await _service.ListarPorTermo(termo, classificacao));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }


        /// <summary>Obtém uma habilidade pelo seu id.</summary>
        /// <param name="habilidadeId">Id da habilidade.</param>
        /// <returns>Dados da habilidade, incluindo tipo, classificação e nomes alternativos.</returns>
        /// <response code="200">Habilidade encontrada.</response>
        /// <response code="404">Habilidade não encontrada.</response>
        [HttpGet("{habilidadeId}")]
        [ProducesResponseType(typeof(ListarHabilidadeDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<ListarHabilidadeDto>> ObterPorId(int habilidadeId)
        {
            try
            {
                return Ok(await _service.ObterPorId(habilidadeId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Busca habilidades pelo código (padrão SFIA: 4 letras maiusculas, ex.: <c>PROG</c>).</summary>
        /// <remarks>Retorna primeiro a habilidade cujo código é exatamente igual, depois habilidades
        /// cujo código inicia com o termo informado e aquelas cuja busca textual corresponde.</remarks>
        /// <param name="codigo">Código da habilidade (ex.: <c>PROG</c>, <c>SCTY</c>).</param>
        /// <returns>Habilidades que correspondem ao código, ordenadas por correspondência exata.</returns>
        /// <response code="200">Resultado da busca (pode ser vazio).</response>
        /// <response code="404">Código inválido ou nenhuma habilidade encontrada.</response>
        [HttpGet("codigo/{codigo}")]
        [ProducesResponseType(typeof(List<ListarHabilidadeDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> ListarPorCodigo(string codigo)
        {
            try
            {
                return Ok(await _service.ListarPorCodigo(codigo));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Lista habilidades de uma classificação: <c>hard</c> ou <c>soft</c> skill.</summary>
        /// <remarks>Paginado por relevância. Use <c>limite</c> (1–200, padrão 60) e <c>pagina</c> (padrão 1).</remarks>
        /// <param name="classificacao"><c>hard</c> ou <c>soft</c> (aceita também <c>hardskill</c>/<c>softskill</c>).</param>
        /// <param name="limite">Quantidade por página (1–200).</param>
        /// <param name="pagina">Página, começando em 1.</param>
        /// <returns>Habilidades da classificação, mais relevantes primeiro.</returns>
        /// <response code="200">Habilidades retornadas com sucesso.</response>
        /// <response code="404">Classificação inválida.</response>
        [HttpGet("classificacao/{classificacao}")]
        [ProducesResponseType(typeof(List<ListarHabilidadeDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<List<ListarHabilidadeDto>>> ListarPorClassificacao(
            string classificacao,
            [FromQuery] int limite = 60,
            [FromQuery] int pagina = 1)
        {
            try
            {
                return Ok(await _service.ListarPorClassificacao(classificacao, limite, pagina));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Resumo do acervo por classificação: totais de hard skill, soft skill e agrupamentos.</summary>
        /// <response code="200">Contagens retornadas com sucesso.</response>
        [HttpGet("resumo")]
        [ProducesResponseType(typeof(ResumoClassificacaoDto), StatusCodes.Status200OK)]
        public async Task<ActionResult<ResumoClassificacaoDto>> ResumoClassificacao()
        {
            return Ok(await _service.ObterResumoClassificacao());
        }

        /// <summary>Lista os 7 níveis de habilidade (padrão SFIA), com nome e descrição em português.</summary>
        /// <returns>Níveis de 1 a 7 (Seguir, Auxiliar, Aplicar, Capacitar, Assegurar, Iniciar, Definir estratégia).</returns>
        /// <response code="200">Níveis retornados com sucesso.</response>
        [HttpGet("niveis")]
        [ProducesResponseType(typeof(List<ListarNivelHabilidadeDto>), StatusCodes.Status200OK)]
        public async Task<ActionResult<List<ListarNivelHabilidadeDto>>> ListarNiveis()
        {
            try
            {
                return Ok(await _service.ListarNiveis());
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }

        /// <summary>Lista a faixa de níveis SFIA de uma habilidade, com o descritor oficial em português de cada nível.</summary>
        /// <param name="habilidadeId">Id da habilidade.</param>
        /// <returns>Níveis válidos da habilidade (ex.: PROG retorna níveis 2 a 6).</returns>
        /// <response code="200">Faixa de níveis retornada com sucesso.</response>
        /// <response code="404">Habilidade inexistente ou sem descritores publicados.</response>
        [HttpGet("{habilidadeId:int}/niveis")]
        [ProducesResponseType(typeof(List<ListarNiveisPorHabilidadeDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<List<ListarNiveisPorHabilidadeDto>>> ListarNiveisPorHabilidadeId(int habilidadeId)
        {
            try
            {
                return Ok(await _service.ListarNiveisPorHabilidadeId(habilidadeId));
            }
            catch (DomainException ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
