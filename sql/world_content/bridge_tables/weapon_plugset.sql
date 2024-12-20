-- Weapon PlugSetHashes From DestinyInventoryItemDefinition
select distinct DestinyInventoryItemDefinition.json ->> 'hash' as WeaponId,
                coalesce(SocketEntries.value ->> 'reusablePlugSetHash', SocketEntries.value ->> 'randomizedPlugSetHash',
                         '')                                   as PlugSetId
from DestinyInventoryItemDefinition,
     json_each(DestinyInventoryItemDefinition.json -> 'sockets' ->> 'socketEntries') as SocketEntries
where DestinyInventoryItemDefinition.json ->> 'itemType' = 3
  and (PlugSetId != '')
order by WeaponId;