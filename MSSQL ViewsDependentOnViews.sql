--Following command lists all views in current database that are present in the database. Additionaly it lists other view references.

SELECT 
 OBJECT_SCHEMA_NAME(v.object_id) schema_name,
 v.name, 
 ref.*
FROM 
 sys.views as v
 outer apply (
	SELECT so.name
	FROM sys.sql_expression_dependencies  
	inner join sys.objects so on so.object_id  =  referenced_id and type = 'v'
	WHERE referencing_id = OBJECT_ID(OBJECT_SCHEMA_NAME(v.object_id)+'.'+v.name)
 ) ref
 order by OBJECT_SCHEMA_NAME(v.object_id),v.name
