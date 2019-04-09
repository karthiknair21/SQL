USE [FP8_Src]
GO
/****** Object:  StoredProcedure [dbo].[CreateTbl]    Script Date: 3/8/2017 3:52:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[CreateTbl] @tblName nvarchar(255)
as 
begin

Declare @ColumnNumber int
Declare @SQL nvarchar(max)
Declare @Count int
Declare @ColumnName nvarchar(255)
Declare @Datatype nvarchar(255)
Declare @CurrentDB nvarchar(max)


select @ColumnNumber=COUNT(*) from [FP8_trg].[dbo].[TblCrt]
where  table_name=@tblName
print @ColumnNumber
set @SQL='Create Table '+ @tblName + '_Src ( 
'
set @Count=1
while @Count<=@ColumnNumber
Begin
select @ColumnName=name from [FP8_trg].[dbo].[TblCrt]
where  table_name=@tblName and column_id=@Count
select @Datatype=DataType from [FP8_trg].[dbo].[TblCrt]
where  table_name=@tblName and column_id=@Count

if @Count!=@ColumnNumber
Begin
set @SQL=@SQL+' ' +@ColumnName+ ' '+ @Datatype +', 
'
End
else 
begin
set @SQL=@SQL+' ' +@ColumnName+ ' '+ @Datatype +'
)'
end

set @Count=@Count+1
End

print @SQL

set @CurrentDB='Use FP8_Src'
exec(@CurrentDB)

exec(@SQL)



end