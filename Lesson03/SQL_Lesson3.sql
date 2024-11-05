---- ÔN TẬP TRUY VẤN
-- BÀI 1:
--1. Cho biết danh sách các môn học, gồm các thông tin sau: 
-- Mã môn học, Tên môn  học, Số tiết.
SELECT MaMH, TenMH, Sotiet FROM [dbo].[MonHoc]
GO
--2. Liệt kê danh sách sinh viên, gồm các thông tin sau: 
-- Mã sinh viên, Họ sinh viên,  Tên sinh viên, Học bổng. 
-- Danh sách sẽ được sắp xếp theo thứ tự Mã sinh viên  tăng dần. 
SELECT MaSV, HoSV, TenSV, HocBong FROM [dbo].[SinhVien] ORDER BY MaSV ASC
GO

SELECT MaSV, HoSV, TenSV, HocBong FROM [dbo].[SinhVien] ORDER BY 1 ASC
GO

--3. Danh sách các sinh viên, gồm các thông tin sau:
-- Mã sinh viên, Tên sinh viên,  Phái, Ngày sinh. 
-- Danh sách sẽ được sắp xếp theo thứ tự của tên.  
--4. Thông tin các sinh viên gồm: 
-- Họ tên sinh viên, Ngày sinh, Học bổng. 
-- Thông tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần. 
--5. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: 
-- Mã môn,  Tên môn, Số tiết.
SELECT MaMH, TenMH, Sotiet FROM [dbo].[MonHoc] WHERE [TenMH] like 'T%'

--6. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là i, 
--gồm các  thông tin: Họ tên sinh viên, Ngày sinh, Phái 
--7. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, 
--gồm các  thông tin: Mã khoa, Tên khoa.
--8. Liệt kê những sinh viên mà họ có chứa chữ Thị. 
--9. Cho biết danh sách những sinh viên ký tự đầu tiên của tên nằm trong khoảng  từ a đến m,
--gồm các thông tin: Mã sinh viên,Họ tên sinh viên,Phái, Học bổng.
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like '[a-m]%'
SELECT * FROM [dbo].[SinhVien] WHERE LEFT(TenSV,1) BETWEEN 'a' AND 'm'
--9.2 Cho biết danh sách những sinh viên ký tự thứ 2 của tên nằm trong khoảng  từ a đến m,
--gồm các thông tin: Mã sinh viên,Họ tên sinh viên,Phái, Học bổng.
SELECT  * FROM [dbo].[SinhVien] WHERE [TenSV] like '_[a-m]%'
SELECT * FROM [dbo].[SinhVien] WHERE RIGHT(LEFT(TenSV,2),1) BETWEEN 'a' AND 'm'
SELECT * FROM [dbo].[SinhVien] WHERE SUBSTRING (TenSV,2,1) BETWEEN 'a' AND 'm'

--10. Cho biết danh sách những sinh viên mà tên có chứa ký tự nằm trong khoảng từ  a đến m, 
--gồm các thông tin: Họ tên sinh viên, Ngày sinh, Nơi sinh, Học bổng. 
--Danh sách được sắp xếp tăng dần theo họ tên sinh viên.
--11. Cho biết danh sách các sinh viên của khoa Anh văn,
--gồm các thông tin sau: Mã  sinh viên, Họ tên sinh viên, Ngày sinh, Mã khoa.
SELECT MaSV, CONCAT( HoSV,' ', TenSV) as Hoten,  SV.MaKH FROM [dbo].[SinhVien] SV
	JOIN [dbo].[Khoa] KH ON SV.MaKH = KH.MaKH
	WHERE KH.TenKH = N'Anh văn'

SELECT MaSV, CONCAT( HoSV,' ', TenSV) as Hoten,  MaKH FROM [dbo].[SinhVien] 
	WHERE MaKH IN (SELECT MaKH FROM [dbo].[Khoa] WHERE  TenKH = N'Anh văn')

--12. Liệt kê danh sách sinh viên của khoa Vật Lý, gồm các thông tin sau: Mã sinh viên,  Họ tên sinh viên, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Ngày sinh  giảm dần.  
--13. Cho biết danh sách các sinh viên có học bổng lớn hơn 500,000, gồm các thông  tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ được sắp  xếp theo thứ tự Mã khoa giảm dần.  
--14. Liệt kê danh sách sinh viên sinh vào ngày 20/12/1987, gồm các thông tin: Họ  tên sinh viên, Mã khoa, Học bổng.  
--15. Cho biết các sinh viên sinh sau ngày 20/12/1977, gồm các thông tin: Họ tên sinh  viên, Ngày sinh, Nơi sinh, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự  ngày sinh giảm dần.  
--16. Liệt kê các sinh viên có học bổng lớnhơn 100,000 và sinh ở Tp HCM, gồm các  thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.  
--17. Danh sách các sinh viên của khoa Anh văn và khoa Triết, gồm các thông tin: Mã  sinh viên, Mã khoa, Phái. 
--18. Cho biết những sinh viên có ngày sinh từ ngày 01/01/1986 đến ngày  05/06/1992, gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học bổng.  
--19. Danh sách những sinh viên có học bổng từ 200,000 đến 800,000, gồm các thông  tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.  
--20. Cho biết những môn học có số tiết lớn hơn 40 và nhỏ hơn 60, gồm các thông  tin: Mã môn học, Tên môn học, Số tiết.  
--21. Liệt kê những sinh viên nam của khoa Anh văn, gồm các thông tin: Mã sinh viên,  Họ tên sinh viên, Phái.  
--22. Danh sách sinh viên có nơi sinh ở Hà Nội và ngày sinh sau ngày 01/01/1990,  gồm các thông tin: Họ sinh viên, Tên sinh viên, Nơi sinh, Ngày sinh.  
--23. Liệt kê những sinh viên nữ, tên có chứa chữ N.  
--24. Danh sách các nam sinh viên khoa Tin Học có ngày sinh sau ngày 30/5/1986.  
--25. Liệt kê danh sách sinh viên gồm các thông tin sau: 
--Họ và tên sinh viên, Giới tính,  Ngày sinh. 
--Trong đó Giới tính hiển thị ở dạng Nam/Nữ tuỳ theo giá trị của field  Phai là True hay False.
SELECT CONCAT( HoSV,' ', TenSV),Phai, IIF(Phai=1,N'Nam',N'Nữ') as GioiTinh, NgaySinh 
FROM [dbo].[SinhVien]
  
--26. Cho biết danh sách sinh viên gồm các thông tin sau: 
-- Mã sinh viên, Tuổi, Nơi sinh,  Mã khoa. 
-- Trong đó Tuổi sẽ được tính bằng cách lấy năm hiện hành trừ cho năm  sinh
--SELECT MaSV,NgaySinh, 
--	 IIF( MONTH(NgaySinh) < MONTH(GETDATE()), DATEDIFF(YEAR, NgaySinh,GETDATE()) -- tháng sinh < tháng hiện tại
--		,IIF(MONTH(NgaySinh) = MONTH(GETDATE()), -- tháng sinh = tháng hiện tại -> so sánh ngày sinh và hiện hiện tại
--				 IIF(DAY(NgaySinh) <= DAY(GETDATE()), DATEDIFF(YEAR, NgaySinh,GETDATE()),DATEDIFF(YEAR, NgaySinh,GETDATE())-1),
--			DATEDIFF(YEAR, NgaySinh,GETDATE())-1)) -- tháng sinh > tháng hiện tại
--	, NoiSinh, MaKH 
--	FROM [dbo].[SinhVien]
SELECT MaSV,NgaySinh,  DATEDIFF(YEAR, NgaySinh,GETDATE()) AS Tuoi, NoiSinh, MaKH 
	FROM [dbo].[SinhVien]
SELECT MaSV,NgaySinh,  YEAR(GETDATE())-  YEAR(NgaySinh) AS Tuoi, NoiSinh, MaKH 
	FROM [dbo].[SinhVien]
--27. Cho biết những sinh viên có tuổi lớn hơn 20, thông tin gồm: Họ tên sinh viên,  Tuổi, Học bổng 
SELECT CONCAT( HoSV,' ', TenSV),  DATEDIFF(YEAR, NgaySinh,GETDATE()) AS Tuoi, HocBong
	FROM [dbo].[SinhVien] WHERE  DATEDIFF(YEAR, NgaySinh,GETDATE()) >20

--28. Danh sách những sinh viên có tuổi từ 20 đến 30, thông tin gồm: Họ tên sinh  viên, Tuổi, Tên khoa 
SELECT CONCAT( HoSV,' ', TenSV),  DATEDIFF(YEAR, NgaySinh,GETDATE()) AS Tuoi, KH.TenKH
	FROM [dbo].[SinhVien] SV
	INNER JOIN [dbo].[Khoa] KH ON  SV.MaKH = KH.MaKH
	 WHERE  DATEDIFF(YEAR, NgaySinh,GETDATE()) BETWEEN 20 AND 30

SELECT CONCAT( HoSV,' ', TenSV),  DATEDIFF(YEAR, NgaySinh,GETDATE()) AS Tuoi, KH.TenKH
	FROM [dbo].[SinhVien] SV
	INNER JOIN [dbo].[Khoa] KH ON  SV.MaKH = KH.MaKH
	 WHERE  DATEDIFF(YEAR, NgaySinh,GETDATE()) >= 20 AND DATEDIFF(YEAR, NgaySinh,GETDATE()) <= 30

-- BÀI 2:
--1. Liệt kê danh sách sinh viên gồm các thông tin sau: Họ và tên sinh viên, Giới tính,  Tuổi, Mã khoa. Trong đó Giới tính hiển thị ởdạng Nam/Nữ tuỳ theo giá trị của  field Phai là True hay False, Tuổi sẽ được tính bằng cách lấy năm hiện hành trừ  cho năm sinh. Danh sách sẽ được sắp xếp theo thứ tự Tuổi giảm dần  
--2. Danh sách sinh viên sinh vào tháng 2 năm 1994, gồm các thông tin: Họ tên sinh  viên, Phái, Ngày sinh. Trong đó, Ngày sinh chỉ lấy giá trị ngày của trường  NGAYSINH.  
--3. Sắp xếp dữ liệu giảm dần theo cột Ngày sinh  
--4. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Phái,  Mã khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao”  nếu giá trị của field học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức  trung bình”  
--5. Cho biết điểm thi của các sinh viên, gồm các thông tin: Họ tên sinh viên, Mã  môn học, Điểm. Kết quả sẽ được sắp theo thứ tự Họ tên sinh viên và mã môn  học tăng dần  
--6. Danh sách sinh viên của khoa Anh văn, điều kiện lọc phải sử dụng tên khoa, gồm  các thông tin sau: Họ tên sinh viên, Giới tính, Tên khoa. Trong đó, Giới tính sẽ  hiển thị dạng Nam/Nữ  
--7. Liệt kê bảng điểm của sinh viên khoa Tin Học, gồm các thông tin:Tên khoa, Họ  tên sinh viên, Tên môn học, Số tiết, Điểm  
--8. Kết quả học tập của sinh viên, gồm các thông tin: 
-- Họ tên sinh viên, Mã khoa,  Tên môn học, Điểm thi, Loại. 
-- Trong đó, Loại sẽ là Giỏi nếu điểm thi > 8, từ 6 đến  8 thì Loại là Khá, 
-- nhỏ hơn 6 thì loại là Trung Bình

SELECT CONCAT(SV.HoSV,' ',SV.TenSV) as HoTen, SV.MaKH ,MH.TenMH, KQ.[Diem] 
	,IIF(KQ.[Diem] >8, N'Giỏi',IIF( KQ.[Diem] > 6,N'Khá',N'Trung Bình')) AS Loai
	FROM [dbo].[SinhVien] SV
	INNER JOIN [dbo].[Ketqua] KQ ON SV.MaSV = KQ.MaSV
	INNER JOIN [dbo].[MonHoc] MH ON KQ.MaMH = MH.MaMH

--Bài 3: Tính toán thống kê dữ liệu 
--1. Cho biết trung bình điểm thi theo từng môn, gồm các thông tin: Mã môn, Tên  môn, Trung bình điểm thi
SELECT MH.MaMH, TenMH , AVG([Diem]) FROM [dbo].[MonHoc] MH
INNER JOIN [dbo].[Ketqua] KQ ON MH.[MaMH] = KQ.MaMH
GROUP BY MH.MaMH,TenMH

--2. Danh sách số môn thi của từng sinh viên, gồm các thông tin: Họ tên sinh viên,  Tên khoa, Tổng số môn thi
SELECT CONCAT(SV.HoSV,' ',SV.TenSV) as HoTen, COUNT(MaMH) AS TongMT
 FROM SinhVien SV
 INNER JOIN Khoa KH ON SV.MaKH = KH.MaKH
 INNER  JOIN Ketqua	KQ ON  SV.MaSV = KQ.MaSV
 GROUP BY SV.HoSV,SV.TenSV

SELECT CONCAT(SV.HoSV,' ',SV.TenSV) as HoTen, COUNT(MaMH) AS TongMT
 FROM SinhVien SV
 INNER JOIN Khoa KH ON SV.MaKH = KH.MaKH
 INNER  JOIN Ketqua	KQ ON  SV.MaSV = KQ.MaSV
 GROUP BY CONCAT(SV.HoSV,' ',SV.TenSV)

--3. Tổng điểm thi của từng sinh viên, các thông tin: Tên sinh viên, Tên khoa, Phái,  Tổng điểm thi  
--4. Cho biết tổng số sinh viên ở mỗi khoa, gồmcác thông tin: Tên khoa, Tổng số sinh  viên  
--5. Cho biết điểm cao nhất của mỗi sinh viên, gồm thông tin:Họ tên sinh viên, Điểm  
--6. Thông tin của môn học có số tiết nhiều nhất: Tên môn học, Số tiết  
--7. Cho biết học bổng cao nhất của từng khoa, gồm Mã khoa, Tên khoa, Học bổng  cao nhất  
--8. Cho biết điểm cao nhất của mỗi môn, gồm: Tên môn, Điểm cao nhất  
--9. Thống kê số sinh viên học của từng môn, thông tin có: Mã môn, Tên môn, Số  sinh viên đang học  
--10.Cho biết môn nào có điểm thi cao nhất, gồm các thông tin: Tên môn, Số tiết, Tên  sinh viên, Điểm  
--11.Cho biết khoa nào có đông sinh viên nhất, gồm Mã khoa, Tên khoa, Tổng số sinh  viên 
--12.Cho biết khoa nào có sinh viên lảnh học bổng cao nhất, gồm các thông tin sau:  Tên khoa, Họ tên sinh viên, Học bổng 

--Bài 4: Sử dụng tham số trong truy vấn  
--1. Cho biết danh sách những sinh viên của một khoa, gồm: 
--Mã sinh viên, Họ tên  sinh viên, Giới tính, Tên khoa. 
--Trong đó, giá trị mã khoa cần xem danh sách sinh  viên sẽ được người dùng nhập khi thực thi câu truy vấn 
DECLARE @MaKH nvarchar(2)
SET @MaKH ='AV'
SELECT MaSV,CONCAT( HoSV,' ', TenSV) AS HoTen,  IIF(Phai=1,N'Nam',N'Nữ') as GioiTinh , TenKH
	FROM [dbo].[SinhVien]
	INNER JOIN KHOA ON SinhVien.MaKH = KHOA.MaKH
	WHERE  Khoa.MaKH = @MaKH
 GO
--2. Liệt kê danh sách sinh viên có điểm môn Cơ sở dữ liệu lớn hơn một giá trị bất  kỳ do 
--người sử dụng nhập vào khi thực thi câu truy vấn, thông tin gồm: Mã sinh  viên, Họ tên sinh viên, Tên môn, Điểm
DECLARE @Diem float
SET @Diem = 3.5
SELECT SV.[MaSV], CONCAT([HoSV],' ',[TenSV]) AS HoTen, MH.TenMH, KQ.Diem  FROM [dbo].[SinhVien] SV
INNER JOIN [dbo].[Ketqua] KQ ON SV.MaSV = KQ.MaSV
INNER JOIN [dbo].[MonHoc] MH ON KQ.MaMH = MH.MaMH
WHERE TenMH =N'Cơ sở dữ liệu' AND Diem > @Diem
GO

--3. Cho kết quả thi của các sinh viên theo môn, tên môn cần xem kết quả sẽ được  nhập vào khi thực thi câu truy vấn.
-- Thông tin hiển thị gồm: Mã sinh viên, Tên  khoa, Tên môn, Điểm 

DECLARE @TenMH nvarchar(50)
SET @TenMH = N'Cơ sở dữ liệu'
SELECT SV.[MaSV], KH.TenKH, MH.TenMH, KQ.Diem  FROM [dbo].[SinhVien] SV
INNER JOIN Khoa KH ON SV.MaKH = KH.MaKH
INNER JOIN [dbo].[Ketqua] KQ ON SV.MaSV = KQ.MaSV
INNER JOIN [dbo].[MonHoc] MH ON KQ.MaMH = MH.MaMH
WHERE TenMH = @TenMH
GO

--Bài 5: Truy vấn con  
--1. Danh sách sinh viên chưa thi môn nào, thông tin gồm: Mã sinh viên, Mã khoa,  Phái
SELECT MaSV,  MaKH,  Phai FROM [dbo].[SinhVien] 
	WHERE MaSV NOT IN (SELECT MaSV FROM [dbo].[Ketqua])

--2. Danh sách những sinh viên chưa thi môn Cơ sở dữ liệu, gồm các thông tin: Mã  sinh viên, Họ tên sinh viên, Mã khoa

--Cách 1:
SELECT MaSV,  MaKH,  Phai FROM [dbo].[SinhVien] 
	WHERE MaSV NOT IN (SELECT MaSV FROM [dbo].[Ketqua] WHERE MaMH IN (SELECT MaMH FROM[dbo].[MonHoc] WHERE [TenMH] =N'Cơ sở dữ liệu'))
-- diễn giải
SELECT MaMH FROM[dbo].[MonHoc] WHERE [TenMH] =N'Cơ sở dữ liệu' -- tìm kiếm mã môn CSDL
SELECT MaSV FROM [dbo].[Ketqua] WHERE MaMH IN (SELECT MaMH FROM[dbo].[MonHoc] WHERE [TenMH] =N'Cơ sở dữ liệu') -- tìm kiếm mã sinh viên đã học môn CSDL

-- Cách 2: 
SELECT MaSV,  MaKH,  Phai FROM [dbo].[SinhVien] 
	WHERE MaSV NOT IN (SELECT MaSV FROM [dbo].[Ketqua] KQ
						INNER JOIN [dbo].[MonHoc] MH ON KQ.MaMH = MH.MaMH
						WHERE [TenMH] =N'Cơ sở dữ liệu')
-- diễn giải
SELECT MaSV FROM [dbo].[Ketqua] KQ
						INNER JOIN [dbo].[MonHoc] MH ON KQ.MaMH = MH.MaMH
						WHERE [TenMH] =N'Cơ sở dữ liệu' -- tìm kiếm mã sinh viên đã học môn CSDL 

--3. Cho biết môn nào chưa có sinh viên thi, gồm thông tin về: Mã môn, Tên môn,  Sô tiết  
--4. Khoa nào chưa có sinh viên học  
--5. Cho biết những sinh viên của khoa Anh văn chưa thi môn Cơ sở dữ liệu  6. Cho biết môn nào chưa có sinh viên khoa Lý thi  
--7. Danh sách những sinh viên có điểm thi mônĐồ hoạ nhỏ hơn điểm thi môn Đồ  hoạ nhỏ nhất của sinh viên khoa Tin học  
--8. Liệt kê những sinh viên sinh sau sinh viên có tuổi nhỏ nhất trong khoa Anh văn  
--9. Cho biết những sinh viên có học bổng lớn hơn tổng học bổng của những sinh  viên thuộc khoa Triết 
--10.Danh sách sinh viên có nơi sinh cùng với nơi sinh của sinh viên có học bổng lớn  nhất trong khoa Lý  
--11.Danh sách sinh viên có điểm cao nhất ứng với mỗi môn, gồm thông tin: Mã sinh  viên, Họ tên sinh viên, Tên môn, Điểm  
--12.Các sinh viên có học bổng cao nhất theo từng khoa, gồm Mã sinh viên, Tên khoa,  Học bổng 
