-- PlugSetId --> SocketId
select distinct DestinyPlugSetDefinition.json ->> 'hash'   as PlugSetId,
                PlugSetDefinition.value ->> 'plugItemHash' as SocketId
from DestinyPlugSetDefinition,
     json_each(DestinyPlugSetDefinition.json ->> 'reusablePlugItems') as PlugSetDefinition;