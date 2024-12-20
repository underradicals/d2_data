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