using System;
using System.Collections.Generic;

namespace ESCO_API.Domains;

public partial class Ocupacao
{
    public int OcupacaoId { get; set; }

    public string Uri { get; set; } = null!;

    public string Titulo { get; set; } = null!;

    public string Descricao { get; set; } = null!;

    public string? NomesAlternativos { get; set; }

    public int GrupoOcupacaoId { get; set; }

    public virtual GrupoOcupacao GrupoOcupacao { get; set; } = null!;

    public virtual ICollection<Habilidade> Habilidade { get; set; } = new List<Habilidade>();
}
