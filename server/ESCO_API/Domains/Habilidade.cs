using System;
using System.Collections.Generic;

namespace ESCO_API.Domains;

public partial class Habilidade
{
    public int HabilidadeId { get; set; }

    public string Uri { get; set; } = null!;

    public string Nome { get; set; } = null!;

    public string Descricao { get; set; } = null!;

    public string? NomesAlternativos { get; set; }

    public virtual ICollection<Colecao> Colecao { get; set; } = new List<Colecao>();

    public virtual ICollection<Habilidade> HabilidadeFilha { get; set; } = new List<Habilidade>();

    public virtual ICollection<Habilidade> HabilidadePai { get; set; } = new List<Habilidade>();

    public virtual ICollection<Ocupacao> Ocupacao { get; set; } = new List<Ocupacao>();
}
