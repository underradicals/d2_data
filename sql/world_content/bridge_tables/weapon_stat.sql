-- Weapon Stat Definitions
select distinct DestinyInventoryItemDefinition.json ->> 'hash' as WeaponId,
                json_each.value ->> 'statTypeHash'             as StatDefinitionHash,
                json_each.value ->> 'value'                    as WeaponStatValue
from DestinyInventoryItemDefinition, json_each(DestinyInventoryItemDefinition.json -> 'investmentStats')
where DestinyInventoryItemDefinition.json ->> 'itemType' = 3
order by WeaponId;