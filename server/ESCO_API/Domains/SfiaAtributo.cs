namespace ESCO_API.Domains;

/// <summary>Atributo generico SFIA (autonomia, complexidade...) com descricao por nivel.</summary>
public class SfiaAtributo
{
    public string Slug { get; set; } = null!;

    public string? Codigo { get; set; }

    public string? NomeEn { get; set; }

    public string? NomePt { get; set; }

    public virtual ICollection<SfiaAtributoNivel> Niveis { get; set; } = new List<SfiaAtributoNivel>();
}
