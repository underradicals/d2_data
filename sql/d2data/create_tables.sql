DROP TABLE IF EXISTS damage_type;
DROP TABLE IF EXISTS stat_definition;
DROP TABLE IF EXISTS lore_definition;
DROP TABLE IF EXISTS ammo_type;
DROP TABLE IF EXISTS equipment_slot_definition;
DROP TABLE IF EXISTS weapon;
DROP TABLE IF EXISTS socket;
DROP TABLE IF EXISTS weapon_stat;
DROP TABLE IF EXISTS socket_stat;

-- (Data Definition Language) DDL

-- DestinyDamageTypes
CREATE TABLE IF NOT EXISTS damage_type
(
    id          integer not null,
    name        text    not null,
    description text    not null,
    icon        text    not null,
    red         integer not null,
    green       integer not null,
    blue        integer not null,
    alpha       integer not null,
    constraint pk_damage_types primary key (id)
);

-- Create Indexes
CREATE INDEX IF NOT EXISTS idx_damage_type_name ON damage_type (name);

CREATE TABLE IF NOT EXISTS stat_definition
(
    id          integer not null,
    name        text    not null,
    description text    not null,
    icon        text    not null,
    constraint pk_stat_definition primary key (id)
);

CREATE INDEX IF NOT EXISTS idx_stat_definition_name ON stat_definition (name);

CREATE TABLE IF NOT EXISTS lore_definition
(
    id          integer not null,
    name        text    not null,
    description text    not null,
    icon        text    not null,
    subtitle    text    not null,
    constraint pk_stat_definition primary key (id)
);

CREATE INDEX IF NOT EXISTS idx_lore_definition ON lore_definition (name);

CREATE TABLE IF NOT EXISTS ammo_type
(
    id   integer not null,
    name text    not null,
    icon text    not null,
    constraint pk_ammo_type primary key (id)
);

CREATE INDEX IF NOT EXISTS idx_ammo_type_name ON ammo_type (name);


CREATE TABLE IF NOT EXISTS equipment_slot_definition
(
    id          integer not null,
    name        text    not null,
    description text    not null,
    constraint pk_equipment_slot_definition primary key (id)
);

CREATE INDEX IF NOT EXISTS idx_equipment_slot_definition_name ON equipment_slot_definition (name);

CREATE TABLE IF NOT EXISTS weapon
(
    id                  integer not null,
    name                text    not null,
    description         text    not null,
    icon                text    not null,
    watermark           text    not null,
    screenshot          text    not null,
    displayName         text    not null,
    flavorText          text    not null,
    tierType            text    not null,
    loreId              integer null,
    ammoTypeId          integer not null,
    equipmentSlotTypeId integer not null,
    damageTypeId        integer not null,
    constraint fk_weapon_lore_id foreign key (loreId) references lore_definition (id),
    constraint fk_weapon_ammoType_id foreign key (ammoTypeId) references ammo_type (id),
    constraint fk_weapon_equipment_slot_type_id foreign key (equipmentSlotTypeId) references equipment_slot_definition (id),
    constraint fk_weapon_damage_type_id foreign key (damageTypeId) references damage_type (id),
    constraint pk_weapon primary key (id)
);

CREATE INDEX IF NOT EXISTS idx_weapon_name ON weapon (name);
CREATE INDEX IF NOT EXISTS idx_weapon_tierType ON weapon (tierType);
CREATE INDEX IF NOT EXISTS idx_weapon_displayName ON weapon (displayName);

CREATE TABLE IF NOT EXISTS socket
(
    id          integer not null,
    name        text    not null,
    description text    not null,
    icon        text    null,
    displayName text    not null,
    constraint pk_socket primary key (id)
);

CREATE INDEX IF NOT EXISTS idx_socket_name ON socket (name);
CREATE INDEX IF NOT EXISTS idx_socket_displayName ON socket (displayName);


CREATE TABLE IF NOT EXISTS weapon_stat
(
    weaponId not null,
    statId   not null,
    value    not null,
    constraint fk_weapon_stat_weaponId foreign key (weaponId) references weapon (id),
    constraint fk_weapon_stat_statId foreign key (statId) references stat_definition (id),
    constraint pk_weapon_stat primary key (weaponId, statId)
);

CREATE INDEX IF NOT EXISTS idx_socket_value ON weapon_stat (value);

CREATE TABLE IF NOT EXISTS socket_stat
(
    socketId not null,
    statId   not null,
    value    not null,
    constraint fk_socket_stat_socketId foreign key (socketId) references socket (id),
    constraint fk_socket_stat_statId foreign key (statId) references stat_definition (id),
    constraint pk_socket_stat primary key (socketId, statId)
);

CREATE INDEX IF NOT EXISTS idx_socket_stat_value ON socket_stat (value);