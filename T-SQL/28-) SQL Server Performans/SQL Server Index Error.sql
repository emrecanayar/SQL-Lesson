--Indexlerde meydana gelen olaylarý kontrol etmek için oluþturulmuþ olan scripttir.

SELECT 
DISTINCT ind.object_id,ic.object_id,ind.object_id,
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id
     --ColumnId = ic.index_column_id,
     --ColumnName = col.name

FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
	 AND ind.index_id IN (13,10,34,36,39)
	 AND ind.object_id IN (1086939244,1174451408,743725752)
ORDER BY 
     ind.index_id
