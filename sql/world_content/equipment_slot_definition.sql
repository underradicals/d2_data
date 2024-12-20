-- Weapon Equipment Slot Definition
select json ->> 'hash'                               as EquipmentSlotId,
       json -> 'displayProperties' ->> 'name'        as Name,
       json -> 'displayProperties' ->> 'description' as Description
from DestinyEquipmentSlotDefinition
where json ->> 'equipmentCategoryHash' = 1885559401;

-- Armor Equipment Slot Definition
-- select json ->> 'hash'                               as EquipmentSlotId,
--        json -> 'displayProperties' ->> 'name'        as Name,
--        json -> 'displayProperties' ->> 'description' as Description
-- from DestinyEquipmentSlotDefinition
-- where json ->> 'equipmentCategoryHash' = 1053752395;