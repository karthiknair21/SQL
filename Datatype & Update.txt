/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [Table Name]
      ,[Column Name]
      ,[Column ID]
      ,[Data Type]
      ,[Data Length]
  FROM [Database].[dbo].[DATA_TYPE]

  


select a.*, b.DataType,b.typename 
into tblCrt_FP8
from [Database].[dbo].[DATA_TYPE] a
left join EYDB.dbo.MAPPING b
on a.[Data Type]=b.TypeName

/* First check wherever null is present*/

select * from  dbo.tblCrt_FP8
where datatype is NUll

select Distinct [Data Type] from dbo.tblCrt_FP8
where datatype is NUll 


/* update the data types wherever NUll is present*/

Update dbo.tblCrt_FP8
set DataType='datetime'
where [Data Type] ='datetime'

/* USE THIS FOR CHAR VARCHAR AND NUMERIC*/
Update dbo.tblCrt_FP8
set DataType=[Data Type] +'('+ cast([DATA LENGTH] as varchar)+')'
where [Data Type]= 'VARCHAR'


update dbo.tblCrt_FP8
set [Table Name]='FP8_'+[Table Name]

select * into FP8_Trg.[dbo].[TblCrt] from dbo.[tblCrt_FP8]


update dbo.[tblCrt] 
set Table_Name='FP7'+Table_Name


select * into [tblCrt] from dbo.tblCrt_FP7


