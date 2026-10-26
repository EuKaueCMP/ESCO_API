using System;
using System.Collections.Generic;
using ESCO_API.Domains;
using NpgsqlTypes;

namespace ESCO_API;

public partial class Colecao
{
    public int ColecaoId { get; set; }

    public string Uri { get; set; } = null!;

    public string Nome { get; set; } = null!;

    public string Descricao { get; set; } = null!;

    public NpgsqlTsVector SearchVector { get; set; } = null!;

    public virtual ICollection<Habilidade> Habilidade { get; set; } = new List<Habilidade>();
}
