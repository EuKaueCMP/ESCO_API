-- ============================================================
-- camada de niveis SFIA para habilidades ESCO (todas as areas)
-- escopo: TODAS as ocupacoes; militares (major 0) = nivel base 4
-- gerado por /tmp/opencode/sfia9_expansao.py (deterministico, idempotente)
-- ============================================================
BEGIN;

-- 0) colunas idempotentes
ALTER TABLE esco_dataset.nivel_habilidade_descritor
    ADD COLUMN IF NOT EXISTS origem TEXT NOT NULL DEFAULT 'sintetizado';

ALTER TABLE esco_dataset.ocupacao_habilidade
    ADD COLUMN IF NOT EXISTS descricao TEXT;

-- backfill: as 147 skills SFIA tem descritores oficiais
UPDATE esco_dataset.nivel_habilidade_descritor d
SET origem = 'sfia_oficial'
FROM esco_dataset.habilidade h
WHERE h.habilidade_id = d.habilidade_id
  AND h.codigo IN ('ACIN', 'ADEV', 'ADMN', 'AIDE', 'ANCC', 'ARCH', 'ASMG', 'ASUP', 'AUDT', 'AVMT', 'BENM', 'BIDM', 'BINT', 'BPRE', 'BPTS', 'BRMG', 'BSMO', 'BUDF', 'BURM', 'BUSA', 'CELO', 'CEXP', 'CFMG', 'CHMG', 'CIPM', 'CNSL', 'COMG', 'COPL', 'CPMG', 'CRIM', 'CSMG', 'CSOP', 'DAAN', 'DATM', 'DATS', 'DBAD', 'DBDS', 'DCMA', 'DEMG', 'DEMM', 'DENG', 'DEPL', 'DESN', 'DGFS', 'DIGM', 'DLMG', 'DTAN', 'EEXP', 'EMRG', 'ETDL', 'ETMG', 'FEAS', 'FIAN', 'FMIT', 'GOVN', 'GRDN', 'HCEV', 'HPCC', 'HSIN', 'HWDE', 'IAMT', 'ICPM', 'IFDN', 'INAS', 'INCA', 'INOV', 'INVA', 'IRMG', 'ISCO', 'ITCM', 'ITMG', 'ITOP', 'ITSP', 'JADN', 'KNOW', 'LEDA', 'MEAS', 'METL', 'MKCM', 'MKTG', 'MLNG', 'MRCH', 'NFTS', 'NTAS', 'NTDS', 'NUAN', 'OCDV', 'OCEN', 'OCOP', 'OFCL', 'ORDI', 'PBMG', 'PDSV', 'PEDP', 'PEMT', 'PENT', 'PGMG', 'POMG', 'PORT', 'PRMG', 'PROD', 'PROF', 'PROG', 'PRTS', 'QUAS', 'QUMG', 'RELM', 'REQM', 'RESC', 'RESD', 'RFEN', 'RLMT', 'RMGT', 'RSCH', 'SALE', 'SCAD', 'SCMG', 'SCMO', 'SCTY', 'SEAC', 'SFAS', 'SFEN', 'SINT', 'SLEN', 'SLMO', 'SORC', 'SSUP', 'STMG', 'STPL', 'SUBF', 'SUPP', 'SUST', 'SWDN', 'SYSP', 'TEAC', 'TECH', 'TEST', 'THIN', 'TMCR', 'UNAN', 'URCH', 'USEV', 'USUP', 'VISL', 'VUAS', 'VURE', 'WFPL');

-- ----------------------------- auxiliares -----------------------------
-- major ISCO (1 digito do codigo do grupo) -> nivel base
-- 0 militares->4 | 1 gerencia->6 | 2 profissionais->5 | 3 tecnicos->4
-- 4 escriturarios->3 | 5 servicos->3 | 6 agro->2 | 7 oficios->3
-- 8 operadores->2 | 9 elementares->1
CREATE TEMP TABLE _base_nivel (major TEXT PRIMARY KEY, nivel_base SMALLINT) ON COMMIT DROP;
INSERT INTO _base_nivel VALUES ('0',4),('1',6),('2',5),('3',4),('4',3),('5',3),('6',2),('7',3),('8',2),('9',1);

CREATE TEMP TABLE _sfia (codigo TEXT PRIMARY KEY) ON COMMIT DROP;
INSERT INTO _sfia VALUES
('ACIN'),
('ADEV'),
('ADMN'),
('AIDE'),
('ANCC'),
('ARCH'),
('ASMG'),
('ASUP'),
('AUDT'),
('AVMT'),
('BENM'),
('BIDM'),
('BINT'),
('BPRE'),
('BPTS'),
('BRMG'),
('BSMO'),
('BUDF'),
('BURM'),
('BUSA'),
('CELO'),
('CEXP'),
('CFMG'),
('CHMG'),
('CIPM'),
('CNSL'),
('COMG'),
('COPL'),
('CPMG'),
('CRIM'),
('CSMG'),
('CSOP'),
('DAAN'),
('DATM'),
('DATS'),
('DBAD'),
('DBDS'),
('DCMA'),
('DEMG'),
('DEMM'),
('DENG'),
('DEPL'),
('DESN'),
('DGFS'),
('DIGM'),
('DLMG'),
('DTAN'),
('EEXP'),
('EMRG'),
('ETDL'),
('ETMG'),
('FEAS'),
('FIAN'),
('FMIT'),
('GOVN'),
('GRDN'),
('HCEV'),
('HPCC'),
('HSIN'),
('HWDE'),
('IAMT'),
('ICPM'),
('IFDN'),
('INAS'),
('INCA'),
('INOV'),
('INVA'),
('IRMG'),
('ISCO'),
('ITCM'),
('ITMG'),
('ITOP'),
('ITSP'),
('JADN'),
('KNOW'),
('LEDA'),
('MEAS'),
('METL'),
('MKCM'),
('MKTG'),
('MLNG'),
('MRCH'),
('NFTS'),
('NTAS'),
('NTDS'),
('NUAN'),
('OCDV'),
('OCEN'),
('OCOP'),
('OFCL'),
('ORDI'),
('PBMG'),
('PDSV'),
('PEDP'),
('PEMT'),
('PENT'),
('PGMG'),
('POMG'),
('PORT'),
('PRMG'),
('PROD'),
('PROF'),
('PROG'),
('PRTS'),
('QUAS'),
('QUMG'),
('RELM'),
('REQM'),
('RESC'),
('RESD'),
('RFEN'),
('RLMT'),
('RMGT'),
('RSCH'),
('SALE'),
('SCAD'),
('SCMG'),
('SCMO'),
('SCTY'),
('SEAC'),
('SFAS'),
('SFEN'),
('SINT'),
('SLEN'),
('SLMO'),
('SORC'),
('SSUP'),
('STMG'),
('STPL'),
('SUBF'),
('SUPP'),
('SUST'),
('SWDN'),
('SYSP'),
('TEAC'),
('TECH'),
('TEST'),
('THIN'),
('TMCR'),
('UNAN'),
('URCH'),
('USEV'),
('USUP'),
('VISL'),
('VUAS'),
('VURE'),
('WFPL');

-- vinculos (todas as ocupacoes) com nivel base por major
CREATE TEMP TABLE _vinculo_base ON COMMIT DROP AS
SELECT oh.habilidade_id,
       b.nivel_base,
       oh.tipo_relacionamento = 'essencial' AS essencial
FROM esco_dataset.ocupacao_habilidade oh
JOIN esco_dataset.ocupacao o ON o.ocupacao_id = oh.ocupacao_id
JOIN esco_dataset.grupo_ocupacao g ON g.grupo_id = o.grupo_ocupacao_id
JOIN _base_nivel b ON b.major = left(g.codigo, 1)
JOIN esco_dataset.habilidade h ON h.habilidade_id = oh.habilidade_id
WHERE NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
  AND h.tipo_conceito = 'habilidade';

-- faixa de nivel por habilidade:
-- essencial define banda [min-1, max+1]; sem essencial, banda deslocada -1
CREATE TEMP TABLE _faixa ON COMMIT DROP AS
SELECT habilidade_id,
       GREATEST(1, MIN(nivel_base) FILTER (WHERE essencial) - 1) AS nivel_min,
       LEAST(7, MAX(nivel_base) FILTER (WHERE essencial) + 1) AS nivel_max
FROM _vinculo_base
GROUP BY habilidade_id
HAVING MIN(nivel_base) FILTER (WHERE essencial) IS NOT NULL;

INSERT INTO _faixa
SELECT habilidade_id,
       GREATEST(1, MIN(nivel_base) - 1),
       LEAST(7, MAX(nivel_base))
FROM _vinculo_base
WHERE essencial = false
  AND habilidade_id NOT IN (SELECT habilidade_id FROM _faixa)
GROUP BY habilidade_id;

-- skills SFIA entram na faixa pelo intervalo OFICIAL dos descritores
INSERT INTO _faixa
SELECT d.habilidade_id, MIN(d.nivel), MAX(d.nivel)
FROM esco_dataset.nivel_habilidade_descritor d
JOIN esco_dataset.habilidade h ON h.habilidade_id = d.habilidade_id
WHERE h.codigo IN (SELECT codigo FROM _sfia)
GROUP BY d.habilidade_id
  HAVING d.habilidade_id NOT IN (SELECT habilidade_id FROM _faixa);

-- skills isoladas (sem vinculo): inferem faixa pela hierarquia
-- pai: uniao da banda dos filhos; filho: banda do pai (em cascata)
INSERT INTO _faixa
SELECT hh.habilidade_pai, MIN(f.nivel_min), MAX(f.nivel_max)
FROM esco_dataset.hierarquia_habilidade hh
JOIN _faixa f ON f.habilidade_id = hh.habilidade_filha
JOIN esco_dataset.habilidade h ON h.habilidade_id = hh.habilidade_pai
WHERE h.tipo_conceito = 'habilidade'
  AND NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
GROUP BY hh.habilidade_pai
  HAVING hh.habilidade_pai NOT IN (SELECT habilidade_id FROM _faixa);

INSERT INTO _faixa
SELECT hh.habilidade_filha, MIN(f.nivel_min), MAX(f.nivel_max)
FROM esco_dataset.hierarquia_habilidade hh
JOIN _faixa f ON f.habilidade_id = hh.habilidade_pai
JOIN esco_dataset.habilidade h ON h.habilidade_id = hh.habilidade_filha
WHERE h.tipo_conceito = 'habilidade'
  AND NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
GROUP BY hh.habilidade_filha
  HAVING hh.habilidade_filha NOT IN (SELECT habilidade_id FROM _faixa);

-- rodadas adicionais de cascata (grupos isolados profundos)

INSERT INTO _faixa
SELECT hh.habilidade_pai, MIN(f.nivel_min), MAX(f.nivel_max)
FROM esco_dataset.hierarquia_habilidade hh
JOIN _faixa f ON f.habilidade_id = hh.habilidade_filha
JOIN esco_dataset.habilidade h ON h.habilidade_id = hh.habilidade_pai
WHERE h.tipo_conceito = 'habilidade'
  AND NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
GROUP BY hh.habilidade_pai
  HAVING hh.habilidade_pai NOT IN (SELECT habilidade_id FROM _faixa);

INSERT INTO _faixa
SELECT hh.habilidade_filha, MIN(f.nivel_min), MAX(f.nivel_max)
FROM esco_dataset.hierarquia_habilidade hh
JOIN _faixa f ON f.habilidade_id = hh.habilidade_pai
JOIN esco_dataset.habilidade h ON h.habilidade_id = hh.habilidade_filha
WHERE h.tipo_conceito = 'habilidade'
  AND NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
GROUP BY hh.habilidade_filha
  HAVING hh.habilidade_filha NOT IN (SELECT habilidade_id FROM _faixa);

INSERT INTO _faixa
SELECT hh.habilidade_pai, MIN(f.nivel_min), MAX(f.nivel_max)
FROM esco_dataset.hierarquia_habilidade hh
JOIN _faixa f ON f.habilidade_id = hh.habilidade_filha
JOIN esco_dataset.habilidade h ON h.habilidade_id = hh.habilidade_pai
WHERE h.tipo_conceito = 'habilidade'
  AND NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
GROUP BY hh.habilidade_pai
  HAVING hh.habilidade_pai NOT IN (SELECT habilidade_id FROM _faixa);

INSERT INTO _faixa
SELECT hh.habilidade_filha, MIN(f.nivel_min), MAX(f.nivel_max)
FROM esco_dataset.hierarquia_habilidade hh
JOIN _faixa f ON f.habilidade_id = hh.habilidade_pai
JOIN esco_dataset.habilidade h ON h.habilidade_id = hh.habilidade_filha
WHERE h.tipo_conceito = 'habilidade'
  AND NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
GROUP BY hh.habilidade_filha
  HAVING hh.habilidade_filha NOT IN (SELECT habilidade_id FROM _faixa);


-- ----------------------------- niveis + descricao por vinculo -----------------------------
-- nivel: faltante preenchido com a heuristica clampada na faixa (existentes preservados);
-- descricao: texto de mercado por vinculo (ocupacao x habilidade x nivel)
UPDATE esco_dataset.ocupacao_habilidade oh
SET nivel_habilidade = COALESCE(oh.nivel_habilidade, v.nivel_calc),
    descricao = v.texto
FROM (
    SELECT oh2.ocupacao_id, oh2.habilidade_id,
           LEAST(f.nivel_max,
                 GREATEST(f.nivel_min,
                     CASE WHEN oh2.tipo_relacionamento = 'essencial'
                          THEN b.nivel_base ELSE b.nivel_base - 1 END)) AS nivel_calc,
           CASE WHEN oh2.tipo_relacionamento = 'essencial'
                THEN 'Essencial para ' || o2.titulo || ': ' || h2.nome ||
                     ' — nível ' ||
                     LEAST(f.nivel_max, GREATEST(f.nivel_min,
                         CASE WHEN oh2.tipo_relacionamento = 'essencial'
                              THEN b.nivel_base ELSE b.nivel_base - 1 END))::text ||
                     ' (' || nh.nome || '): ' || nh.descricao
                ELSE 'Complementar em ' || o2.titulo || ': ' || h2.nome ||
                     ' — nível ' ||
                     LEAST(f.nivel_max, GREATEST(f.nivel_min,
                         CASE WHEN oh2.tipo_relacionamento = 'essencial'
                              THEN b.nivel_base ELSE b.nivel_base - 1 END))::text ||
                     ' (' || nh.nome || '): ' || nh.descricao
           END AS texto
    FROM esco_dataset.ocupacao_habilidade oh2
    JOIN esco_dataset.ocupacao o2 ON o2.ocupacao_id = oh2.ocupacao_id
    JOIN esco_dataset.grupo_ocupacao g2 ON g2.grupo_id = o2.grupo_ocupacao_id
    JOIN _base_nivel b ON b.major = left(g2.codigo, 1)
    JOIN _faixa f ON f.habilidade_id = oh2.habilidade_id
    JOIN esco_dataset.habilidade h2 ON h2.habilidade_id = oh2.habilidade_id
    JOIN esco_dataset.nivel_habilidade nh ON nh.nivel =
             LEAST(f.nivel_max,
                   GREATEST(f.nivel_min,
                       CASE WHEN oh2.tipo_relacionamento = 'essencial'
                            THEN b.nivel_base ELSE b.nivel_base - 1 END))
) v
WHERE oh.ocupacao_id = v.ocupacao_id
  AND oh.habilidade_id = v.habilidade_id;

-- ----------------------------- descritores por habilidade x nivel -----------------------------
-- skills SFIA: oficiais (ja na tabela); demais: sintetizado, liderando com o conteudo
-- da habilidade e fechando com a expectativa de senioridade do nivel
INSERT INTO esco_dataset.nivel_habilidade_descritor (habilidade_id, nivel, descricao, origem)
SELECT f.habilidade_id,
       nh.nivel,
       h.nome || ' no nível ' || nh.nivel || ' (' || nh.nome || '): ' ||
           substr(h.descricao, 1, 350) ||
           E'\nO que se espera do profissional: ' || nh.descricao,
       'sintetizado'
FROM _faixa f
JOIN esco_dataset.habilidade h ON h.habilidade_id = f.habilidade_id
JOIN esco_dataset.nivel_habilidade nh ON nh.nivel BETWEEN f.nivel_min AND f.nivel_max
WHERE NOT EXISTS (SELECT 1 FROM _sfia s WHERE s.codigo = h.codigo)
ON CONFLICT (habilidade_id, nivel) DO UPDATE
SET descricao = EXCLUDED.descricao,
    origem = EXCLUDED.origem;

COMMIT;
