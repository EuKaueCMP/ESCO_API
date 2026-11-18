using RBOSF_API.Domains;
using RBOSF_API.DTOs.MercadoDTO;
using RBOSF_API.Exceptions;
using RBOSF_API.Interfaces;

namespace RBOSF_API.Services
{
    public class MercadoService
    {
        private readonly IMercadoRepository _repository;
        public MercadoService(IMercadoRepository repository) => _repository = repository;

        public async Task<ListarMercadoPorOcupacaoDto> ListarPorOcupacao(int ocupacaoId)
        {
            if (ocupacaoId <= 0)
                throw new DomainException("Insira um id de ocupação válido.");

            MercadoOcupacao? mercado = await _repository.ObterOcupacao(ocupacaoId);

            if (mercado is null)
                throw new DomainException("Nenhum dado de mercado encontrado para esta ocupação.");

            Ocupacao ocupacao = mercado.Ocupacao
                ?? throw new DomainException("Ocupação não encontrada.");

            List<MercadoSalario> salarios = await _repository.ListarSalarios(ocupacaoId);
            List<MercadoHabilidade> habilidades = await _repository.ListarHabilidades(ocupacaoId);

            return new ListarMercadoPorOcupacaoDto
            {
                OcupacaoId = ocupacaoId,
                Titulo = ocupacao.Titulo,
                Vagas = mercado.Vagas,
                FrequenciaPct = mercado.FrequenciaPct,
                Fonte = mercado.Fonte,
                Salarios = salarios
                    .Select(s => new ListarMercadoSalarioDto
                    {
                        Nivel = s.Nivel,
                        NomeNivel = s.NivelHabilidade?.Nome ?? string.Empty,
                        Amostra = s.Amostra,
                        P25 = s.P25,
                        P50 = s.P50,
                        P75 = s.P75,
                        P90 = s.P90,
                        Moeda = s.Moeda
                    })
                    .ToList(),
                Habilidades = habilidades
                    .Where(m => m.Habilidade != null)
                    .Select(m => new ListarMercadoHabilidadeDto
                    {
                        HabilidadeId = m.HabilidadeId,
                        Nome = m.Habilidade!.Nome,
                        Codigo = m.Habilidade.Codigo,
                        Vagas = m.Vagas,
                        PctVagas = m.PctVagas
                    })
                    .ToList()
            };
        }
    }
}
