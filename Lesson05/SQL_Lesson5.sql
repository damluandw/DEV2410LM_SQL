-- VIEW
-- Systax:
-- CREATE VIEW <tên_view> AS <câu_lệnh_select>
CREATE VIEW vw_KETQUA
AS
SELECT MaSV, MaMH, Diem FROM Ketqua

-- SỬ DỤNG VIEW
SELECT MaSV, MaMH, Diem FROM vw_KETQUA
-- CẬP NHẬT VIEW
ALTER VIEW vw_KETQUA
AS
SELECT MaSV, TenMH, Diem FROM Ketqua
INNER JOIN [dbo].[MonHoc] ON Ketqua.MaMH = MonHoc.MaMH

GO
SELECT * FROM vw_KETQUA
-- XOÁ VIEW
DROP VIEW vw_KETQUA


sp_helptext vw_KETQUA

-- xem sự phụ thuộc của view 
sp_depends vw_KETQUA

GO
-- STORED PROCEDURE
-- Tạo PROCEDURE
--CREATE PROCEDURE <tên_procedure> <tham_sô_biến> AS  BEGIN <Khối_lệnh> END
-- đưa ra danh sách điểm của sinh viên theo môn học nhập từ bàn phím
CREATE PROCEDURE sp_Diem
	@TenMon nvarchar(50) 
AS
BEGIN
	SELECT HoSV,TenSV, TenMH, Diem FROM Ketqua
	INNER JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
	INNER JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
	WHERE TenMH = @TenMon
END
GO
-- SỬ DỤNG
EXEC sp_Diem @TenMon = N'Cơ sở dữ liệu'
GO
--DECLARE @TenMon nvarchar(50)
--SET @TenMon=N'Cơ sở dữ liệu'
--SELECT HoSV,TenSV, TenMH, Diem FROM Ketqua
--	INNER JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
--	INNER JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
--	WHERE TenMH = @TenMon
-- SỬA 
--ALTER PROCEDURE <tên_procedure> <tham_sô_biến> AS  BEGIN <Khối_lệnh> END
-- đưa ra danh sách điểm của sinh viên theo môn học nhập từ bàn phím và điểm > number??
ALTER PROCEDURE sp_Diem
	@TenMon nvarchar(50),
	@diem float = 5 -- gán giá trị default
AS
BEGIN
	SELECT HoSV,TenSV, TenMH, Diem FROM Ketqua
	INNER JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
	INNER JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
	WHERE TenMH = @TenMon AND Diem > @diem
END
GO
EXEC sp_Diem @TenMon = N'Cơ sở dữ liệu' ,@diem = 0
EXEC sp_Diem @TenMon = N'Cơ sở dữ liệu' 
EXEC sp_Diem N'Cơ sở dữ liệu' ,0
EXEC sp_Diem N'Cơ sở dữ liệu'

-- Chú ý: SP khi gán giá trị default sẽ không cần khai báo tham số khi sử dụng
-- XOÁ SP
DROP PROC sp_Diem
GO
-- Đưa ra tên sinh viên có học bổng lớn nhất của khoa nào đấy
ALTER PROC sp_SinhVien
	@TenKhoa nvarchar(50),
	@TenSV nvarchar(50) OUTPUT
AS
BEGIN
	SET @TenSV = (SELECT TOP 1 TenSV FROM SinhVien WHERE MaKH in (SELECT MaKH FROM Khoa WHERE TenKH = @TenKhoa) ORDER BY HOCBONG DESC) 
	--SELECT @TenSV = TenSV FROM SinhVien WHERE MaKH in (SELECT MaKH FROM Khoa WHERE TenKH = @TenKhoa)
	PRINT @TenSV
END
GO
DECLARE @TenSV nvarchar(50)
EXEC sp_SinhVien @TenKhoa =N'Anh Văn', @TenSV = @TenSV OUTPUT
SELECT @TenSV

select * from [dbo].[SinhVien] WHERE MaKH ='AV'





-- TRIGGER
GO
--- INSERT dữ Liệu
ALTER TRIGGER trg_InsertSinhVien ON SINHVIEN
FOR INSERT
AS
BEGIN
	IF(SELECT HocBong FROM inserted) <0
	BEGIN
		PRINT N'Học bổng phải lớn hơn 0'
		ROLLBACK TRANSACTION
	END
END
GO
INSERT SINHVIEN (MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKH, HocBong, DiemTrungBinh) VALUES
('T6',N'Nguyễn Văn', 'A',0,'20010301','BĐ','AV',-1000,'')

INSERT SINHVIEN VALUES
('TS',N'Nguyễn Văn', 'A',0,'20010301','BĐ','AV',1000,'')

SELECT * FROM SINHVIEN 
-- Update dữ liệu
GO
CREATE TRIGGER trg_UpdateSinhVien ON SINHVIEN
FOR UPDATE
AS
BEGIN
	IF (SELECT HocBong FROM inserted) <0
	BEGIN
		PRINT N'Học bổng phải lớn hơn 0'
		ROLLBACK TRANSACTION
	END
END
GO
UPDATE SINHVIEN SET HocBong =-1000 WHERE MaSV ='TS'
UPDATE SINHVIEN SET HocBong =2000 WHERE MaSV ='TS'
-- DELETE
GO
CREATE TRIGGER trg_DeleteSinhVien ON SINHVIEN
FOR DELETE
AS
BEGIN
	IF (select HocBong FROM deleted) >0 -- lớn hơn 0 thì được xoá và nhỏ hơn 0 thì không đc xoá
	BEGIN
		PRINT N'Học bổng lớn hơn 0 không được xoá'
		ROLLBACK TRANSACTION
	END
END
GO
SELECT * FROM SINHVIEN
DELETE SinhVien WHERE MaSV ='TES'
DELETE SinhVien WHERE MaSV ='TS'

DROP TRIGGER [trg_InsertSinhVien]