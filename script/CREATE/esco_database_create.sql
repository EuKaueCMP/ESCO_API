CREATE DATABASE esco_db;
\c esco_db
CREATE SCHEMA IF NOT EXISTS esco_dataset;
-- Faz com que o postgres procure e rode comandos dentro do schema definido
SET search_path TO esco_dataset; 

-- Importando a extensão pg_trgm
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- ENUMs do banco de dados
---- status 
CREATE TYPE status_enum
AS ENUM('released', 'deprecated');

---- tipo habilidade
CREATE TYPE tipo_habilidade_enum
AS ENUM('conhecimento', 'competencia');

-- classificacao habilidade
CREATE TYPE classificacao_habilidade_enum
AS ENUM('hardskill', 'softskill');

---- tipo conceito
CREATE TYPE tipo_conceito_enum
AS ENUM ('habilidade', 'grupo_habilidade');
	
---- nivel reutilizacao
CREATE TYPE nivel_reutilizacao_enum 
AS ENUM('transversal', 'intersetorial', 'especifico_setor', 'especifico_ocupacao');

---- tipo de relacionamento entre ocupação e habilidade
CREATE TYPE tipo_relacionamento_enum
AS ENUM ('essencial', 'opcional');
----

-- Niveis de responsabilidade SFIA (1 a 7) usados pelas habilidades e pelo
-- vinculo ocupacao-habilidade. Veja script/INSERTs/esco_sfia_niveis.sql.
CREATE TABLE nivel_habilidade
(
	nivel SMALLINT PRIMARY KEY,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL
);


CREATE TABLE grupo_ocupacao
(
	grupo_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	codigo VARCHAR(20) UNIQUE NOT NULL,
	titulo TEXT NOT NULL,
	descricao TEXT NOT NULL,

	search_vector TSVECTOR
		GENERATED ALWAYS AS(
			setweight(to_tsvector('portuguese', coalesce(titulo, '')), 'A') ||
			setweight(to_tsvector('portuguese', coalesce(descricao, '')), 'B')
		) STORED
);

CREATE INDEX idx_grupo_ocupacao_fts
	ON grupo_ocupacao
	USING GIN (search_vector);


CREATE TABLE ocupacao
(
	ocupacao_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	titulo TEXT NOT NULL,
	descricao TEXT NOT NULL,
	status status_enum NOT NULL,
	-- peso de relevancia de busca no mercado (1-5); veja esco_pesos_relevancia.sql
	peso_relevancia SMALLINT,
	nomes_alternativos JSONB,
	grupo_ocupacao_id INTEGER NOT NULL REFERENCES grupo_ocupacao(grupo_id),
	search_vector TSVECTOR
		GENERATED ALWAYS AS(
			setweight(to_tsvector('portuguese', coalesce(titulo, '')), 'A') ||
			setweight(to_tsvector('portuguese', coalesce(descricao, '')), 'B')
		) STORED
);

CREATE INDEX idx_ocupacao_fts
	ON ocupacao
	USING GIN (search_vector);



CREATE TABLE habilidade
(
	habilidade_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	codigo VARCHAR(8) UNIQUE, -- codigo no padrao SFIA (4 letras maiusculas)
	-- peso de relevancia de busca no mercado (1-5); NULL para grupos de habilidade
	peso_relevancia SMALLINT,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL,
	nomes_alternativos JSONB,
	status status_enum NOT NULL,
	tipo_habilidade tipo_habilidade_enum,
	nivel_reutilizacao nivel_reutilizacao_enum,
	tipo_conceito tipo_conceito_enum NOT NULL,
	classificacao_habilidade classificacao_habilidade_enum,
	search_vector TSVECTOR
		GENERATED ALWAYS AS(
			setweight(to_tsvector('portuguese',	coalesce(nome, '')), 'A') ||
			setweight(to_tsvector('portuguese', coalesce(descricao, '')), 'B') 
		) STORED,
	
	CONSTRAINT ck_habilidade_campos_por_conceito
    CHECK (
        (
            tipo_conceito = 'habilidade'
            AND(
	            (
		            tipo_habilidade IS NOT NULL
	    	        AND nivel_reutilizacao IS NOT NULL    
	            )
	            OR
	            (
	            	tipo_habilidade IS NULL
	            	AND nivel_reutilizacao IS NULL
	            )
            )
        OR
        (
            tipo_conceito = 'grupo_habilidade'
            AND tipo_habilidade IS NULL
            AND nivel_reutilizacao IS NULL
            AND classificacao_habilidade IS NULL
        )
        )
    )
);

CREATE INDEX idx_habilidade_fts
	ON habilidade
	USING GIN (search_vector);


CREATE TABLE ocupacao_habilidade
(
	ocupacao_id INTEGER NOT NULL REFERENCES ocupacao(ocupacao_id),
	habilidade_id INTEGER NOT NULL REFERENCES habilidade(habilidade_id),
	tipo_relacionamento tipo_relacionamento_enum NOT NULL,
	-- nivel SFIA (1-7) exigido da habilidade nesta ocupacao
	nivel_habilidade SMALLINT REFERENCES nivel_habilidade(nivel),
	-- texto de mercado do vinculo (ocupacao + habilidade + nivel)
	descricao TEXT,

	PRIMARY KEY (ocupacao_id, habilidade_id)
);

-- Descritor de nivel especifico por habilidade (faixa SFIA real da skill),
-- texto oficial do site sfia-online.org/pt (descritores + fallback EN).
-- Veja script/INSERTs/esco_sfia_descritores.sql.
CREATE TABLE nivel_habilidade_descritor
(
	habilidade_id INTEGER NOT NULL REFERENCES habilidade(habilidade_id) ON DELETE CASCADE,
	nivel SMALLINT NOT NULL REFERENCES nivel_habilidade(nivel) ON DELETE CASCADE,
	descricao TEXT NOT NULL,
	descricao_en TEXT,
	-- 'sfia_oficial' (descritor oficial do site SFIA) ou 'sintetizado' (essencia
	-- oficial do nivel + texto ESCO da habilidade; veja esco_niveis_expandidos.sql)
	origem TEXT NOT NULL DEFAULT 'sintetizado',

	PRIMARY KEY (habilidade_id, nivel)
);


CREATE TABLE hierarquia_habilidade
(
	habilidade_pai INTEGER NOT NULL REFERENCES habilidade(habilidade_id),
	habilidade_filha INTEGER NOT NULL REFERENCES habilidade(habilidade_id),
	
	PRIMARY KEY (habilidade_pai, habilidade_filha)
);


CREATE TABLE colecao
(
	colecao_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL,
	search_vector TSVECTOR
	GENERATED ALWAYS AS(
		setweight(to_tsvector('portuguese', coalesce(nome, '')), 'A') ||
		setweight(to_tsvector('portuguese', coalesce(descricao, '')), 'B')
	) STORED
);

CREATE INDEX idx_colecao_fts
	ON colecao
	USING GIN(search_vector);

CREATE TABLE habilidade_colecao
(
	habilidade_id INTEGER NOT NULL REFERENCES habilidade(habilidade_id),
	colecao_id INTEGER NOT NULL REFERENCES colecao(colecao_id),
	
	PRIMARY KEY (habilidade_id, colecao_id)
);