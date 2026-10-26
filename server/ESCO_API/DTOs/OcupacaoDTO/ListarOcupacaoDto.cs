using ESCO_API.Domains;

namespace ESCO_API.DTOs.OcupacaoDTO;

public partial class ListarOcupacaoDto
{
    public int OcupacaoId { get; set; }

    public string Titulo { get; set; } = null!;

    public string Descricao { get; set; } = null!;

    public StatusEnum StatusOcupacao {get; set;}

    public List<string>? NomesAlternativos { get; set; }

    public string NomeGrupoOcupacao { get; set; } = string.Empty!;
    public int GrupoOcupacaoId { get; set; }
}