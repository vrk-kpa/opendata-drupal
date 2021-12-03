#!/bin/bash
set -e

# init ckan
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE $DB_DATASTORE_READONLY_USER NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN PASSWORD '$DB_DATASTORE_READONLY_PASS';
    CREATE DATABASE $DB_DATASTORE_READONLY OWNER $POSTGRES_USER ENCODING 'utf-8';
    GRANT ALL PRIVILEGES ON DATABASE $DB_DATASTORE_READONLY TO $POSTGRES_USER;
EOSQL

# init drupal
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE ROLE $DB_DRUPAL_USER LOGIN PASSWORD '$DB_DRUPAL_PASS';
    CREATE DATABASE $DB_DRUPAL OWNER $DB_DRUPAL_USER ENCODING 'utf-8';
    GRANT ALL PRIVILEGES ON DATABASE $DB_DRUPAL TO $POSTGRES_USER;
EOSQL