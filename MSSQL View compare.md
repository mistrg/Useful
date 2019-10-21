Following procedure compares datatypes between two mssql databases

1) List columns and respecteed data types for all views in source database. 


select schema_name(v.schema_id) as schema_name,
       object_name(c.object_id) as view_name,
       c.name as column_name,
       type_name(user_type_id) as data_type,
       c.max_length
from sys.columns c
join sys.views v  ON v.object_id = c.object_id
order by schema_name,
         view_name,
         column_id;

2) Script previous result as INSERT and run the script on the target database. Name the table adev
3) Repeat step 1 and 2 for target database. Name the table aprod
4) Compare the views with following script 

SELECT *
FROM adev a
LEFT OUTER JOIN aprod b ON a.schema_name =b.SCHEMA_name AND a.view_name = b.view_name AND a.COLUMN_name = b.COLUMN_name 
WHERE b.data_type <> a.data_type
ORDER BY a.SCHEMA_NAME, a.view_name,a.column_name

