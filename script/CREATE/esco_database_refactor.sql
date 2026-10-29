-- ESCO / Next Hire — Extensões de schema para os vínculos ausentes
-- ---------------------------------------------------------------------------
-- Execute DEPOIS de script/CREATE/esco_database_create.sql e ANTES de
-- script/INSERTs/esco_db_refatorado.sql.
--
-- Este arquivo não altera as tabelas existentes. Ele apenas adiciona as
-- tabelas de vínculo que existem na fonte ESCO e ainda não estavam
-- representadas no schema:
--   - hierarquia_grupo_ocupacao (ISCO grupo pai -> grupo filho)
--   - hierarquia_ocupacao      (ocupação pai -> ocupação filha)
--   - ocupacao_colecao         (ocupação -> coleção)
--   - relacao_habilidade       (habilidade -> habilidade relacionada)
--
-- As tabelas são idempotentes (IF NOT EXISTS) para permitir reexecução.
-- ---------------------------------------------------------------------------

SET search_path TO esco_dataset;

CREATE TABLE IF NOT EXISTS hierarquia_grupo_ocupacao
(
    grupo_pai_id INTEGER NOT NULL REFERENCES esco_dataset.grupo_ocupacao(grupo_id),
    grupo_filho_id INTEGER NOT NULL REFERENCES esco_dataset.grupo_ocupacao(grupo_id),

    PRIMARY KEY (grupo_pai_id, grupo_filho_id)
);

CREATE INDEX IF NOT EXISTS idx_hierarquia_grupo_ocupacao_filho
    ON hierarquia_grupo_ocupacao (grupo_filho_id);


CREATE TABLE IF NOT EXISTS hierarquia_ocupacao
(
    ocupacao_pai_id INTEGER NOT NULL REFERENCES esco_dataset.ocupacao(ocupacao_id),
    ocupacao_filha_id INTEGER NOT NULL REFERENCES esco_dataset.ocupacao(ocupacao_id),

    PRIMARY KEY (ocupacao_pai_id, ocupacao_filha_id)
);

CREATE INDEX IF NOT EXISTS idx_hierarquia_ocupacao_filha
    ON hierarquia_ocupacao (ocupacao_filha_id);


CREATE TABLE IF NOT EXISTS ocupacao_colecao
(
    ocupacao_id INTEGER NOT NULL REFERENCES esco_dataset.ocupacao(ocupacao_id),
    colecao_id INTEGER NOT NULL REFERENCES esco_dataset.colecao(colecao_id),

    PRIMARY KEY (ocupacao_id, colecao_id)
);

CREATE INDEX IF NOT EXISTS idx_ocupacao_colecao_colecao
    ON ocupacao_colecao (colecao_id);


CREATE TABLE IF NOT EXISTS relacao_habilidade
(
    habilidade_origem_id INTEGER NOT NULL REFERENCES esco_dataset.habilidade(habilidade_id),
    habilidade_relacionada_id INTEGER NOT NULL REFERENCES esco_dataset.habilidade(habilidade_id),
    tipo_relacionamento esco_dataset.tipo_relacionamento_enum NOT NULL,

    PRIMARY KEY (habilidade_origem_id, habilidade_relacionada_id),
    CONSTRAINT ck_relacao_habilidade_nao_autorreferente
        CHECK (habilidade_origem_id <> habilidade_relacionada_id)
);

CREATE INDEX IF NOT EXISTS idx_relacao_habilidade_relacionada
    ON relacao_habilidade (habilidade_relacionada_id);
