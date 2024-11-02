--1. Tạo csdl bằng lệnh T-SQL
--syntax: CREATE DATABASE
--tạo csdl đơn giản
CREATE DATABASE Dev2410LM_SQL_01 ON
(NAME = Dev2410LM_SQL_01,
    FILENAME = 'D:\Devmaster\DEV_Students\DEV2410LM_SQL\Lesson01\Dev2410LM_SQL_01.mdf',
    SIZE = 10,
    MAXSIZE = 50,
    FILEGROWTH = 5)
LOG ON
(NAME = Dev2410LM_SQL_01_Log,
    FILENAME = 'D:\Devmaster\DEV_Students\DEV2410LM_SQL\Lesson01\Dev2410LM_SQL_01.ldf',
    SIZE = 5 MB,
    MAXSIZE = 25 MB,
    FILEGROWTH = 5 MB);
GO
USE Dev2410LM_SQL_01
GO
--2.Tạo bảng và các ràng buộc dữ liệu trên bảng
--Các kiểu dữ liệu thường dùng
/*
	--Kiểu số: (số nguyên/số thực)
		++ Số nguyên: tinyint, smallint, int, bigint
		++ số thực: float, double, decimal, numberic
	-- Kiểu chuỗi (none unicode, unicode)
		++ none unicode: char, varchar, text
		++ unicode: nchar, nvarchar, ntext

		++ fixed length: char()/nchar()
		++ dynamic lenght: varchar()/ nvarchar()
	-- Kiểu ngày giờ: smalldatetime, datetime, date, time..
	-- Kiểu logic: bit
	-- Kiểu nhị phân: binary/varbinary
	-- tham khảo thêm: keyword (datatype in SQL server: https://learn.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16)
*/
/*
	Các ràng buộc dữ liệu trên đối tượng table (column)
	-- null/ not null
	-- ràng buộc duy nhất: primary key/ unique (toàn vẹn thực thể)/ thuộc tính identity / kiểu dữ liệu niqueidentifier
	-- ràng buộc tham chiếu(khoá ngoại): foreign key
	-- ràng buộc miên giá trị (domain): datatype/check constraint
	-- thuộc tính default: 
	* ràng buộc phức tạp: => trigger
*/
-- tạo cấu trúc bảng dữ liệu
-- syntaxt: CREATE TABLE
--2.1 tạo bảng đơn giản

CREATE TABLE TABLE1
(
	COL1 INT,
	COL2 VARCHAR(100)
)
--2.2 tạo bảng với ràng buộc khoá chính(primary key)
-- VATTU(MAVTU, TENVTU,DVTINH,PHANTRAM)
CREATE TABLE VATTU(
	MAVTU CHAR(4) PRIMARY KEY,
	TENVTU NVARCHAR(200) NOT NULL,
	DVTINH NVARCHAR(20) NULL,
	PHANTRAM REAL
)
GO
DROP TABLE VATTU
GO
-- Đặt tên constraint
CREATE TABLE VATTU(
	MAVTU CHAR(4) CONSTRAINT PK_VATTU PRIMARY KEY,
	TENVTU NVARCHAR(200) NOT NULL,
	DVTINH NVARCHAR(20) NULL,
	PHANTRAM REAL
)
GO
DROP TABLE VATTU
GO
CREATE TABLE VATTU(
	MAVTU CHAR(4),
	TENVTU NVARCHAR(200) NOT NULL,
	DVTINH NVARCHAR(20) NULL,
	PHANTRAM REAL,
	CONSTRAINT PK_VATTU PRIMARY KEY (MAVTU)
)
GO
--note: tạo bảng dữ liệu với khoá chính trên 2 hay nhiều cột


CREATE TABLE TABLE2
(
	COL1 INT PRIMARY KEY,
	COL2 INT PRIMARY KEY,
	COL3 VARCHAR(100)
) -- error

CREATE TABLE TABLE2
(
	COL1 INT,
	COL2 INT,
	COL3 VARCHAR(100),
	CONSTRAINT PK_TABLE2 PRIMARY KEY (COL1,COL2)
)
--2.3 Tạo bảng với ràng buộc khoá chính và dữ liệu tự động tăng (identify)
--TABLE3(col1, col2,col3)
CREATE TABLE TABLE3
(
	COL1 INT IDENTITY(1,1) CONSTRAINT PK_TABLE3 PRIMARY KEY,
	COL2 NVARCHAR(100),
	COL3 TINYINT
)
GO
--2.4 tạo bảng với ràng buộc duy nhất unique
--NHACC(MANCC,TENCC,CHIACHI,DIENTHOAI)
--PK[MACC]
-- UQ[TENCC]
CREATE TABLE NHACC
(
	MANCC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENCC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENCC UNIQUE,
	DIACHI NVARCHAR(250),
	DIENTHOAI VARCHAR(50) NOT NULL CONSTRAINT UQ_NHACC_DIENTHOAI UNIQUE
)
GO

-- 2.5 Tạo bảng với thuộc tính default
--NHACC(MANHACC,TENCC,CHIACHI,DIENTHOAI)
--PK[MACC]
-- UQ[TENCC],UQ[DIENTHOAI]
-- DF[DIACHI]: '25 Vũ Ngọc Phan'
CREATE TABLE NHACC
(
	MANHACC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENCC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENCC UNIQUE,
	DIACHI NVARCHAR(250) CONSTRAINT DF_NHACC_DIACHI DEFAULT N'25 Vũ Ngọc Phan',
	DIENTHOAI VARCHAR(50) NOT NULL CONSTRAINT UQ_NHACC_DIENTHOAI UNIQUE
)
GO

CREATE TABLE NHACC
(
	MANCC CHAR(3) CONSTRAINT PK_NHACC PRIMARY KEY,
	TENCC NVARCHAR(200) CONSTRAINT UQ_NHACC_TENCC UNIQUE,
	DIACHI NVARCHAR(250),
	DIENTHOAI VARCHAR(50) NOT NULL CONSTRAINT UQ_NHACC_DIENTHOAI UNIQUE,
	CONSTRAINT DF_NHACC_DIACHI DEFAULT N'25 Vũ Ngọc Phan' FOR DIACHI
)--error
GO
--2.6 Ràng buộc miền giá trị CHECK CONSTRAINT
--CTDONDH(SODH,MAVTU,SLDAT)
--PK(SODH,MAVTU)
--CK[SLDAT]>0 -- SLDAT <150
CREATE TABLE CTDONDH(
	SODH CHAR(4),
	MAVTU CHAR(4),
	SLDAT TINYINT CONSTRAINT CK_CTDONDH CHECK(SLDAT>0 AND SLDAT <150 )
	,CONSTRAINT PK_CTDONDH PRIMARY KEY (SODH,MAVTU)
)


--2.7 Tạo bảng với ràng buộc khoá ngoại
--CTDONDH(SODH,MAVTU,SLDAT)
--PK(SODH,MAVTU)
--CK[SLDAT]>0 -- SLDAT <150
-- FK[SODH] REFERENCES CDONDH
-- FK[MAVTU] REFERENCES VTU
CREATE TABLE CTDONDH(
	SODH CHAR(4) CONSTRAINT FK_CTDONDH_CDONDH_SODH FOREIGN KEY (SODH) REFERENCES DONDH --REFERENCES DONDH(SODH),
	,MAVTU CHAR(4) --CONSTRAINT FK_CTDONDH_VATTU_SODH FOREIGN KEY (MAVTU) REFERENCES VATTU --REFERENCES DONDH(MAVTU),
	,SLDAT TINYINT CONSTRAINT CK_CTDONDH CHECK(SLDAT>0 AND SLDAT <150 )
	,CONSTRAINT PK_CTDONDH PRIMARY KEY (SODH,MAVTU)
	,CONSTRAINT FK_CTDONDH_VATTU_SODH FOREIGN KEY (MAVTU) 
		REFERENCES VATTU(MAVTU) -- VATTU(MAVTU)
		ON UPDATE CASCADE -- NO ACTION/ SET NULL/ SET DEFAULT
		ON DELETE NO ACTION -- CASCADE/ SET NULL / SET DEFAULT
)

DROP TABLE CTDONDH
--DONDH(SODH,NGAYDH,MANHACC)
--PK(SODH)
--DF[NGAYDH] = GETDATE()
CREATE TABLE DONDH(
	SODH CHAR(4) CONSTRAINT PK_CTDONDH PRIMARY KEY ,
	NGAYDH DATE CONSTRAINT DF_NGAYDH DEFAULT GETDATE(),
	MANHACC CHAR(3)
	,CONSTRAINT FK_NHACC FOREIGN KEY (MANHACC) REFERENCES NHACC(MANHACC)
)
GO


--2.8 SỬA ĐỔI BẢNG DONDH
-- BỔ SUNG KHOÁ NGOẠI (MANHACC) THAM CHIẾU ĐẾN BẢNG NHÀ CC
--FK(MANHACC)- NHACC
-- SỬA ĐỔI THÊM RÀNG BUỘC
ALTER TABLE DONDH
ADD CONSTRAINT FK_DONDH_NHACC FOREIGN KEY (MANHACC) REFERENCES NHACC(MANHACC) 
		ON UPDATE CASCADE -- NO ACTION/ SET NULL/ SET DEFAULT
		ON DELETE NO ACTION -- CASCADE/ SET NULL / SET DEFAULT
GO
-- thêm cột
ALTER TABLE DONDH
	ADD TONGTRIGIA NUMERIC(18,2) 
GO
-- xoá cột
ALTER TABLE DONDH
	DROP COLUMN TONGTRIGIA
GO
-- sửa tên côt
EXEC sp_rename 'DBO.DONDH.TONGTRIGIA', 'TONGGIATRI','COLUMN'
--3. Làm việc với các câu lệnh DML (select/insert/update/delete)
--3.1 : select -> lọc/ duyệt các bản ghi từ nguồn dữ liệu
--3.2 INSERT
-- thêm 1 hay nhiều bản ghi vào bảng
-- Syntax đơn giản
-- thêm 1 bản ghi
INSERT INTO VATTU (MAVTU,TENVTU,DVTINH,PHANTRAM)
VALUES('VT01',N'Tủ lạnh LG 204',N'chiếc',40)
GO
INSERT INTO VATTU 
VALUES('VT02',N'Tủ lạnh LG 204',N'chiếc',40)
GO

--ghi chú: 
-- ++ cột identity -> mặc định không thực hiện thêm giá trị cho cột này
-- ++ cột có giá trị mặc định hoặc null : có thể không cần thêm giá trị
-- ++ khi thêm giá trị trên cột khoá ngoại thì giá trị đó phải tồn tại trên cột tham chiếu trên bảng 1 tương ứng
-- thêm nhiều bản ghi 
INSERT INTO VATTU VALUES
('VT03',N'Tủ lạnh Toshiba 204',N'chiếc',10),
('VT04',N'Tủ lạnh Toshiba 205',N'chiếc',40)
GO

INSERT INTO VATTU 
SELECT 'VT03',N'Tủ lạnh Toshiba 204',N'chiếc',10



-------
-- chú ý
/*
	- dữ liệu chuỗi non unicode : đặt trong cặp nháy đơn ''
	- dữ liệu chuỗi unicode : đặt trong cặp nháy đơn N''
	- dữ liệu kiểu ngày: (mặc định) -> đặt trong cặp dấu nháy đơn '', theo định dạng mm/dd/yyyy | yyyy/mm/dd | yyyymmdd
	=> set datefomat dmy?
*/

--3.3 update -> sửa đổi dữ liệu trên cột trong bảng
-- xoá cũ, thêm mới/
--Syntax
/*
	UPDATE <table_name> [source]
	SET <column_name> = <giá trị> / [<column_source>] , [,...]
	[where <condition>]
*/

SELECT * FROM VATTU

UPDATE VATTU SET PHANTRAM = 50 WHERE MAVTU = 'VT04'
-- cập nhật cột phantram trong bản vật tư tăng lên 10

--3.4 DELETE
/*
	DELETE <table_name> [where <condition>]
*/
DELETE VATTU WHERE MAVTU = 'VT04'
--GHI CHÚ
-- khi xoá dữ liệu trên bảng mà có liên kết đến bảng bên nhiều 
-- thì chú ý đến điều kiện tham chiếu (ON DELETE NO ACTION)
--3.5 Xoá sạch (làm sạch vùng nhớ)
--syntax: TRUNCATE TABLE <table_name> 
TRUNCATE TABLE VATTU
GO
-- lỗi nếu có foreign key
