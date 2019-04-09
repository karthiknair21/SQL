select 
TABLE_name, count(*)
from FP4_trg
group by TABLE_name

select 
TABLE_name, count(*)
from FP4_Src
group by TABLE_name



select TABLE_name,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,NUMERIC_PRECISION
into FP4_Src
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like 'FP4%'


select TABLE_name,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,NUMERIC_PRECISION
into FP4_trg
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like 'FP4%'