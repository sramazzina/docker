CREATE USER @@DB_USER@@ WITH SUPERUSER PASSWORD '@@DB_USER_PWD@@';
CREATE DATABASE @@DB_SCHEMA@@ OWNER @@DB_USER@@ ENCODING 'UNICODE' TEMPLATE template1;
-- Needed to support PostgreSQL Rel > 9.1
alter user @@DB_USER@@ set standard_conforming_strings = on;
alter user @@DB_USER@@ set bytea_output = 'escape';
-- UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
-- DROP DATABASE template1;
-- CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';
-- UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
