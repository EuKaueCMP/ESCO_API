namespace RBOSF_API.Domains;

/// <summary>Descritor de nivel especifico de uma habilidade SFIA (o que a habilidade significa em cada nivel de sua faixa).</summary>
public class NivelHabilidadeDescritor
{
    public int HabilidadeId { get; set; }

    public short Nivel { get; set; }

    public string Descricao { get; set; } = null!;

    public string? DescricaoEn { get; set; }

    /// <summary>'sfia_oficial' para os descritores oficiais, 'sintetizado' para os gerados a partir do ESCO.</summary>
    public string Origem { get; set; } = "sintetizado";

    public virtual NivelHabilidade NivelHabilidade { get; set; } = null!;

    public virtual Habilidade Habilidade { get; set; } = null!;
}
