CREATE DATABASE esco_db;
CREATE SCHEMA IF NOT EXISTS esco_dataset;

-- ENUMs do banco de dados
---- status 
CREATE TYPE esco_dataset.status_enum
AS ENUM('Released', 'Deprecated');

---- tipo
CREATE TYPE esco_dataset.tipo_habilidade_enum
AS ENUM('Conhecimento', 'Competencia');

---- tipo conceito
CREATE TYPE esco_dataset.tipo_conceito_enum
AS ENUM ('Habilidade', 'GrupoHabilidade');
	
---- nivel reutilizacao
CREATE TYPE esco_dataset.nivel_reutilizacao_enum 
AS ENUM('Transversal', 'Intersetorial', 'EspecificoSetor', 'EspecificoOcupacao');

---- tipo de relacionamento entre ocupação e habilidade
CREATE TYPE esco_dataset.tipo_relacionamento_enum
AS ENUM ('Essential', 'Optional');
----

CREATE TABLE  esco_dataset.grupo_ocupacao
(
	grupo_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	codigo VARCHAR(20) UNIQUE NOT NULL,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL
);

CREATE TABLE esco_dataset.ocupacao
(
	ocupacao_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	titulo TEXT NOT NULL,
	descricao TEXT NOT NULL,
	status esco_dataset.status_enum NOT NULL,
	nomes_alternativos JSONB,
	grupo_ocupacao_id INTEGER NOT NULL REFERENCES grupo_ocupacao(grupo_id)
);

CREATE TABLE esco_dataset.habilidade
(
	habilidade_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL,
	tipo_habilidade esco_dataset.tipo_habilidade_enum NOT NULL,
	nomes_alternativos JSONB,
	status esco_dataset.status_enum NOT NULL,
	nivel_reutilizacao esco_dataset.nivel_reutilizacao_enum NOT NULL,
	tipo_conceito esco_dataset.tipo_conceito_enum NOT NULL
);

CREATE TABLE ocupacao_habilidade
(
	ocupacao_id INTEGER NOT NULL REFERENCES esco_dataset.ocupacao(ocupacao_id),
	habilidade_id INTEGER NOT NULL REFERENCES esco_dataset.habilidade(habilidade_id),
	tipo_relacionamento esco_dataset.tipo_relacionamento_enum NOT NULL,
	
	PRIMARY KEY (ocupacao_id, habilidade_id)
);

CREATE TABLE esco_dataset.hierarquia_habilidade
(
	habilidade_pai INTEGER NOT NULL REFERENCES esco_dataset.habilidade(habilidade_id),
	habilidade_filha INTEGER NOT NULL REFERENCES esco_dataset.habilidade(habilidade_id),
	
	PRIMARY KEY (habilidade_pai, habilidade_filha)
);

CREATE TABLE esco_dataset.colecao
(
	colecao_id SERIAL PRIMARY KEY,
	uri VARCHAR(100) UNIQUE NOT NULL,
	nome TEXT NOT NULL,
	descricao TEXT NOT NULL
);

CREATE TABLE habilidade_colecao
(
	habilidade_id INTEGER NOT NULL REFERENCES esco_dataset.habilidade(habilidade_id),
	colecao_id INTEGER NOT NULL REFERENCES esco_dataset.colecao(colecao_id),
	
	PRIMARY KEY (habilidade_id, colecao_id)
);

	