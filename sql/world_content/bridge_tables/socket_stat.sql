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