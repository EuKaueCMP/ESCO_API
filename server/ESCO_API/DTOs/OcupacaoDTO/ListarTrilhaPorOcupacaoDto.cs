namespace ESCO_API.DTOs.OcupacaoDTO;

/// <summary>Trilha de carreira de uma ocupacao: skills essenciais por nivel e ocupacoes seguintes.</summary>
public class ListarTrilhaPorOcupacaoDto
{
    public int OcupacaoId { get; set; }

    public string Titulo { get; set; } = null!;

    public decimal? NivelMedio { get; set; }

    public List<ListarHabilidadePorOcupacaoDto> HabilidadesEssenciais { get; set; } = new();

    public List<ListarProximaOcupacaoDto> ProximasOcupacoes { get; set; } = new();
}
