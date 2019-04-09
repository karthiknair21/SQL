select 
TABLE_name, count(*)
from db_trg
group by TABLE_name

select 
TABLE_name, count(*)
from db_Src
group by TABLE_name



select TABLE_name,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,NUMERIC_PRECISION
into db_Src
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like 'db%'


select TABLE_name,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,NUMERIC_PRECISION
into db_trg
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like 'db%'
