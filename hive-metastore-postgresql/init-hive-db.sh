#!/bin/bash
set -e

echo "Initializing Postgres DB metastore with user ${POSTGRES_USER} on Schema 'public'"
echo "Creating DB user hive and granting required privileges"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER hive WITH PASSWORD 'hive';
  CREATE DATABASE metastore;
  GRANT ALL PRIVILEGES ON DATABASE metastore TO hive;
  \c metastore
  \pset tuples_only
  \o /tmp/grant-privs
SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "' || schemaname || '"."' || tablename || '" TO hive ;'
FROM pg_tables
WHERE tableowner = CURRENT_USER and schemaname = 'public';
  \o
  \i /tmp/grant-privs
EOSQL


#   \i /hive/hive-schema-postgres.sql
#  \i /hive/hive-txn-schema-postgres.sql