namespace ESCO_API.DTOs.OcupacaoDTO;

/// <summary>Ocupacao seguinte na trilha de carreira, com overlap de skills e gap.</summary>
public class ListarProximaOcupacaoDto
{
    public int OcupacaoId { get; set; }

    public string Titulo { get; set; } = null!;

    public int Compartilhadas { get; set; }

    public decimal NivelMedioDestino { get; set; }

    public string? HabilidadesFaltantes { get; set; }
}
