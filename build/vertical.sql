CREATE TABLE users_1
(
    CHECK (date_of_birth < '2000-01-01')
) INHERITS (users);

CREATE RULE users_insert_to_users_1 AS ON INSERT TO users WHERE (date_of_birth < '2000-01-01') DO INSTEAD INSERT INTO users_1 VALUES (NEW.*);

CREATE TABLE users_2
(
    CHECK (date_of_birth >= '2000-01-01')
) INHERITS (users);

CREATE RULE users_insert_to_users_2 AS ON INSERT TO users WHERE (date_of_birth >= '2000-01-01') DO INSTEAD INSERT INTO users_2 VALUES (NEW.*);
