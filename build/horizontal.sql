CREATE SEQUENCE IF NOT EXISTS id_seq;

ALTER TABLE users ADD CONSTRAINT date_of_birth CHECK (date_of_birth > '2000-01-01');

CREATE EXTENSION postgres_fdw;
CREATE SERVER postgres_1 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'postgresql-b1', port '5432', dbname 'postgres');
CREATE USER MAPPING FOR postgres SERVER postgres_1 OPTIONS (user 'postgres', password 'postgres');

CREATE FOREIGN TABLE users_1
    (
        id int8 NOT NULL,
        firstname     VARCHAR(50)  NOT NULL,
        lastname      VARCHAR(50)  NOT NULL,
        email         VARCHAR(255) NOT NULL,
        password      VARCHAR(255) NOT NULL,
        date_of_birth DATE         NOT NULL,
        created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) SERVER postgres_1 OPTIONS (SCHEMA_NAME 'public', TABLE_NAME 'users');

CREATE SERVER postgres_2 FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'postgresql-b2', port '5432', dbname 'postgres');
CREATE USER MAPPING FOR postgres SERVER postgres_2 OPTIONS (user 'postgres', password 'postgres');

CREATE FOREIGN TABLE users_2
    (
        id int8 NOT NULL,
        firstname     VARCHAR(50)  NOT NULL,
        lastname      VARCHAR(50)  NOT NULL,
        email         VARCHAR(255) NOT NULL,
        password      VARCHAR(255) NOT NULL,
        date_of_birth DATE         NOT NULL,
        created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) SERVER postgres_2 OPTIONS (SCHEMA_NAME 'public', TABLE_NAME 'users');

CREATE VIEW v_users AS
SELECT *
FROM users_1
UNION ALL
SELECT *
FROM users_2;

CREATE RULE users_insert AS ON INSERT TO users DO INSTEAD NOTHING;
CREATE RULE users_update AS ON UPDATE TO users DO INSTEAD NOTHING;
CREATE RULE users_delete AS ON DELETE TO users DO INSTEAD NOTHING;

CREATE RULE users_insert_to_1 AS ON INSERT TO users WHERE (date_of_birth < '2000-01-01') DO INSTEAD INSERT INTO users_1 VALUES (NEW.*);
CREATE RULE users_insert_to_2 AS ON INSERT TO users WHERE (date_of_birth >= '2000-01-01') DO INSTEAD INSERT INTO users_2 VALUES (NEW.*);