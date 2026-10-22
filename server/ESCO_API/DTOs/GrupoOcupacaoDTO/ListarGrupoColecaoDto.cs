namespace ESCO_API.DTOs.GrupoOcupacaoDTO;

public partial class ListarGrupoColecaoDto
{
    public int GrupoId { get; set; }

    public string Codigo { get; set; } = null!;

    public string Nome { get; set; } = null!;

    public string Descricao { get; set; } = null!;
}