namespace RBOSF_API.DTOs.MercadoDTO;

/// <summary>Salario real de mercado para uma ocupacao em um nivel.</summary>
public class ListarMercadoSalarioDto
{
    public short Nivel { get; set; }

    public string NomeNivel { get; set; } = null!;

    public int Amostra { get; set; }

    public decimal P25 { get; set; }

    public decimal P50 { get; set; }

    public decimal P75 { get; set; }

    public decimal P90 { get; set; }

    public string Moeda { get; set; } = null!;
}
