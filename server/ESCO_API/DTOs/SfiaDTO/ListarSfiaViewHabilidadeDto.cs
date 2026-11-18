namespace ESCO_API.DTOs.SfiaDTO;

/// <summary>Habilidade curada em uma view SFIA.</summary>
public class ListarSfiaViewHabilidadeDto
{
    public int HabilidadeId { get; set; }

    public string Nome { get; set; } = null!;

    public string? Codigo { get; set; }

    public short? PesoRelevancia { get; set; }
}
