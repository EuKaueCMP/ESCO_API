CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_oh_ocup_tipo
ON esco_dataset.ocupacao_habilidade (ocupacao_id, tipo_relacionamento)
INCLUDE (habilidade_id, nivel_habilidade);

CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_oh_hab_tipo
ON esco_dataset.ocupacao_habilidade (habilidade_id, tipo_relacionamento)
INCLUDE (ocupacao_id, nivel_habilidade);

CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_ocupacao_peso
ON esco_dataset.ocupacao (peso_relevancia)
WHERE peso_relevancia = 5;

ANALYZE esco_dataset.ocupacao_habilidade;
ANALYZE esco_dataset.ocupacao;
