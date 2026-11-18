using RBOSF_API.Domains;

namespace RBOSF_API.DTOs.HabilidadeDTO;

public partial class ListarHabilidadeDto
{
    public int HabilidadeId { get; set; }

    public string Nome { get; set; } = null!;

    public string? Codigo { get; set; }

    public string Descricao { get; set; } = null!;

    public StatusEnum StatusHabilidade { get; set; }

    public NivelReutilizacaoEnum? NivelReutilizacao { get; set; }

    public TipoHabilidadeEnum? TipoHabilidade { get; set; }

    public TipoConceitoEnum TipoConceito { get; set; }

    public ClassificacaoHabilidadeEnum? ClassificacaoHabilidade { get; set; }

    public short? PesoRelevancia { get; set; }

    public List<string>? NomesAlternativos { get; set; }

}