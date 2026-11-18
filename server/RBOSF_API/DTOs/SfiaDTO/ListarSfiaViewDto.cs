namespace RBOSF_API.DTOs.SfiaDTO;

/// <summary>Pagina da arvore de views SFIA (dominio, sub-view ou folha).</summary>
public class ListarSfiaViewDto
{
    public int ViewId { get; set; }

    public string Caminho { get; set; } = null!;

    public string? SlugPai { get; set; }

    public string? Nome { get; set; }

    public short Profundidade { get; set; }
}
