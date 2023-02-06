-- Eksik indexleri bulur.
SELECT
    DB_NAME(d.database_id) AS DatabaseName,
    OBJECT_NAME(d.object_id,d.database_id) AS [TableName],
    last_user_seek,
    user_seeks,
    user_scans,
    avg_total_user_cost,
    avg_user_impact,
    avg_user_impact*(user_seeks+user_scans) Avg_Estimated_Impact,
    avg_total_user_cost * avg_user_impact * (user_seeks + user_scans)/100 as ImprovementValue,
    d.equality_columns,
    d.inequality_columns,
    d.included_columns,
    ' CREATE NONCLUSTERED INDEX IX_' +
    replace(replace(replace(replace(isnull(equality_columns, '') +
    isnull(inequality_columns, ''), ',', '_'), '[', ''),']', ''), ' ', '') +
    CASE WHEN included_columns IS NOT NULL
    THEN '_INC_' + replace(replace(replace(replace(included_columns, ',', '_'), '[', ''),']', ''), ' ', '')
    ELSE '' END + ' ON [' + OBJECT_NAME(d.object_id,d.database_id) + '] (' +
    CASE
    WHEN equality_columns IS NOT NULL AND inequality_columns IS NOT NULL
    THEN equality_columns + ', ' + inequality_columns
    WHEN equality_columns IS NOT NULL AND inequality_columns IS NULL
    THEN equality_columns
    WHEN equality_columns IS NULL AND inequality_columns IS NOT NULL
    THEN inequality_columns
    END + ')' +
    CASE WHEN included_columns IS NOT NULL THEN ' INCLUDE (' +
     replace(replace(replace(included_columns, '[', ''),']', ''), ' ', '') + ')'
     ELSE '' END +
    CASE WHEN @@Version LIKE '%Enterprise%' THEN ' WITH (ONLINE = ON)'
    ELSE '' END AS CreateIndex
FROM
    sys.dm_db_missing_index_groups g
    INNER JOIN sys.dm_db_missing_index_group_stats gs on gs.group_handle = g.index_group_handle
    INNER JOIN sys.dm_db_missing_index_details d on g.index_handle = d.index_handle
--WHERE DB_NAME(database_id) = DB_NAME()
ORDER BY last_user_seek desc

