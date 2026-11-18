namespace RBOSF_API.DTOs.HabilidadeDTO;

/// <summary>Nivel da faixa SFIA de uma habilidade com o descritor especifico do site oficial.</summary>
public class ListarNiveisPorHabilidadeDto
{
    public short Nivel { get; set; }

    public string NomeNivel { get; set; } = null!;

    public string? DescricaoNivel { get; set; }

    public string Descritor { get; set; } = null!;

    public string Origem { get; set; } = "sintetizado";

    /// <summary>Rubrica de avaliacao: como demonstrar proficiencia neste nivel.</summary>
    public string? Rubrica { get; set; }
}
