namespace RBOSF_API.Domains;

/// <summary>Vinculo entre uma pagina de view SFIA e uma habilidade curada nela.</summary>
public class SfiaViewHabilidade
{
    public string Caminho { get; set; } = null!;

    public int HabilidadeId { get; set; }

    public virtual SfiaView View { get; set; } = null!;

    public virtual Habilidade Habilidade { get; set; } = null!;
}
