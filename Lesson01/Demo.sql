--USE master
--GO
--CREATE DATABASE LAB02
--GO
USE LAB02
GO
DECLARE @Name nvarchar(50)
SET @Name = N'Đàm Văn Luận'
PRINT @Name
select *, CONVERT(varchar(10),[Birthday],103) as 'tên_cột',
 YEAR(GETDATE())-YEAR([Birthday]) as 'Tuổi'
 from [dbo].[Student]