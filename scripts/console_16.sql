CREATE DATABASE TAB1;

CREATE TABLE USER1
(
    id integer PRIMARY KEY,
    user2_id integer,
    bud integer NOT NULL
);
CREATE TABLE USER2
(
    id integer PRIMARY KEY,
    bud integer NOT NULL
);

CREATE TABLE users
(
    id integer PRIMARY KEY,
    f_n VARCHAR NOT NULL,
    l_n VARCHAR NOT NULL
);

CREATE TABLE acc
(
    id integer PRIMARY KEY,
    users_id integer NOT NULL ,
    bal integer
);


