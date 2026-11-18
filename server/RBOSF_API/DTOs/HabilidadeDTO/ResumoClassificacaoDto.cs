namespace RBOSF_API.DTOs.HabilidadeDTO;

/// <summary>Contagem de habilidades por classificacao (hard skill / soft skill).</summary>
public class ResumoClassificacaoDto
{
    /// <summary>Habilidades classificadas como hard skill.</summary>
    public int HardSkill { get; set; }

    /// <summary>Habilidades classificadas como soft skill.</summary>
    public int SoftSkill { get; set; }

    /// <summary>Habilidades classificadas (hard + soft).</summary>
    public int Total { get; set; }

    /// <summary>Agrupamentos de habilidade (nao classificados como hard/soft).</summary>
    public int Grupos { get; set; }
}
