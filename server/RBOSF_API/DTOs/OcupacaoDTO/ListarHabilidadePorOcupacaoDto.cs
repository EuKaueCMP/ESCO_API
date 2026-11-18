namespace RBOSF_API.DTOs.OcupacaoDTO;

/// <summary>Habilidade vinculada a uma ocupacao, com codigo SFIA, nivel exigido e peso de relevancia.</summary>
public class ListarHabilidadePorOcupacaoDto
{
    public int HabilidadeId { get; set; }

    public string Nome { get; set; } = null!;

    public string? Codigo { get; set; }

    public string? Descricao { get; set; }

    public string? TipoRelacionamento { get; set; }

    /// <summary>Classificacao da habilidade: hardskill ou softskill.</summary>
    public Domains.ClassificacaoHabilidadeEnum? ClassificacaoHabilidade { get; set; }

    public short? NivelHabilidade { get; set; }

    /// <summary>Texto de mercado do vinculo: ocupacao + habilidade + nivel de atuacao.</summary>
    public string? DescricaoNivel { get; set; }

    public short? PesoRelevancia { get; set; }

    /// <summary>Porque o nivel e exigido (atributos genericos SFIA no nivel).</summary>
    public string? Justificativa { get; set; }
}
