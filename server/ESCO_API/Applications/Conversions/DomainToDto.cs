using ESCO_API.Domains;
using ESCO_API.DTOs.ColecaoDTO;
using ESCO_API.DTOs.GrupoOcupacaoDTO;
using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.DTOs.OcupacaoDTO;
using System.Text.Json;

namespace ESCO_API.Conversions
{
    public static class DomainToDto
    {
        public static ListarColecaoDto ColecaoToDto(Colecao colecao)
        {
            return new ListarColecaoDto
            {
                ColecaoId = colecao.ColecaoId,
                Nome = colecao.Nome,
                Descricao = colecao.Descricao
            };
        }

        public static ListarGrupoOcupacaoDto GrupoOcupacaoToDto(GrupoOcupacao grupo)
        {
            return new ListarGrupoOcupacaoDto
            {
                GrupoId = grupo.GrupoId,
                Nome = grupo.Nome,
                Descricao = grupo.Descricao,
                Codigo = grupo.Codigo
            };
        }

        public static ListarHabilidadeDto HabilidadeToDto(Habilidade habilidade)
        {
            return new ListarHabilidadeDto
            {
                HabilidadeId = habilidade.HabilidadeId,
                Nome = habilidade.Nome,
                Descricao = habilidade.Descricao,
                ClassificacaoHabilidade = habilidade.ClassificacaoHabilidade,
                NivelReutilizacao = habilidade.NivelReutilizacao,
                NomesAlternativos = ConverterNomesAlternativos(habilidade.NomesAlternativos),
                StatusHabilidade = habilidade.StatusHabilidade,
                TipoConceito = habilidade.TipoConceito,
                TipoHabilidade = habilidade.TipoHabilidade
            };
        }

        public static ListarOcupacaoDto OcupacaoToDto(Ocupacao ocupacao)
        {
            return new ListarOcupacaoDto
            {
                OcupacaoId = ocupacao.OcupacaoId,
                Titulo = ocupacao.Titulo,
                Descricao = ocupacao.Descricao,
                NomeGrupoOcupacao = ocupacao.GrupoOcupacao.Nome,
                GrupoOcupacaoId = ocupacao.GrupoOcupacaoId,
                NomesAlternativos = ConverterNomesAlternativos(ocupacao.NomesAlternativos),
                StatusOcupacao = ocupacao.StatusOcupacao
            };
        }

        private static List<string>? ConverterNomesAlternativos(string? json)
        {
            if (string.IsNullOrWhiteSpace(json))
                return null;

            try
            {
                return JsonSerializer.Deserialize<List<string>>(json);
            }
            catch (JsonException)
            {
                return null;
            }
        }
    }
}