USE [FP8_Src]
GO
/****** Object:  StoredProcedure [dbo].[CheckRowCount]    Script Date: 3/8/2017 3:27:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CheckRowCount] @SrcTbl nvarchar(100), @DestTbl nvarchar(100)
AS
BEGIN
 DECLARE @SrcCnt bigint
 DECLARE @destCnt bigint
 DECLARE @Result nvarchar(10)
 DECLARE @ActualSrc nvarchar(10)
 DECLARE @ActualDest nvarchar(10)
 DECLARE @Sql nvarchar(max)
 SET @Result='NOT MATCHED'
 set @sql='use FP8_Src'
 exec(@sql)
 IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Scnt')
 BEGIN
  DROP TABLE Scnt
 END
 set @sql='SELECT COUNT(*) AS a INTO Scnt FROM '+@SrcTbl+ ';'
 EXEC(@sql)

 SELECT @SrcCnt=a FROM Scnt
 set @sql='use FP8_Trg'
 exec(@sql)
 IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Dcnt')
 BEGIN
  DROP TABLE Dcnt
 END

 set @sql='SELECT COUNT(*) AS a INTO Dcnt FROM '+@DestTbl+ ';'
 EXEC(@sql)

 SELECT @destCnt=a FROM Dcnt

 IF @SrcCnt=@destCnt
 BEGIN
  SET @Result='MATCH'
 END

 set @sql='use EYDB'
 exec(@sql)


 INSERT INTO [EYDB].[dbo].[FP8Res]
 SELECT @SrcTbl,@SrcCnt,@DestTbl,@destCnt,@Result,CURRENT_TIMESTAMP

 

END;