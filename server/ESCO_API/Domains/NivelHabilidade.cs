namespace ESCO_API.Domains;

/// <summary>Nivel de responsabilidade SFIA (1 a 7) usado pelas habilidades.</summary>
public class NivelHabilidade
{
    public short Nivel { get; set; }

    public string Nome { get; set; } = null!;

    public string Descricao { get; set; } = null!;
}
