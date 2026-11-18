namespace RBOSF_API.DTOs.MercadoDTO;

/// <summary>Painel de mercado real de uma ocupacao: vagas, salarios e habilidades mais pedidas.</summary>
public class ListarMercadoPorOcupacaoDto
{
    public int OcupacaoId { get; set; }

    public string Titulo { get; set; } = null!;

    public int? Vagas { get; set; }

    public decimal? FrequenciaPct { get; set; }

    public string? Fonte { get; set; }

    public List<ListarMercadoSalarioDto> Salarios { get; set; } = new();

    public List<ListarMercadoHabilidadeDto> Habilidades { get; set; } = new();
}
