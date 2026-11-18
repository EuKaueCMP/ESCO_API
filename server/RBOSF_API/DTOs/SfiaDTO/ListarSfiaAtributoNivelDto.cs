namespace RBOSF_API.DTOs.SfiaDTO;

/// <summary>Descricao de um atributo generico SFIA em um nivel.</summary>
public class ListarSfiaAtributoNivelDto
{
    public short Nivel { get; set; }

    public string NomeNivel { get; set; } = null!;

    public string Descricao { get; set; } = null!;
}
