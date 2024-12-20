-- Damage Type Definitions
select json -> 'hash'                                as Id,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description,
       json -> 'displayProperties' ->> 'icon'        as Icon,
       json -> 'color' ->> 'red'                     as Red,
       json -> 'color' ->> 'green'                   as Green,
       json -> 'color' ->> 'blue'                    as Blue,
       json -> 'color' ->> 'alpha'                   as Alpha
from DestinyDamageTypeDefinition
where Icon IS NOT NULL;

-- State Definitions
select json -> 'hash'                                as Id,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description,
       json -> 'displayProperties' ->> 'icon'        as Icon
from DestinyStatDefinition
where Name != '';

-- Lore Definitions
select json -> 'hash'                                       as Id,
       json -> 'displayProperties' ->> 'name'               as Name,
       json -> 'displayProperties' ->> 'description'        as Description,
       COALESCE(json -> 'displayProperties' ->> 'icon', '') as Icon,
       json -> 'subtitle'                                   as Subtitle
from DestinyLoreDefinition
where Name != ''
  and Description != ''
  and Icon != '';


-- Weapon Equipment Slot Definition
select json ->> 'hash'                               as EquipmentSlotId,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description
from DestinyEquipmentSlotDefinition
where json ->> 'equipmentCategoryHash' = 1885559401;

-- Armor Equipment Slot Definition
select json ->> 'hash'                               as EquipmentSlotId,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description
from DestinyEquipmentSlotDefinition
where json ->> 'equipmentCategoryHash' = 1053752395;


-- Weapon Definitions
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
from DestinyInventoryItemDefinition
where json ->> 'itemType' = 3;


-- All Socket Definitions from DestinyInventoryItemDefinitions
select json -> 'hash'                                as Id,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description,
       json -> 'displayProperties' ->> 'icon'        as Icon,
       json ->> 'itemTypeDisplayName'                as DisplayName
from DestinyInventoryItemDefinition
where exists (select 1
              from json_each(DestinyInventoryItemDefinition.json ->> 'itemCategoryHashes')
              where json_each.value = 610365472)
  and DisplayName != 'Weapon Ornament'
  and Name != '';


-- Weapon Stat Definitions
select distinct DestinyInventoryItemDefinition.json ->> 'hash' as WeaponId,
                json_each.value ->> 'statTypeHash'             as StatDefinitionHash,
                json_each.value ->> 'value'                    as WeaponStatValue
from DestinyInventoryItemDefinition, json_each(DestinyInventoryItemDefinition.json -> 'investmentStats')
where DestinyInventoryItemDefinition.json ->> 'itemType' = 3
order by WeaponId;


-- Socket Stat Definitions
select distinct DestinyInventoryItemDefinition.json ->> 'hash' as SocketId,
                json_each.value ->> 'statTypeHash'             as StatDefinitionHash,
                json_each.value ->> 'value'                    as WeaponStatValue
from DestinyInventoryItemDefinition, json_each(DestinyInventoryItemDefinition.json -> 'investmentStats')
where exists (select 1
              from json_each(DestinyInventoryItemDefinition.json ->> 'itemCategoryHashes')
              where json_each.value = 610365472)
  and DestinyInventoryItemDefinition.json ->> 'itemTypeDisplayName' != 'Weapon Ornament'
  and DestinyInventoryItemDefinition.json -> 'displayProperties' ->> 'name' != ''
order by SocketId;

-- Weapon PlugSetHashes From DestinyInventoryItemDefinition
select distinct DestinyInventoryItemDefinition.json ->> 'hash' as WeaponId,
                coalesce(SocketEntries.value ->> 'reusablePlugSetHash', SocketEntries.value ->> 'randomizedPlugSetHash',
                         '')                                   as PlugSetId
from DestinyInventoryItemDefinition,
     json_each(DestinyInventoryItemDefinition.json -> 'sockets' ->> 'socketEntries') as SocketEntries
where DestinyInventoryItemDefinition.json ->> 'itemType' = 3
  and (PlugSetId != '')
order by WeaponId;


-- PlugSetId --> SocketId
select distinct DestinyPlugSetDefinition.json ->> 'hash'   as PlugSetId,
                PlugSetDefinition.value ->> 'plugItemHash' as SocketId
from DestinyPlugSetDefinition,
     json_each(DestinyPlugSetDefinition.json ->> 'reusablePlugItems') as PlugSetDefinition;