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