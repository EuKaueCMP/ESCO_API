using ESCO_API.Conversions;
using ESCO_API.Domains;
using ESCO_API.DTOs.HabilidadeDTO;
using ESCO_API.Exceptions;
using ESCO_API.Interfaces;

namespace ESCO_API.Services
{
    public class HabilidadeService
    {
        private readonly IHabilidadeRepository _repository;
        
        private readonly ISfiaRepository _sfia;
        public HabilidadeService(IHabilidadeRepository repository, ISfiaRepository sfia)
        {
            _repository = repository;
            _sfia = sfia;
        }

        public async Task<List<ListarHabilidadeDto>> Listar()
        {
            List<Habilidade> habilidades = await _repository.Listar()
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }

        public async Task<List<ListarHabilidadeDto>> ListarPorTermo(string termo, string? classificacao = null)
        {
            if (string.IsNullOrWhiteSpace(termo))
                throw new DomainException("Insira um termo.");

            ClassificacaoHabilidadeEnum? tipo = string.IsNullOrWhiteSpace(classificacao) ? null : NormalizarClassificacao(classificacao);

            List<Habilidade> habilidades = await _repository.ListarPorTermo(termo, tipo)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }

        /// <summary>Lista habilidades de uma classificacao (hard/soft), paginada por relevancia.</summary>
        public async Task<List<ListarHabilidadeDto>> ListarPorClassificacao(string classificacao, int limite, int pagina)
        {
            ClassificacaoHabilidadeEnum tipo = NormalizarClassificacao(classificacao);

            limite = Math.Clamp(limite, 1, 200);
            pagina = Math.Max(pagina, 1);

            List<Habilidade> habilidades = await _repository.ListarPorClassificacao(tipo, limite, (pagina - 1) * limite);

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }

        /// <summary>Resumo do acervo por classificacao: hard, soft, total e agrupamentos.</summary>
        public async Task<ResumoClassificacaoDto> ObterResumoClassificacao()
            => await _repository.ContarPorClassificacao();

        private static ClassificacaoHabilidadeEnum NormalizarClassificacao(string classificacao)
        {
            string valor = (classificacao ?? string.Empty).Trim().ToLowerInvariant();

            return valor switch
            {
                "soft" or "softskill" or "soft-skill" or "soft_skill" => ClassificacaoHabilidadeEnum.softskill,
                "hard" or "hardskill" or "hard-skill" or "hard_skill" => ClassificacaoHabilidadeEnum.hardskill,
                _ => throw new DomainException("Classificacao invalida. Use 'hard' ou 'soft'.")
            };
        }



        public async Task<ListarHabilidadeDto> ObterPorId(int habilidadeId)
        {
            if (habilidadeId <= 0)
                throw new DomainException("Insira um ID válido.");

            Habilidade habilidade = await _repository.ObterPorId(habilidadeId)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return DomainToDto.HabilidadeToDto(habilidade);
        }

        public async Task<List<ListarHabilidadeDto>> ListarPorCodigo(string codigo)
        {
            if (string.IsNullOrWhiteSpace(codigo))
                throw new DomainException("Insira um código.");

            codigo = codigo.Trim();

            if (codigo.Length < 3 || codigo.Length > 8)
                throw new DomainException("Insira um código com 3 a 8 caracteres.");

            List<Habilidade> habilidades = await _repository.ListarPorCodigo(codigo)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            return habilidades
                .Select(h => DomainToDto.HabilidadeToDto(h))
                .ToList();
        }

        public async Task<List<ListarNivelHabilidadeDto>> ListarNiveis()
        {
            List<NivelHabilidade> niveis = await _repository.ListarNiveis()
                ?? throw new DomainException("Nenhum nível de habilidade encontrado.");

            return niveis
                .Select(n => DomainToDto.NivelHabilidadeToDto(n))
                .ToList();
        }

        public async Task<List<ListarNiveisPorHabilidadeDto>> ListarNiveisPorHabilidadeId(int habilidadeId)
        {
            if (habilidadeId <= 0)
                throw new DomainException("Insira o id de uma habilidade.");

            Habilidade habilidade = await _repository.ObterPorId(habilidadeId)
                ?? throw new DomainException("Nenhuma habilidade encontrada.");

            List<NivelHabilidadeDescritor> descritores = await _repository.ListarNiveisPorHabilidadeId(habilidadeId);

            if (descritores.Count == 0)
                throw new DomainException("Esta habilidade não possui descritores de nível publicados.");

            Dictionary<short, List<SfiaAtributoNivel>> frasesPorNivel = new();
            foreach (short nivel in descritores.Select(d => d.Nivel).Distinct())
                frasesPorNivel[nivel] = await _sfia.ListarFrasesAtributo(nivel);

            return descritores
                .Select(d => new ListarNiveisPorHabilidadeDto
                {
                    Nivel = d.Nivel,
                    NomeNivel = d.NivelHabilidade.Nome,
                    DescricaoNivel = d.NivelHabilidade.Descricao,
                    Descritor = d.Descricao,
                    Rubrica = MontarRubrica(d, frasesPorNivel.TryGetValue(d.Nivel, out List<SfiaAtributoNivel>? frases) ? frases : new()),
                    Origem = d.Origem
                })
                .ToList();
        }

        /// <summary>Monta a rubrica de avaliacao do nivel: frase-chave do descritor + expectativas dos atributos genericos.</summary>
        private string MontarRubrica(NivelHabilidadeDescritor d, List<SfiaAtributoNivel> frases)
        {
            string fraseSkill = d.Descricao;
            int ponto = fraseSkill.IndexOf('.');
            if (ponto > 0 && ponto < fraseSkill.Length - 1)
                fraseSkill = fraseSkill[..(ponto + 1)];

            var partes = new List<string> { fraseSkill.Trim() };
            foreach (SfiaAtributoNivel f in frases.OrderBy(f => f.Slug))
            {
                string? texto = f.DescricaoPt ?? f.DescricaoEn;
                if (string.IsNullOrWhiteSpace(texto)) continue;
                partes.Add($"{(f.Atributo?.NomePt ?? f.Atributo?.NomeEn ?? f.Slug)}: {texto.Trim()}");
            }
            return string.Join(" \u2022 ", partes);
        }
    }
}
