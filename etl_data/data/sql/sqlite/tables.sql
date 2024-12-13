DROP TABLE IF EXISTS damage_types;
DROP TABLE IF EXISTS lore_definitions;
DROP TABLE IF EXISTS stat_definitions;
DROP TABLE IF EXISTS plug_set_definitions;
DROP TABLE IF EXISTS socket_category_definitions;
DROP TABLE IF EXISTS collectible_definitions;
DROP TABLE IF EXISTS image_urls;

CREATE TABLE IF NOT EXISTS damage_types
(
    id          INTEGER,
    name        TEXT NOT NULL,
    icon        TEXT NOT NULL,
    description TEXT NOT NULL,
    color       TEXT NOT NULL,
    CONSTRAINT pk_damage_types PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS lore_definitions
(
    id          INTEGER,
    name        TEXT NOT NULL,
    description TEXT NOT NULL,
    subtitle    TEXT NOT NULL,
    CONSTRAINT pk_lore_definitions PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS stat_definitions
(
    id          INTEGER,
    name        TEXT NOT NULL,
    description TEXT NOT NULL,
    CONSTRAINT pk_stat_definitions PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS plug_set_definitions
(
    id         INTEGER,
    json_array BLOB NOT NULL,
    CONSTRAINT pk_plug_set_definitions PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS socket_category_definitions
(
    id          INTEGER,
    name        TEXT NOT NULL,
    description TEXT NOT NULL,
    CONSTRAINT pk_socket_category_definitions PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS collectible_definitions
(
    id            INTEGER,
    name          TEXT NOT NULL,
    source_string TEXT NOT NULL,
    CONSTRAINT pk_collectible_definitions PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS image_urls
(
    id   INTEGER,
    name TEXT NOT NULL,
    url  TEXT NOT NULL,
    type TEXT NOT NULL,
    CONSTRAINT pk_image_urls PRIMARY KEY (id)
);