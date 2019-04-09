/* Use target database*/
select  TABLE_name,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,NUMERIC_PRECISION
into datatype1_trg_FP3_FIX
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like 'FP3_FIX%'
/*Use source datebase*/
select  TABLE_name,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,NUMERIC_PRECISION
into datatype1_Src_FP3_FIX
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME like 'FP3_FIX%'

/*inner join inorder to compare the source and target*/

select * from FP3_FIX_Trg.dbo.datatype1_trg_FP3_FIX a
 inner join FP3_FIX_Src.dbo.datatype1_Src_FP3_FIX b
 on upper(a.TABLE_name+'_src')=upper(b.TABLE_name)
 and a.COLUMN_NAME=b.COLUMN_NAME
 where --a.NUMERIC_PRECISION!=b.NUMERIC_PRECISION AND
  a.DATA_TYPE!=b.DATA_TYPE

/*For data length related to char and varchar*/
 select  * from FP3_FIX_Trg.dbo.datatype_trg_FP3_FIX a
 inner join FP3_FIX_Src.dbo.datatype1_Src_FP3_FIX b
 on upper(a.TABLE_name+'_src')=upper(b.TABLE_name)
 and a.COLUMN_NAME=b.COLUMN_NAMe
 where (a.CHARACTER_MAXIMUM_LENGTH!=b.CHARACTER_MAXIMUM_LENGTH)
