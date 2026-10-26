using System;
using System.Collections.Generic;
using NpgsqlTypes;

namespace ESCO_API.Domains;

public partial class GrupoOcupacao
{
    public int GrupoId { get; set; }

    public string Uri { get; set; } = null!;

    public string Codigo { get; set; } = null!;

    public string Nome { get; set; } = null!;

    public string Descricao { get; set; } = null!;

    public NpgsqlTsVector SearchVector { get; set; } = null!;

    public virtual ICollection<Ocupacao> Ocupacao { get; set; } = new List<Ocupacao>();
}
