ATTACH DATABASE 'world_content.db' as world_content;

-- (Data Manipulation Language) DML
------------------------------------------------------------------------------------------------------------------------

INSERT INTO damage_type (id, name, description, icon, red, green, blue, alpha)
select json -> 'hash'                                as Id,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description,
       json -> 'displayProperties' ->> 'icon'        as Icon,
       json -> 'color' ->> 'red'                     as Red,
       json -> 'color' ->> 'green'                   as Green,
       json -> 'color' ->> 'blue'                    as Blue,
       json -> 'color' ->> 'alpha'                   as Alpha
from world_content.DestinyDamageTypeDefinition
where Icon IS NOT NULL;

INSERT INTO stat_definition (id, name, description, icon)
select json -> 'hash'                                       as Id,
       json -> 'displayProperties' ->> 'name'               as Name,
       json -> 'displayProperties' ->> 'description'        as Description,
       COALESCE(json -> 'displayProperties' ->> 'icon', '') as Icon
from world_content.DestinyStatDefinition
where Name != '';

INSERT INTO lore_definition (id, name, description, icon, subtitle)
select json -> 'hash'                                       as Id,
       json -> 'displayProperties' ->> 'name'               as Name,
       json -> 'displayProperties' ->> 'description'        as Description,
       COALESCE(json -> 'displayProperties' ->> 'icon', '') as Icon,
       COALESCE(json ->> 'subtitle', '')                    as Subtitle
from world_content.DestinyLoreDefinition
where Name != ''
  and Description != ''
  and Icon != '';

INSERT INTO ammo_type (id, name, icon)
VALUES (1, "Primary", "/common/destiny2_content/icons/99f3733354862047493d8550e46a45ec.png"),
       (2, "Special", "/common/destiny2_content/icons/d920203c4fd4571ae7f39eb5249eaecb.png"),
       (3, "Heavy", "/common/destiny2_content/icons/78ef0e2b281de7b60c48920223e0f9b1.png");


INSERT INTO equipment_slot_definition (id, name, description)
select json ->> 'hash'                               as EquipmentSlotId,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description
from world_content.DestinyEquipmentSlotDefinition
where json ->> 'equipmentCategoryHash' = 1885559401;


INSERT INTO weapon (id, name, description, icon, watermark, screenshot, displayName, flavorText, tierType, loreId,
                    ammoTypeId, equipmentSlotTypeId, damageTypeId)
select json ->> 'hash'                                       as WeaponId,
       json -> 'displayProperties' ->> 'name'                as Name,
       json -> 'displayProperties' ->> 'description'         as Description,
       json -> 'displayProperties' ->> 'icon'                as Icon,
       json ->> 'iconWatermark'                              as Watermark,
       json ->> 'screenshot'                                 as Screenshot,
       json ->> 'itemTypeDisplayName'                        as DisplayName,
       json ->> 'flavorText'                                 as FlavorText,
       json ->> 'inventory' ->> 'tierTypeName'               as TierType,
       coalesce(json ->> 'loreHash', '')                     as LoreTypeId,
       json ->> 'equippingBlock' ->> 'ammoType'              as AmmoTypeId,
       json ->> 'equippingBlock' ->> 'equipmentSlotTypeHash' as EquipmentSlotTypeId,
       json ->> 'defaultDamageTypeHash'                      as DamageTypeId
from world_content.DestinyInventoryItemDefinition
where json ->> 'itemType' = 3;


INSERT INTO socket (id, name, description, icon, displayName)
select json -> 'hash'                                as Id,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description,
       json -> 'displayProperties' ->> 'icon'        as Icon,
       json ->> 'itemTypeDisplayName'                as DisplayName
from world_content.DestinyInventoryItemDefinition
where exists (select 1
              from json_each(world_content.DestinyInventoryItemDefinition.json ->> 'itemCategoryHashes')
              where json_each.value = 610365472)
  and DisplayName != 'Weapon Ornament'
  and Name != '';


INSERT INTO weapon_stat (weaponId, statId, value)
select distinct DestinyInventoryItemDefinition.json ->> 'hash' as WeaponId,
                json_each.value ->> 'statTypeHash'             as StatDefinitionHash,
                json_each.value ->> 'value'                    as WeaponStatValue
from world_content.DestinyInventoryItemDefinition, json_each(world_content.DestinyInventoryItemDefinition.json -> 'investmentStats')
where world_content.DestinyInventoryItemDefinition.json ->> 'itemType' = 3
order by WeaponId;



INSERT INTO socket_stat (socketId, statId, value)
select distinct world_content.DestinyInventoryItemDefinition.json ->> 'hash' as SocketId,
                json_each.value ->> 'statTypeHash'                           as StatDefinitionHash,
                json_each.value ->> 'value'                                  as WeaponStatValue
from world_content.DestinyInventoryItemDefinition, json_each(world_content.DestinyInventoryItemDefinition.json -> 'investmentStats')
where exists (select 1
              from json_each(world_content.DestinyInventoryItemDefinition.json ->> 'itemCategoryHashes')
              where json_each.value = 610365472)
  and world_content.DestinyInventoryItemDefinition.json ->> 'itemTypeDisplayName' != 'Weapon Ornament'
  and world_content.DestinyInventoryItemDefinition.json -> 'displayProperties' ->> 'name' != ''
order by SocketId;



DETACH DATABASE world_content;