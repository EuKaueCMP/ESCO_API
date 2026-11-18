-- ESCO / Next Hire — Peso de relevancia (1-5) para ocupacoes e habilidades
-- ---------------------------------------------------------------------------
-- Execute DEPOIS de script/INSERTs/esco_db_refatorado.sql e
-- script/INSERTs/esco_sfia_niveis.sql (idempotente; pode reexecutar).
--
-- O peso expressa a provavel demanda de busca da ocupacao/habilidade em um
-- sistema real de vagas (volume de vagas/ofertas no mercado), e NAO salario
-- ou prestigio da profissao.
--
-- Ocupacoes (por subgrupo ISCO-08 de 2 digitos):
--   5 = profissoes de altissima demanda de busca (TI profissionais, servicos
--       de massa: vendedores/atendentes/cozinheiros, motoristas, limpeza)
--   4 = alta demanda (saude, educacao, negocios/TI tecnicos, administrativos,
--       eletricistas/mecanicos, auxiliares de producao e alimentacao)
--   3 = demanda media (gerencias em geral, tecnicos de ciencias, industria,
--       construcao, seguranca, agronegocio, militares)
--   2 = demanda baixa (juridico/cultural, artes, servicos de rua, agricultura
--       avancada, veterinaria/chefes de expedicao)
--   1 = demanda muito baixa (subsistencia rural)
--
-- Habilidades:
--   percentil do numero de ocupacoes que usam a habilidade (cobertura de
--   mercado) + reforco para habilidades de tecnologia (camada Next Hire e
--   skills SFIA), limitado a 5. Habilidades sem vinculo ficam com 1.
-- ---------------------------------------------------------------------------

SET search_path TO esco_dataset;

BEGIN;

-- ----------------------------- ocupacoes -----------------------------
UPDATE esco_dataset.ocupacao o
SET peso_relevancia = v.peso
FROM (
    SELECT o2.ocupacao_id,
           CASE
               -- ocupacoes de servicos sexuais: relevancia minima em plataformas reais
               WHEN o2.titulo ILIKE '%escort%' THEN 2
               ELSE CASE left(g.codigo, 2)
               WHEN '25' THEN 5  -- profissionais de TI
               WHEN '52' THEN 5  -- vendedores / lojistas
               WHEN '51' THEN 5  -- servicos pessoais (atendente, cozinheiro, beleza)
               WHEN '83' THEN 5  -- motoristas
               WHEN '91' THEN 5  -- limpeza (gari, auxiliar de limpeza)
               WHEN '13' THEN 4  -- gerentes de producao/operacoes (1330 = TI) + 1 alem do padrao
               WHEN '21' THEN 4  -- cientistas e engenheiros
               WHEN '22' THEN 4  -- profissionais de saude
               WHEN '23' THEN 4  -- professores
               WHEN '24' THEN 4  -- profissionais administrativos/comerciais/financeiros
               WHEN '32' THEN 4  -- tecnicos de saude
               WHEN '33' THEN 4  -- tecnicos financeiros/administrativos/comerciais
               WHEN '35' THEN 4  -- tecnicos de TI e comunicacao
               WHEN '41' THEN 4  -- escriturarios (auxiliar administrativo)
               WHEN '42' THEN 4  -- atendente / caixa / recepcionista
               WHEN '43' THEN 4  -- estoque / transporte / cobranca
               WHEN '72' THEN 4  -- mecanicos industriais/automotivos
               WHEN '74' THEN 4  -- eletricistas/eletronicos instaladores
               WHEN '93' THEN 4  -- auxiliares de producao (operador de producao)
               WHEN '94' THEN 4  -- preparadores de alimentacao
               WHEN '54' THEN 3  -- policia/militar/s seguranca
               WHEN '11' THEN 3
               WHEN '12' THEN 3
               WHEN '14' THEN 3
               WHEN '31' THEN 3
               WHEN '34' THEN 3
               WHEN '44' THEN 3
               WHEN '61' THEN 3
               WHEN '71' THEN 3
               WHEN '73' THEN 3
               WHEN '75' THEN 3
               WHEN '81' THEN 3
               WHEN '82' THEN 3
               WHEN '92' THEN 3
               WHEN '96' THEN 3
               WHEN '01' THEN 3
               WHEN '02' THEN 3
               WHEN '03' THEN 3
               WHEN '26' THEN 2  -- juridico, social, cultural, artistas
               WHEN '62' THEN 2
               WHEN '95' THEN 2
               ELSE 3
               END
           END + CASE left(g.codigo, 3) WHEN '133' THEN 1 ELSE 0 END AS peso
    FROM esco_dataset.ocupacao o2
    JOIN esco_dataset.grupo_ocupacao g ON g.grupo_id = o2.grupo_ocupacao_id
) v
WHERE o.ocupacao_id = v.ocupacao_id;

-- limita o peso de ocupacoes entre 1 e 5
UPDATE esco_dataset.ocupacao SET peso_relevancia = 5 WHERE peso_relevancia > 5;
UPDATE esco_dataset.ocupacao SET peso_relevancia = 1 WHERE peso_relevancia < 1;

-- ----------------------------- habilidades -----------------------------
-- Base: percentil da cobertura da habilidade (quantas ocupacoes a usam).
-- Habilidades de tecnologia (camada Next Hire e skills SFIA) recebem PISO 4
-- (relevancia para o dominio do sistema), passando a 5 quando tambem sao
-- amplamente usadas (percentil <= 0.25) e a 3 quando quase sem vinculo.
UPDATE esco_dataset.habilidade h
SET peso_relevancia = v.peso
FROM (
    SELECT h2.habilidade_id,
           CASE
               WHEN uso.total IS NULL THEN 1
               WHEN h2.uri LIKE '%nexthire%' OR h2.uri LIKE 'sfia://%' THEN
                   CASE WHEN uso.pos <= 0.90 THEN
                       CASE WHEN uso.pos <= 0.25 THEN 5 ELSE 4 END
                   ELSE 3 END
               WHEN uso.pos <= 0.01 THEN 5
               WHEN uso.pos <= 0.08 THEN 4
               WHEN uso.pos <= 0.30 THEN 3
               WHEN uso.pos <= 0.65 THEN 2
               ELSE 1
           END AS peso
    FROM esco_dataset.habilidade h2
    LEFT JOIN (
        SELECT oh2.habilidade_id,
                count(*) AS total,
                percent_rank() OVER (ORDER BY count(*) DESC) AS pos
        FROM esco_dataset.ocupacao_habilidade oh2
        GROUP BY oh2.habilidade_id
    ) uso ON uso.habilidade_id = h2.habilidade_id
) v
WHERE h.habilidade_id = v.habilidade_id;

-- grupos de habilidade nao recebem peso de busca
UPDATE esco_dataset.habilidade SET peso_relevancia = NULL WHERE tipo_conceito = 'grupo_habilidade';

COMMIT;
