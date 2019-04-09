USE [db_Src]
GO
/****** Object:  StoredProcedure [dbo].[CopyNCheck_FP8]    Script Date: 3/8/2017 3:51:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[CopyNCheck_db] @DestTable as nvarchar(max)
as
begin

Declare @sql nvarchar(max)
declare @SourceTbl nvarchar(max)
set @SourceTbl=parsename(@DestTable,1)+'_src'
set @sql='Use db_Src'
--creating table structure

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME=@SourceTbl)
 BEGIN
 set @sql= 'DROP TABLE '+@SourceTbl+';'
 exec(@sql)
 print 'Dropped '+@SourceTbl
 END

--set @sql='select top 1000 * into ['+parsename(@DestTable,1)+'_Src] from ' + @DestTable + ';'
--print @sql
--exec(@sql)

--set @sql='delete  from [' + parsename(@DestTable,1)+'_Src];'
--exec(@sql)

set @sql='CreateTbl @tblName='''+parsename(@DestTable,1)+''''
print @sql
exec(@sql)


set @sql='Bulk insert ['+parsename(@DestTable,1)+'_Src] FROM ''F:\db\'+parsename(@DestTable,1)+'.txt''' +' WITH(
FIELDTERMINATOR = ''$|$'',
ROWTERMINATOR = ''\n'',
MAXERRORS = 1000
)'
print @sql
exec(@sql)

set @sql='Use db_Src'
exec(@sql)
set @sql='CheckRowCount @SrcTbl=''[db_Src].[dbo].['+parsename(@DestTable,1)+'_Src]'',@DestTbl=''[db_Trg].[dbo].['+parsename(@DestTable,1)+']'''
print @sql
exec(@sql)
end;
