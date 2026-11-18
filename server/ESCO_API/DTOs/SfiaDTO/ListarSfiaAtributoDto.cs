namespace ESCO_API.DTOs.SfiaDTO;

/// <summary>Atributo generico SFIA.</summary>
public class ListarSfiaAtributoDto
{
    public string Slug { get; set; } = null!;

    public string? Codigo { get; set; }

    public string? Nome { get; set; }
}
