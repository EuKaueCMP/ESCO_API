namespace ESCO_API.Domains;

/// <summary>Vagas reais agregadas para uma ocupacao, de fonte de mercado.</summary>
public class MercadoOcupacao
{
    public int OcupacaoId { get; set; }

    public int Vagas { get; set; }

    public decimal FrequenciaPct { get; set; }

    public string Fonte { get; set; } = null!;

    public DateTime AtualizadoEm { get; set; }

    public virtual Ocupacao Ocupacao { get; set; } = null!;
}
