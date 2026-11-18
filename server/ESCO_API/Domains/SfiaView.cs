namespace ESCO_API.Domains;

/// <summary>Pagina da arvore de views SFIA (dominio, sub-view ou folha curada).</summary>
public class SfiaView
{
    public int ViewId { get; set; }

    public string Caminho { get; set; } = null!;

    public string? Slug { get; set; }

    public string? SlugPai { get; set; }

    public string? NomeEn { get; set; }

    public string? NomePt { get; set; }

    public short Profundidade { get; set; }

    public virtual ICollection<SfiaViewHabilidade> Habilidades { get; set; } = new List<SfiaViewHabilidade>();
}
