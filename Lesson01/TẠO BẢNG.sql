--1. BIẾN - KIỂU GIÁ TRỊ
-- 1.1 TÊN BIẾN: 
--  + Không phân biệt chữ chữ thường
--  + không bắt bằng các ký tự đặc biệt và trong tên biến có thể dùng ký tự _ hoặc số
-- 1.2 Kiểu giá trị
--kiểu số:
-- - số nguyên: BIT,SMALLINT, TINYINT, INT, BIGINT
-- - số thực: NUMBERIC, MONEY, FLOAT, REAL, DOUBLE
--kiểu chữ:
-- -chữ latinh: CHAR, VARCHAR
-- -chữ unicode: NCHAR, NVARCHAR
--kiểu bit: binary, image
--kiểu giời gian: DATE, DATETIME


-- TẠO CƠ SỞ DỮ LIỆU

--CREATE DATABASE DEMO ON
--(NAME = Demo2_dat,
--    FILENAME = 'D:\Devmaster\DEV_Students\DEV_SQL\Lesson01\Demo_dat.mdf',
--    SIZE = 10,
--    MAXSIZE = 50,
--    FILEGROWTH = 5)
--LOG ON
--(NAME = Demo2_log,
--    FILENAME = 'D:\Devmaster\DEV_Students\DEV_SQL\Lesson01\Demo_log.ldf',
--    SIZE = 5 MB,
--    MAXSIZE = 25 MB,
--    FILEGROWTH = 5 MB);
--GO
-- sử dụng Database
-- USE tên_DB
USE DEMO
GO
-- Xoá Database
-- DROP DATABASE tên_DB
--DROP DATABASE DEMO

-- Tạo bảng
-- CREATE TABLE Tên_Table(
--		Tên_biến Kiểu_dữ_liệu một_số_thuộc_tính ,
--	)

CREATE TABLE KHACHHANG(
	Ma_KH INT NOT NULL, -- kiểu int và không được trống
	Ten_KH NVARCHAR(50) -- kiểu chữ unicode
)
GO


-- LẤY GIÁ TRỊ
SELECT * FROM KHACHHANG
GO
-- INSERT GIÁ TRỊ
--INSERT [dbo].[SANPHAM] VALUES
--(1,N'Sản phẩm 01', 6000)
--GO
--INSERT [dbo].[SANPHAM] VALUES
--(2,N'Sản phẩm 02', 6000),
--(3,N'Sản phẩm 03', 6000),
--(4,N'Sản phẩm 04', 6000)
--GO
--INSERT [dbo].[SANPHAM] ([Ma_SP],[Ten_SP]) VALUES
--(5,N'Sản phẩm 02')
--GO

--SELECT * FROM SANPHAM
--GO


-- XOÁ BẢNG
-- DROP TABLE Tên_bảng
--DROP TABLE [dbo].[SANPHAM]
--GO
CREATE TABLE SANPHAM(
	Ma_SP INT IDENTITY(1,5),
	TEN_SP NVARCHAR(50),
	GIA MONEY ,
)

GO

SELECT * FROM SANPHAM
GO

--INSERT [dbo].[SANPHAM] VALUES
--(1,N'Sản phẩm 01', 6000)
--GO
INSERT [dbo].[SANPHAM] ([TEN_SP],[GIA]) VALUES
(N'Sản phẩm 02', 6000),
(N'Sản phẩm 03', 6000),
(N'Sản phẩm 04', 6000)
GO
-- SỬA BẢNG
-- ALTER TABLE TÊN_TABLE
-- CÂU LỆNH SỬA
ALTER TABLE SANPHAM
ADD Active bit DEFAULT(1) 
GO
SELECT * FROM SANPHAM
GO
-- Thêm khoá chính trong bảng SP
ALTER TABLE SANPHAM
ADD CONSTRAINT PK_Ma_SP PRIMARY KEY (Ma_SP)
GO
-- PRIMARY KEY/FOREIGN KEY/ UNIQUE/CHECK
CREATE TABLE GIOHANG(
	MA INT IDENTITY(1,1) PRIMARY KEY,
	MA_SP INT CONSTRAINT FK_MA_SP FOREIGN KEY REFERENCES [dbo].[SANPHAM](MA_SP),
	SL INT CHECK(SL>0)
)
GO
SELECT * FROM GIOHANG
SELECT * FROM SANPHAM
GO
-- Lỗi
--INSERT GIOHANG (MA_SP,SL) VALUES
--(1,-5)
INSERT GIOHANG (MA_SP,SL) VALUES
(1,5)