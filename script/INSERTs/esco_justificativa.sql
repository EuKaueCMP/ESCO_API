-- Justificativa do nivel por vinculo (gap 2): combina os atributos genericos SFIA
-- (autonomia, complexidade, influencia) no nivel exigido do vinculo.
-- Idempotente: pode ser reexecutado.
SET search_path TO esco_dataset;
BEGIN;

ALTER TABLE ocupacao_habilidade ADD COLUMN IF NOT EXISTS justificativa TEXT;

CREATE TEMP TABLE _atrib ON COMMIT DROP AS
SELECT slug,
       nivel,
       split_part(coalesce(descricao_pt, descricao_en), '.', 1) || '.' AS frase
FROM sfia_atributo_nivel
WHERE slug IN ('autonomy', 'complexity', 'influence');

UPDATE ocupacao_habilidade vh
SET justificativa = 'Nível ' || vh.nivel_habilidade || ' porque: '
    || (SELECT frase FROM _atrib WHERE slug = 'autonomy' AND nivel = vh.nivel_habilidade) || ' '
    || (SELECT frase FROM _atrib WHERE slug = 'complexity' AND nivel = vh.nivel_habilidade) || ' '
    || (SELECT frase FROM _atrib WHERE slug = 'influence' AND nivel = vh.nivel_habilidade)
WHERE vh.nivel_habilidade IS NOT NULL;

COMMIT;
