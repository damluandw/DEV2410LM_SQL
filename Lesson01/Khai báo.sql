-- Khai báo biến 
-- DECLARE @tên_biến kiểu dữ liệu  = giá_trị_gán(có thể có/không)
DECLARE @ten varchar(30) = 'Devmaster'
-- select sẽ gọi theo cột và dòng
SELECT N'Họ và tên:', @ten
-- print sẽ gọi ra giá trị(Message)
PRINT N'Họ và tên: ' + @ten

-- Gán giá trị
-- SET @tên_biến =  giá_trị_gán
SET @ten = 'Devmaster 02'

SELECT N'Họ và tên:', @ten


DECLARE  @KHACHHANG TABLE(
	Ma_KH INT IDENTITY(1,1), -- kiểu int và không được trống
	Ten_KH NVARCHAR(50) -- kiểu chữ unicode
)
INSERT @KHACHHANG VALUES
(N'Khach hang 1'),
(N'Khach hang 2'),
(N'Khach hang 3' )
SELECT * FROM @KHACHHANG


SELECT * INTO #KHANHHANG FROM SANPHAM
SELECT * FROM #KHANHHANG
DROP TABLE #KHANHHANG
GO
