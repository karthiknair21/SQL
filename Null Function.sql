create table NullColSum (
tableName varchar(255),
SrcCnt bigint,
trgcnt bigint 

)



Create procedure nullcheck @table varchar(255)
as 
begin

DECLARE @Sql nvarchar(max)
DECLARE @COUNT INT
DECLARE @Nullcounttrg bigINT
DECLARE @NullcountSrc bigINT
declare @CurCol varchar(255)

set @sql='use Finlive_trg'
exec(@sql)

print @table

select COLUMN_NAME,DATA_TYPE,row_number() over (order by ([Column_NAME]) desc) as Rownum
into #allcol
from INFORMATION_SCHEMA.COLUMNS where upper(TABLE_NAME)=upper(@table)

--select * from #allcol

set @COUNT=1
set  @Nullcounttrg=0
set  @NullcountSrc=0
  delete from NullColSum
while(@COUNT <= (select count(*) from #allcol))
begin
 select @CurCol=COLUMN_NAME from #allcol where Rownum=@COUNT
 drop table NullTrg
 set @Sql='select count(*) as Nullcounttrg into Nulltrg from [Finlive_trg].[finware].'+@table+' where '+@CurCol+' is Null;'
 exec(@sql)
  
 select @Nullcounttrg=Nullcounttrg from Nulltrg

 drop table NullSrc
 set @Sql='select count(*) as NullcountSrc into NullSrc from [Finlive_src].[dbo].'+@table+'_src where '+@CurCol+' is Null;'
 exec(@sql)
  
 select @NullcountSrc=NullcountSrc from NullSrc




   insert into NullColSum
   values(@CurCol,@NullcountSrc,@Nullcounttrg) 
  
  
set @COUNT=@COUNT+1
end 



select * from NullColSum where SrcCnt!=trgcnt

end--proc end


/*After the procedure is made just run the below statement*/

execute nullcheck @table='database.Table_name'