using System;
using System.Collections.Generic;

namespace ESCO_API.Domains;

public partial class Colecao
{
    public int ColecaoId { get; set; }

    public string Uri { get; set; } = null!;

    public string Nome { get; set; } = null!;

    public string Descricao { get; set; } = null!;

    public virtual ICollection<Habilidade> Habilidade { get; set; } = new List<Habilidade>();
}
