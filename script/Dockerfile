# ESCO DB — imagem PostgreSQL pré-carregada com o dataset ESCO + Next Hire
# ---------------------------------------------------------------------------
# No primeiro start de um container desta imagem, o entrypoint oficial do
# postgres executa automaticamente os scripts de /docker-entrypoint-initdb.d
# em ordem alfabética:
#   01 — esco_database_create.sql   (banco esco_db, schema, ENUMs e tabelas)
#   02 — esco_database_refactor.sql (tabelas de vínculo exigidas pela carga)
#   03 — esco_db_refatorado.sql     (carga completa: ~15s)
#
# Como cada arquivo roda em uma sessão psql separada (sempre no banco padrão),
# os arquivos 02 e 03 recebem `\c esco_db` no início, em tempo de build, para
# reproduzir a execução manual contra o banco certo.
#
# Build:  docker build -t esco-db:latest script
# Run:    docker run -d --name esco-db -e POSTGRES_PASSWORD=<senha> esco-db:latest
# Logs:   docker logs esco-db
# ---------------------------------------------------------------------------
FROM postgres:latest

COPY CREATE/esco_database_create.sql   /tmp/src/01_create.sql
COPY CREATE/esco_database_refactor.sql /tmp/src/02_refactor.sql
COPY INSERTs/esco_db_refatorado.sql    /tmp/src/03_insert.sql

RUN mkdir -p /docker-entrypoint-initdb.d \
 && cp /tmp/src/01_create.sql /docker-entrypoint-initdb.d/01_esco_database_create.sql \
 && printf '\\c esco_db\n' | cat - /tmp/src/02_refactor.sql > /docker-entrypoint-initdb.d/02_esco_database_refactor.sql \
 && printf '\\c esco_db\n' | cat - /tmp/src/03_insert.sql > /docker-entrypoint-initdb.d/03_esco_db_refatorado.sql \
 && rm -rf /tmp/src
