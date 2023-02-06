--SQL Server Index Kullaným Durumu
select DB_NAME(),OBJECT_NAME(us.object_id) as tableName,
	i.name as indexName,
	us.last_user_seek,
	us.user_seeks,
	CASE us.user_seeks WHEN 0 THEN 0
		ELSE us.user_seeks*1.0 /(us.user_scans + us.user_seeks) * 100.0 END AS SeekPercentage,
	us.last_user_scan,
	us.user_scans,
	CASE us.user_scans WHEN 0 THEN 0
		ELSE us.user_scans*1.0 /(us.user_scans + us.user_seeks) * 100.0 END AS ScanPercentage,
	us.last_user_lookup,
	us.user_lookups,
	us.last_user_update,
	us.user_updates
FROM sys.dm_db_index_usage_stats us
INNER JOIN sys.indexes i ON i.object_id=us.object_id and i.index_id = us.index_id 
WHERE us.database_id = DB_ID()
Order by user_scans desc
