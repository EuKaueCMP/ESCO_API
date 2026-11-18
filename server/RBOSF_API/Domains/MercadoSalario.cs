namespace RBOSF_API.Domains;

/// <summary>Salarios reais de mercado para uma ocupacao em um nivel de senioridade.</summary>
public class MercadoSalario
{
    public int OcupacaoId { get; set; }

    public short Nivel { get; set; }

    public int Amostra { get; set; }

    public decimal P25 { get; set; }

    public decimal P50 { get; set; }

    public decimal P75 { get; set; }

    public decimal P90 { get; set; }

    public string Moeda { get; set; } = null!;

    public string Fonte { get; set; } = null!;

    public DateTime AtualizadoEm { get; set; }

    public virtual Ocupacao Ocupacao { get; set; } = null!;

    public virtual NivelHabilidade NivelHabilidade { get; set; } = null!;
}
