namespace RBOSF_API.Domains;

/// <summary>Frequencia real de uma habilidade nas vagas de uma ocupacao.</summary>
public class MercadoHabilidade
{
    public int OcupacaoId { get; set; }

    public int HabilidadeId { get; set; }

    public int Vagas { get; set; }

    public decimal PctVagas { get; set; }

    public string Fonte { get; set; } = null!;

    public DateTime AtualizadoEm { get; set; }

    public virtual Habilidade Habilidade { get; set; } = null!;
}
