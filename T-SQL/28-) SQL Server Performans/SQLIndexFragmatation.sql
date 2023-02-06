-- Index fragmentation oranlarýný gösteren sorgu.
SELECT
 ps.object_id,
 i.name as IndexName,
 OBJECT_SCHEMA_NAME(ps.object_id) as ObjectSchemaName,
 OBJECT_NAME (ps.object_id) as ObjectName,
 ps.avg_fragmentation_in_percent,
 ps.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, 'LIMITED') ps
INNER JOIN sys.indexes i ON i.object_id=ps.object_id and i.index_id=ps.index_id
WHERE avg_fragmentation_in_percent > 30 AND ps.index_id > 0
ORDER BY avg_fragmentation_in_percent desc
