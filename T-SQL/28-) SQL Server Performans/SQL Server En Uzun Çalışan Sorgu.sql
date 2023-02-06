-- SQL Server'da en uzun çalýþan sorguyu bulmak için oluþturulmuþ olan scripttir.
SELECT TOP 10 PERCENT 
    o.name AS 'Object Name',
	qs.total_elapsed_time / qs.execution_count / 1000.0 AS 'Average Seconds',
    qs.total_elapsed_time / 1000.0 AS 'Total Seconds',
    total_physical_reads AS'Physical Reads',
    total_logical_reads AS 'Logical Reads',
	qs.execution_count AS 'Count',
    SUBSTRING (qt.text,qs.statement_start_offset/2, 
         (CASE WHEN qs.statement_end_offset = -1 
            THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
          ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) AS 'Query',
	DB_NAME(qt.dbid) AS 'Database',
	last_execution_time AS 'Last Executed',
	@@ServerName AS 'Server Name'
  FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
    LEFT OUTER JOIN sys.objects o ON qt.objectid = o.object_id
where qt.dbid = DB_ID()
  ORDER BY 'Average Seconds' DESC;
