-- ESCO / Next Hire — Adicao SFIA 9 (codigos de habilidade e niveis 1-7)
-- ---------------------------------------------------------------------------
-- Execute DEPOIS de script/CREATE/esco_database_create.sql e
-- script/CREATE/esco_database_refactor.sql, e ANTES de
-- script/INSERTs/esco_sfia_niveis.sql.
--
-- Idempotente: pode ser reexecutado em bancos que ja possuam a carga ESCO
-- completa (as colunas/tabela sao adicionadas com IF NOT EXISTS).
--
-- Conteudo:
--   - habilidade.codigo: codigo da habilidade no padrao SFIA
--     (4 letras maiusculas; skills SFIA usam o codigo oficial, as demais
--     recebem um codigo gerado seguindo o mesmo padrao)
--   - nivel_habilidade: os 7 niveis de responsabilidade do SFIA 9 com nome
--     e descricao em portugues
--   - ocupacao_habilidade.nivel_habilidade: nivel SFIA (1-7) exigido da
--     habilidade em cada ocupacao
-- ---------------------------------------------------------------------------

SET search_path TO esco_dataset;

ALTER TABLE habilidade
    ADD COLUMN IF NOT EXISTS codigo VARCHAR(8);

CREATE UNIQUE INDEX IF NOT EXISTS uq_habilidade_codigo
    ON habilidade (codigo)
    WHERE codigo IS NOT NULL;

CREATE TABLE IF NOT EXISTS nivel_habilidade
(
    nivel SMALLINT PRIMARY KEY,
    nome TEXT NOT NULL,
    descricao TEXT NOT NULL
);

ALTER TABLE ocupacao_habilidade
    ADD COLUMN IF NOT EXISTS nivel_habilidade SMALLINT REFERENCES nivel_habilidade(nivel);

ALTER TABLE ocupacao
    ADD COLUMN IF NOT EXISTS peso_relevancia SMALLINT;

ALTER TABLE habilidade
    ADD COLUMN IF NOT EXISTS peso_relevancia SMALLINT;

CREATE TABLE IF NOT EXISTS nivel_habilidade_descritor
(
    habilidade_id INTEGER NOT NULL REFERENCES habilidade (habilidade_id) ON DELETE CASCADE,
    nivel SMALLINT NOT NULL REFERENCES nivel_habilidade (nivel) ON DELETE CASCADE,
    descricao TEXT NOT NULL,
    descricao_en TEXT,
    CONSTRAINT nivel_habilidade_descritor_pkey PRIMARY KEY (habilidade_id, nivel),
    CONSTRAINT nivel_habilidade_descritor_habilidade_id_fkey FOREIGN KEY (habilidade_id)
        REFERENCES habilidade (habilidade_id) ON DELETE CASCADE,
    CONSTRAINT nivel_habilidade_descritor_nivel_fkey FOREIGN KEY (nivel)
        REFERENCES nivel_habilidade (nivel) ON DELETE CASCADE
);

ALTER TABLE nivel_habilidade_descritor
    ADD COLUMN IF NOT EXISTS origem TEXT NOT NULL DEFAULT 'sintetizado';

ALTER TABLE ocupacao_habilidade
    ADD COLUMN IF NOT EXISTS descricao TEXT;

-- arvore de views SFIA (dominios, sub-views, folhas) + atributos genericos x niveis
CREATE TABLE IF NOT EXISTS sfia_atributo
(
    slug TEXT PRIMARY KEY,
    codigo TEXT,
    nome_en TEXT,
    nome_pt TEXT
);

CREATE TABLE IF NOT EXISTS sfia_atributo_nivel
(
    slug TEXT NOT NULL REFERENCES sfia_atributo (slug) ON DELETE CASCADE,
    nivel SMALLINT NOT NULL REFERENCES nivel_habilidade (nivel) ON DELETE CASCADE,
    descricao_en TEXT,
    descricao_pt TEXT,
    PRIMARY KEY (slug, nivel)
);

CREATE TABLE IF NOT EXISTS sfia_view
(
    view_id SERIAL PRIMARY KEY,
    caminho TEXT NOT NULL UNIQUE,
    slug TEXT,
    slug_pai TEXT,
    nome_en TEXT,
    nome_pt TEXT,
    profundidade SMALLINT
);

CREATE TABLE IF NOT EXISTS sfia_view_habilidade
(
    caminho TEXT NOT NULL REFERENCES sfia_view (caminho) ON DELETE CASCADE,
    habilidade_id INTEGER NOT NULL REFERENCES habilidade (habilidade_id) ON DELETE CASCADE,
    PRIMARY KEY (caminho, habilidade_id)
);
