using System;
using System.Collections.Generic;
using NpgsqlTypes;

namespace ESCO_API.Domains;

public partial class Ocupacao
{
    public int OcupacaoId { get; set; }

    public string Uri { get; set; } = null!;

    public string Titulo { get; set; } = null!;

    public string Descricao { get; set; } = null!;
    public StatusEnum StatusOcupacao {get; set;}

    public string? NomesAlternativos { get; set; }

    public int GrupoOcupacaoId { get; set; }

    public NpgsqlTsVector? SearchVector { get; set; }

    public virtual GrupoOcupacao GrupoOcupacao { get; set; } = null!;

    public virtual ICollection<Habilidade> Habilidade { get; set; } = new List<Habilidade>();
}
