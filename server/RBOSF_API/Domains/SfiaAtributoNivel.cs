namespace RBOSF_API.Domains;

/// <summary>Descricao de um atributo generico SFIA em um nivel (1-7).</summary>
public class SfiaAtributoNivel
{
    public string Slug { get; set; } = null!;

    public short Nivel { get; set; }

    public string? DescricaoEn { get; set; }

    public string? DescricaoPt { get; set; }

    public virtual SfiaAtributo Atributo { get; set; } = null!;

    public virtual NivelHabilidade NivelHabilidade { get; set; } = null!;
}
