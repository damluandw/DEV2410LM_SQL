-- Lesson04 - Truy vấn dữ liệu (SELECT - TSQL)
--use master
--go
--CREATE DATABASE DEV2410LM_SQL24_02
--ON
--(NAME = Dev2410LM_SQL_02,
--    FILENAME = 'D:\Devmaster\DEV_Students\DEV2410LM_SQL\Lesson02\Dev2410LM_SQL_02.mdf',
--    SIZE = 10,
--    MAXSIZE = 50,
--    FILEGROWTH = 5)
--LOG ON
--(NAME = Dev2410LM_SQL_02_Log,
--    FILENAME = 'D:\Devmaster\DEV_Students\DEV2410LM_SQL\Lesson02\Dev2410LM_SQL_02.ldf',
--    SIZE = 5 MB,
--    MAXSIZE = 25 MB,
--    FILEGROWTH = 5 MB);
--GO

USE DEV2410LM_SQL24_02
GO
-- Truy vấn dữ liệu từ 1 hay nhiều bảng với các điều kiện, lọc, ...
-- syntax:
/*
-- Syntax for SQL Server and Azure SQL Database  
 
<SELECT statement> ::=    
    [ WITH { [ XMLNAMESPACES ,] [ <common_table_expression> [,...n] ] } ]  
    <query_expression>  
    [ ORDER BY <order_by_expression> ]
    [ <FOR Clause>]  
    [ OPTION ( <query_hint> [ ,...n ] ) ]  
<query_expression> ::=  
    { <query_specification> | ( <query_expression> ) }  
    [  { UNION [ ALL ] | EXCEPT | INTERSECT }  
        <query_specification> | ( <query_expression> ) [...n ] ]  
<query_specification> ::=  
SELECT [ ALL | DISTINCT ]  
    [TOP ( expression ) [PERCENT] [ WITH TIES ] ]  
    < select_list >  
    [ INTO new_table ]  
    [ FROM { <table_source> } [ ,...n ] ]  
    [ WHERE <search_condition> ]  
    [ <GROUP BY> ]  
    [ HAVING < search_condition > ]
*/
-- 1. Truy vấn với select đơn giản (không có from)
SELECT 'Devmaster Academy',N'25 Vũ Trọng Phan'
-- 2. Đặt tên cột cho dữ liệu trong tập kết quả
SELECT 'Devmaster Academy' as [Company]
GO
SELECT 'Devmaster Academy' as 'Company'
GO
SELECT 'Devmaster Academy' [Company Name]
GO
SELECT 'Company'= 'Devmaster Academy'
GO
--3. Truy vấn dữ liệu từ một bảng sử dụng dấu *
-- Liệt kê tất cả các dữ liệu trong bảng khoa
-- (*)
select * from KHOA
-- 4. Lựa chọn các cột trong tập kết quả
-- liệt kê các thông tin masv, hosv, tensv, ngaysinh
select MaSV, HoSV, TenSV,  NgaySinh from SinhVien
-- 5. Sử dụng biểu thức trong select
-- liệt kê các thông tin masv, hoten, ngaysinh, trong đó cột hoten được gộp từ hosv, tensv
select MaSV, HoSV +' ' + TenSV as 'HoTen',  NgaySinh from SinhVien
select MaSV, CONCAT(HoSV,' ',TenSV) as 'HoTen',  NgaySinh from SinhVien
-- Liệt kê các thông tin sinh viên, thêm cột học bổng tăng 10%
SELECT MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH ,HocBong , HocBong + HocBong/10 as 'HocBong10' FROM [dbo].[SinhVien] 
-- 6. Sử dụng mệnh đề where để giới hạn dữ liệu trong tập kết quả (lọc, tìm kiếm)
-- WHERE <Biểu thức điều kiện>
/*
    - Điều kiện sử dụng các phép toán so sánh
        (>; >=; <; <=; =; <>; !=) => thường dùng với cột dữ liệu kiểu số
    - Điều kiện sử dụng phép toán tương đối (áp dụng với dữ liệu kiểu chuỗi)
        + Like / Not Like:
            +++ các ký đại diện:
                ++: dấu %  đại diện cho chuỗi ký tự bất kỳ có thể rỗng
                ++: dấu _ đại diện cho 1 ký tự bất kỳ
                ++: [a-m]: khoảng ký tự từ a đến m

    - Sử dụng toán tử quan hệ (and,or, not ) trong biểu thức điều kiện
    - Điều kiện so sánh tập hợp: IN / NOT IN
*/
/*
    SELECT
    FROM
    WHERE
*/
-- Liệt kê sinh viên có học bổng lớn hơn hoặc bằng 100000
SELECT MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong FROM [dbo].[SinhVien] 
	WHERE HocBong >= 100000
-- Liệt kê sinh viên có học bổng trong khoảng 10.000 đến 100.000
SELECT * FROM [dbo].[SinhVien] WHERE HocBong >= 10000 AND HocBOng <= 100000
SELECT * FROM [dbo].[SinhVien] WHERE HocBong BETWEEN 10000 AND 100000
--- so sánh tương đối (LIKE / NOT LIKE)
-- Liệt kê sinh viên có tên bắt đầu bằng 'T'
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like 'T%'
-- Liệt kê sinh viên có tên chứa ký tự 'u'
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like N'%u%'
-- Liệt kee sinh viên có tên mà ký tự thứ 2 là 'u'
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like '_u%'
-- Liệt kê sinh viên có tên chứa 3 ký tự
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like '___'
--SELECT  * FROM [dbo].[SinhVien] WHERE LEN([TenSV]) = 3
--

-- Liệt kê sinh viên có tên có chứa ký tự đầu tiên trong khoảng a-m
--SELECT  * FROM [dbo].[SinhVien]
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like '[a-m]%'



-- sử dụng tập hợp
-- Liệt kê sinh viên có tháng sinh là tháng 2 và tháng 8
--SELECT  * FROM [dbo].[SinhVien] WHERE MONTH([NgaySinh]) = 2 OR  MONTH([NgaySinh]) = 8
SELECT  * FROM [dbo].[SinhVien] WHERE MONTH([NgaySinh]) IN (2,8)
SELECT  * FROM [dbo].[SinhVien] WHERE MONTH([NgaySinh]) NOT IN (1,3,4,5,6,7,9,10,11,12)
--==================================================
--7. Sắp xếp dữ liệu trong tập kết quả
-- sắp tăng: ORDER BY <Column_Name> | <index> | <alise name>  ASC (Mặc định)
-- Sắp giảm: ORDER BY DESC
-- Liệt kê sinh viên, dữ liệu sắp theo tên sinh viên tăng dần
SELECT  * FROM [dbo].[SinhVien] ORDER BY MASV ASC

SELECT  MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong FROM [dbo].[SinhVien] ORDER BY  5

---
--- LIỆT KÊ SINH VIÊN, DỮ LIỆU SẮP THEO TÊN TĂNG DẦN, NẾU TRÙNG THÌ SẮP THEO HOSV GIẢM DẦN
SELECT  * FROM [dbo].[SinhVien] ORDER BY  [TenSV] ASC, [HoSV] DESC
-- LUYỆN TẬP:
/*
15. Cho biết các sinh viên sinh sau ngày 20/12/1988, gồm các thông tin: Họ tên sinh
viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự
ngày sinh giảm dần.
*/
SELECT CONCAT(HoSV, ' ', TenSV) as [HoTen], NgaySinh,NoiSinh, HocBong FROM [dbo].[SinhVien]
	WHERE NgaySinh >= '19881220' --yyyyMMdd
	ORDER BY NgaySinh DESC

--==================================================
--7. sử dụng từ khóa TOP trong select
-- TOP: trích ra số bản ghi đầu tiên trong tập kết quả
SELECT *
FROM SINHVIEN
GO
SELECT TOP 1 *
FROM SINHVIEN 
GO
SELECT TOP 5 *
FROM SINHVIEN 
GO
-- TOP 50%
SELECT TOP 50 PERCENT *
FROM SINHVIEN
GO
-- LẤY RA SINH VIÊN CÓ HỌC BỔNG CAO NHẤT
SELECT  * FROM SINHVIEN
--DELETE SINHVIEN WHERE MASV ='T06'
SELECT TOP 1 *
FROM SINHVIEN
ORDER BY HOCBONG DESC
GO
-- LẤY RA NHỮNG SINH VIÊN CÓ HỌC BỔNG CAO NHẤT
SELECT TOP 1 WITH TIES *
FROM SINHVIEN
ORDER BY HOCBONG DESC
GO
--==================================================
--8. sử dụng từ khóa DISTINCT trong select
-- distinct: loại bỏ dòng trùng lặp (giữ lại 1)

SELECT distinct *
FROM SINHVIEN
GO -- các bản ghi là duy nhất (PK)

SELECT makh
FROM SINHVIEN
GO -- lặp -> 13 bản ghi

SELECT distinct makh
FROM SINHVIEN
GO
--==================================================
--9. case ... when ... then trong select
--: Liệt kê sinh viên, trong phai hiển thị là: 1 ~ Nữ ; 0 ~ Nam; null ~ Khác
SELECT MaSV, HoSV, TenSV, 
		CASE Phai WHEN 1 THEN N'Nữ'
				  WHEN 0 THEN N'Nam'
				  ELSE N'Khác' END AS Phai
	FROM [dbo].[SinhVien]
--==================================================
--10. sử dụng hàm IIF => IIF( boolean_expression, true_value, false_value )
SELECT MaSV, HoSV, TenSV,IIF(Phai=1,N'Nữ',IIF(Phai=0,N'Nam',N'Khác'))
	FROM [dbo].[SinhVien]
--==================================================
--11. Truy vấn kết hợp 2 hay nhiều bảng (JOIN)
/*
    INNER JOIN
    LEFT JOIN / LEFT OUTER JOIN
    RIGHT JOIN / RIGHT OUTER JOIN
    FULL JOIN / FULL OUTER JOIN
*/
SELECT * FROM [dbo].[SinhVien]
SELECT distinct makh FROM SINHVIEN
SELECT * FROM [dbo].[Khoa]
-- INNER JOIN:
SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	INNER JOIN [dbo].[Khoa] ON [dbo].[SinhVien].MaKH = [dbo].[Khoa].MaKH

SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	INNER JOIN [dbo].[Khoa] ON [dbo].[SinhVien].TenSV = [dbo].[Khoa].TenKH
-- LEFT JOIN 
SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	LEFT JOIN [dbo].[Khoa] ON [dbo].[SinhVien].MaKH = [dbo].[Khoa].MaKH

SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	LEFT JOIN [dbo].[Khoa] ON [dbo].[SinhVien].TenSV = [dbo].[Khoa].TenKH
-- RIGHT JOIN
SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	RIGHT JOIN [dbo].[Khoa] ON [dbo].[SinhVien].MaKH = [dbo].[Khoa].MaKH

SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	RIGHT JOIN [dbo].[Khoa] ON [dbo].[SinhVien].TenSV = [dbo].[Khoa].TenKH
-- FULL NOIN
SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	FULL JOIN [dbo].[Khoa] ON [dbo].[SinhVien].MaKH = [dbo].[Khoa].MaKH

SELECT [dbo].[SinhVien].*,[dbo].[Khoa].TenKH  FROM [dbo].[SinhVien]
	FULL JOIN [dbo].[Khoa] ON [dbo].[SinhVien].TenSV = [dbo].[Khoa].TenKH
-- LIỆT KÊ CÁC THÔNG TIN: MAKH, TENKH, HOTEN, NGAYSINH, PHAI, HOCBONG
SELECT K.MaKH, K.TenKH,CONCAT(SV.HoSV , ' ',SV.TenSV) AS HoTen,SV.NgaySinh, SV.Phai, SV.HocBong  
	FROM KHOA AS K
	LEFT JOIN SinhVien AS SV ON K.MAKH = SV.MaKH

-- Liệt kê điểm của sinh viên các thông tin: MAKH, TENKH, MASV, HOSV, TENSV, PHAI, DIEM
-- KHOA, SINHVIEN, KETQUA
SELECT K.MAKH, TENKH, SV.MASV, HOSV, TENSV, PHAI, DIEM
	FROM KHOA AS K
	INNER JOIN SinhVien AS SV ON K.MAKH = SV.MaKH
	INNER JOIN Ketqua AS KQ ON SV.MaSV = KQ.MaSV