ALTER PROC spud_LayDanhSach_NHACC
	@maNhacc char(3) = NULL
AS
BEGIN
	IF(@maNhacc IS NULL)
		BEGIN
			SELECT * FROM NHACC
		END
	ELSE
		BEGIN
			SELECT * FROM NHACC WHERE MaNCC = @maNhacc
		END
END
GO
EXEC spud_LayDanhSach_NHACC @maNhacc = 'C01'
EXEC spud_LayDanhSach_NHACC
GO
CREATE PROC spud_PXUAT_BcaoPXuat
	@SoPX char(4) = NULL
AS
BEGIN
	
END
GO