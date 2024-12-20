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