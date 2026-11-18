namespace RBOSF_API.DTOs.MercadoDTO;

/// <summary>Demanda real de mercado por uma habilidade nas vagas de uma ocupacao.</summary>
public class ListarMercadoHabilidadeDto
{
    public int HabilidadeId { get; set; }

    public string Nome { get; set; } = null!;

    public string? Codigo { get; set; }

    public int Vagas { get; set; }

    public decimal PctVagas { get; set; }
}
