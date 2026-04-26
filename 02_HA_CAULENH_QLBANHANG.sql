--Chọn Database QLBANHANG_02_Ha để làm việc 
use QLBANHANG_02_Ha
go

--I. Câu 2: Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM
ALTER TABLE SANPHAM_02_Ha ADD GHICHU_02_Ha VARCHAR(20);

--I. Câu 3: Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG
ALTER TABLE KHACHHANG_02_Ha ADD LOAIKH_02_Ha tinyint;

--I. Câu 4: Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100)
ALTER TABLE SANPHAM_02_Ha
ALTER COLUMN GHICHU_02_Ha VARCHAR(100);

--I. Câu 5: Xóa thuộc tính GHICHU trong quan hệ SANPHAM
ALTER TABLE SANPHAM_02_Ha DROP COLUMN GHICHU_02_Ha;

--I. Câu 6: Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang ai”, “Thuong xuyen”, “Vip”, …
ALTER TABLE KHACHHANG_02_Ha
ALTER COLUMN LOAIKH_02_Ha VARCHAR(20);

--I. Câu 7: Đơn vị tính của sản phẩm chỉ có thể là (“cây”,”hộp”,”cái”,”quyển”,”chục”)
UPDATE SANPHAM_02_Ha
SET DVT_02_Ha = 'cai'
WHERE DVT_02_Ha NOT IN ('cay', 'hop', 'cai', 'quyen', 'chuc');

--I. Câu 8: Giá bán của sản phẩm từ 500 đồng trở lên.
UPDATE SANPHAM_02_Ha
SET GIA_02_Ha = 500
WHERE GIA_02_Ha < 500;

--I. Câu 9: Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm
UPDATE CTHD_02_Ha
SET SL_02_Ha = 1
WHERE SL_02_Ha < 1;

--I. Câu 10: Ngày gia nhập của khách hàng thành viên phải lớn hơn ngày sinh của người đó
UPDATE KHACHHANG_02_Ha
SET NGGN_02_Ha = DATEADD(YEAR, 18, NGSINH_02_Ha)
WHERE NGGN_02_Ha <= NGSINH_02_Ha;

--II. Câu 2: Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất.
UPDATE SANPHAM_02_Ha
-- Tăng giá hiện tại lên 5% (nhân 1.05)
SET GIA_02_Ha = GIA_02_Ha * 1.05
-- Chỉ áp dụng cho sản phẩm có nước sản xuất là Thái Lan
WHERE NUOCSX_02_Ha = 'Thai Lan';

--II. Câu 3: Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống.
UPDATE SANPHAM_02_Ha
-- Giảm 5% (nhân 0.95)
SET GIA_02_Ha = GIA_02_Ha * 0.95
-- Điều kiện: sản xuất tại Trung Quốc và giá không quá 10.000
WHERE NUOCSX_02_Ha = 'Trung Quoc' AND GIA_02_Ha <= 10000;

--II. Câu 4: Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 ó doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh ố từ 2.000.000 trở lên.
UPDATE KHACHHANG_02_Ha
-- Gán loại khách hàng là Vip
SET LOAIKH_02_Ha = 'Vip'
-- Khách đăng ký trước 1/1/2007 và doanh số >= 10 triệu
-- Khách đăng ký từ 1/1/2007 trở đi và doanh số >= 2 triệu
WHERE (NGGN_02_Ha < '2007-01-01' AND DOANHSO_02_Ha >= 10000000) OR (NGGN_02_Ha >= '2007-01-01' AND DOANHSO_02_Ha >= 2000000);

--III. Câu 1: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất.
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lọc sản phẩm có nước sản xuất là Trung Quốc
WHERE NUOCSX_02_Ha = 'Trung Quoc';

--III. Câu 2: In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cây”, ”quyển”.
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lọc sản phẩm có đơn vị tính thuộc 1 trong 2 giá trị: cây hoặc quyển
WHERE DVT_02_Ha IN ('cay', 'quyen');

--III. Câu 3: In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- LIKE 'B%01': bắt đầu bằng B, kết thúc bằng 01 (% là chuỗi bất kỳ ở giữa)
WHERE MASP_02_Ha LIKE 'B%01';

--III. Câu 4: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 20.000 đến 30.000.
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lọc theo 2 điều kiện:
-- 1. Nước sản xuất là Trung Quốc
-- 2. Giá nằm trong khoảng từ 20000 đến 30000
WHERE NUOCSX_02_Ha = 'Trung Quoc' AND (GIA_02_Ha >= 20000) AND (GIA_02_Ha <= 30000);

--III. Câu 5: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” hoặc “Thái Lan” sản xuất có giá từ 20.000 đến 30.000.
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lọc:
-- 1. Nước sản xuất thuộc Trung Quốc hoặc Thái Lan
-- 2. Giá nằm trong khoảng 20000 - 30000
WHERE NUOCSX_02_Ha IN ('Trung Quoc' , 'Thai Lan') AND (GIA_02_Ha >= 20000) AND (GIA_02_Ha <= 30000);

--III. Câu 6: In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD_02_Ha, TRIGIA_02_Ha
FROM HOADON_02_Ha
-- Lọc các hóa đơn có ngày thuộc 1 trong 2 ngày cụ thể
WHERE NGHD_02_Ha IN ('2007/1/1' , '2007/1/2');

--III. Câu 7: In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD_02_Ha, TRIGIA_02_Ha
FROM HOADON_02_Ha
-- Lọc tháng = 1 và năm = 2007
WHERE MONTH(NGHD_02_Ha) = 1 AND YEAR(NGHD_02_Ha) = 2007 
-- Sắp xếp: ngày tăng dần, nếu trùng ngày thì trị giá giảm dần
ORDER BY NGHD_02_Ha ASC, TRIGIA_02_Ha DESC;

--III. Câu 8: In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT DISTINCT KH.MAKH_02_Ha, KH.HOTEN_02_Ha
FROM KHACHHANG_02_Ha KH, HOADON_02_Ha HD
-- Nối 2 bảng qua MAKH
-- Lọc theo ngày mua
WHERE KH.MAKH_02_Ha = HD.MAKH_02_Ha AND HD.NGHD_02_Ha = '2007-01-01';

--III. Câu 9: In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyễn Văn A” mua trong tháng 10/2006
SELECT DISTINCT SP.MASP_02_Ha, SP.TENSP_02_Ha
-- Nối 4 bảng: sản phẩm → chi tiết hóa đơn → hóa đơn → khách hàng
FROM SANPHAM_02_Ha SP, CTHD_02_Ha CT, HOADON_02_Ha HD, KHACHHANG_02_Ha KH
WHERE SP.MASP_02_Ha = CT.MASP_02_Ha AND CT.SOHD_02_Ha = HD.SOHD_02_Ha AND HD.MAKH_02_Ha = KH.MAKH_02_Ha AND KH.HOTEN_02_Ha = 'Nguyen Van A' 
-- Lọc theo tên khách hàng
-- Lọc tháng 10 năm 2006
	AND MONTH(HD.NGHD_02_Ha) = 10 AND YEAR(HD.NGHD_02_Ha) = 2006;

--III. Câu 10: In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyễn Văn B” lập trong ngày 10/10/2006.
SELECT HD.SOHD_02_Ha, HD.TRIGIA_02_Ha
FROM HOADON_02_Ha HD, NHANVIEN_02_Ha NV
-- Nối bảng hóa đơn với nhân viên
-- Lọc theo tên nhân viên
-- Lọc theo ngày
WHERE HD.MANV_02_Ha = NV.MANV_02_Ha AND NV.HOTEN_02_Ha = 'Nguyen Van B' AND HD.NGHD_02_Ha = '2006-10-10';

--III. Câu 11: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”
SELECT DISTINCT SOHD_02_Ha
FROM CTHD_02_Ha
-- Lọc các dòng có MASP là BB01 hoặc BB02
WHERE MASP_02_Ha IN ('BB01', 'BB02');

--III. Câu 12: Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20
SELECT DISTINCT SOHD_02_Ha
FROM CTHD_02_Ha
-- 1. MASP là BB01 hoặc BB02
-- 2. Số lượng từ 10 đến 20
WHERE MASP_02_Ha IN ('BB01', 'BB02') AND (SL_02_Ha >= 10) AND (SL_02_Ha <= 20);

--III. Câu 13: Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20
SELECT SOHD_02_Ha
FROM CTHD_02_Ha
-- Lọc chỉ lấy 2 sản phẩm cần xét là BB01 và BB02
-- Điều kiện số lượng mỗi sản phẩm từ 10 đến 20
WHERE MASP_02_Ha IN ('BB01', 'BB02') AND SL_02_Ha BETWEEN 10 AND 20
-- Gom nhóm theo từng hóa đơn
GROUP BY SOHD_02_Ha
-- Chỉ giữ những hóa đơn có đủ 2 sản phẩm khác nhau (BB01 và BB02)
HAVING COUNT(DISTINCT MASP_02_Ha) = 2;

--III. Câu 14: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007
SELECT DISTINCT SP.MASP_02_Ha, SP.TENSP_02_Ha
FROM SANPHAM_02_Ha SP
-- LEFT JOIN để giữ lại tất cả sản phẩm, kể cả chưa bán
LEFT JOIN CTHD_02_Ha CT ON SP.MASP_02_Ha = CT.MASP_02_Ha
-- Nối tiếp với bảng hóa đơn để lấy ngày bán
LEFT JOIN HOADON_02_Ha HD ON CT.SOHD_02_Ha = HD.SOHD_02_Ha
    -- Điều kiện 1: sản phẩm do Trung Quốc sản xuất (không cần đã bán)
    -- Điều kiện 2: sản phẩm có trong hóa đơn ngày 1/1/2007
WHERE SP.NUOCSX_02_Ha = 'Trung Quoc' OR HD.NGHD_02_Ha = '2007-01-01';

--III. Câu 15: In ra danh sách các sản phẩm (MASP,TENSP) không bán được
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lọc các sản phẩm không xuất hiện trong bảng chi tiết hóa đơn
WHERE MASP_02_Ha NOT IN (
    SELECT MASP_02_Ha
	FROM CTHD_02_Ha
);

--III. Câu 16: In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lấy những sản phẩm KHÔNG nằm trong danh sách đã bán năm 2006
WHERE MASP_02_Ha NOT IN (
    SELECT CT.MASP_02_Ha
    FROM CTHD_02_Ha CT, HOADON_02_Ha HD
    -- Nối chi tiết hóa đơn với hóa đơn
    -- Chỉ xét các hóa đơn trong năm 2006
    WHERE CT.SOHD_02_Ha = HD.SOHD_02_Ha AND YEAR(HD.NGHD_02_Ha) = 2006
);

--III. Câu 17: In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất không bán được trong năm 2006
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
-- Lọc sản phẩm Trung Quốc
-- Và không xuất hiện trong hóa đơn năm 2006
WHERE NUOCSX_02_Ha = 'Trung Quoc' AND MASP_02_Ha NOT IN (
    SELECT CT.MASP_02_Ha
    FROM CTHD_02_Ha CT, HOADON_02_Ha HD
	 -- Nối chi tiết hóa đơn với hóa đơn
	 -- Chỉ xét các hóa đơn trong năm 2006
    WHERE CT.SOHD_02_Ha = HD.SOHD_02_Ha AND YEAR(HD.NGHD_02_Ha) = 2006
);

--III. Câu 18: Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua
SELECT COUNT(*)
FROM HOADON_02_Ha
-- MAKH NULL nghĩa là không đăng ký thành viên
WHERE MAKH_02_Ha IS NULL;

--III. Câu 19: Cho biết trị giá hóa đơn cao nhất, thấp nhất
--Sử dụng hàm MAX để lấy trị giá hóa đơn cao nhất
--Sử dụng hàm MIN để lấy trị giá hóa đơn thấp nhất
SELECT MAX(TRIGIA_02_Ha) AS Max_G, MIN(TRIGIA_02_Ha) AS Min_G
FROM HOADON_02_Ha;

--III. Câu 20: Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006
--Sử dụng hàm AVG để tính giá trị trung bình của trị giá hóa đơn
SELECT AVG(TRIGIA_02_Ha) AS ['Trung Bình']
FROM HOADON_02_Ha
--Lọc các hóa đơn trong năm 2006
WHERE YEAR(NGHD_02_Ha) = 2006;

--III. Câu 21: Doanh thu bán hàng trong năm 2006
--Sử dụng hàm SUM để tính tổng trị giá các hóa đơn (doanh thu)
SELECT SUM(TRIGIA_02_Ha) AS DoanhThu
FROM HOADON_02_Ha
--Lọc các hóa đơn trong năm 2006
WHERE YEAR(NGHD_02_Ha) = 2006;

--III. Câu 22: Số hóa đơn có trị giá cao nhất trong năm 2006
SELECT SOHD_02_Ha
FROM HOADON_02_Ha
--Chỉ xét các hóa đơn được lập trong năm 2006
--Và có trị giá bằng trị giá lớn nhất trong năm 2006
WHERE YEAR(NGHD_02_Ha) = 2006 AND TRIGIA_02_Ha = (
	--Sử dụng hàm MAX tìm trị giá hóa đơn cao nhất trong năm 2006
    SELECT MAX(TRIGIA_02_Ha)
    FROM HOADON_02_Ha
	--Lọc các hóa đơn trong năm 2006
    WHERE YEAR(NGHD_02_Ha) = 2006
);

--III. Câu 23: Họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006
SELECT KH.HOTEN_02_Ha
FROM KHACHHANG_02_Ha KH, HOADON_02_Ha HD
--Nối khách hàng với hóa đơn qua mã khách hàng
--Lọc hóa đơn có trị giá lớn nhất trong năm 2006
WHERE KH.MAKH_02_Ha = HD.MAKH_02_Ha AND YEAR(HD.NGHD_02_Ha) = 2006 AND HD.TRIGIA_02_Ha = (
	--Sử dụng hàm MAX tìm trị giá hóa đơn cao nhất trong năm 2006
    SELECT MAX(TRIGIA_02_Ha)
    FROM HOADON_02_Ha
	--Lọc các hóa đơn trong năm 2006
    WHERE YEAR(NGHD_02_Ha) = 2006
);

--III. Câu 24: In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất
SELECT TOP 3 MAKH_02_Ha, HOTEN_02_Ha
FROM KHACHHANG_02_Ha
--Sắp xếp giảm dần theo doanh số
ORDER BY DOANHSO_02_Ha DESC;

--III. Câu 25: In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
WHERE GIA_02_Ha IN (
	--lấy 3 mức giá cao nhất
    SELECT DISTINCT TOP 3 GIA_02_Ha
    FROM SANPHAM_02_Ha
	--Sắp xếp giá giảm dần để lấy giá cao nhất
    ORDER BY GIA_02_Ha DESC
);

--III. Câu 26: In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức giá thấp nhất (của tất cả các sản phẩm)
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
--Sản phẩm do Trung Quốc sản xuất
WHERE NUOCSX_02_Ha = 'Trung Quoc' AND GIA_02_Ha IN (
	--lấy 3 mức giá thấp nhất
    SELECT DISTINCT TOP 3 GIA_02_Ha
    FROM SANPHAM_02_Ha
	--Sắp xếp tăng dần để lấy giá thấp nhất
    ORDER BY GIA_02_Ha ASC
);

--III. Câu 27: In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quốc” sản xuất có giá bằng 1 trong 3 mức giá thấp nhất (của sản phẩm do “Trung Quốc” sản xuất)
SELECT MASP_02_Ha, TENSP_02_Ha
FROM SANPHAM_02_Ha
--Chỉ lấy sản phẩm sản xuất ở Trung Quốc
--Giá phải thuộc 3 mức thấp nhất của tất cả sản phẩm ở Trung Quốc
WHERE NUOCSX_02_Ha = 'Trung Quoc' AND GIA_02_Ha IN (
	--lấy 3 mức giá thấp nhất
    SELECT DISTINCT TOP 3 GIA_02_Ha
    FROM SANPHAM_02_Ha
	--Lọc chỉ sản phẩm Trung Quốc
    WHERE NUOCSX_02_Ha = 'Trung Quoc'
	--Sắp xếp tăng dần để lấy giá thấp nhất
    ORDER BY GIA_02_Ha ASC
);

--III. Câu 28: In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất (sắp xếp theo kiểu xếp hạng)
SELECT MAKH_02_Ha, HOTEN_02_Ha
FROM (
    --Tính thứ hạng cho từng khách hàng
    --RANK(): xếp hạng theo doanh số giảm dần (cao nhất là hạng 1)
    SELECT MAKH_02_Ha, HOTEN_02_Ha, DOANHSO_02_Ha, RANK() OVER (ORDER BY DOANHSO_02_Ha DESC) AS XepHang
    FROM KHACHHANG_02_Ha
) AS X
--Lọc ra những khách hàng có hạng từ 1 đến 3
WHERE XepHang <= 3;

--III. Câu 29: Tính tổng số sản phẩm do “Trung Quốc” sản xuất
--Đếm tổng số sản phẩm
SELECT COUNT(*) AS TongSP
FROM SANPHAM_02_Ha
--Lấy các sản phẩm do Trung Quốc sản xuất 
WHERE NUOCSX_02_Ha = 'Trung Quoc';

--III. Câu 30: Tính tổng số sản phẩm của từng nước sản xuất
--Lấy tên nước sản xuất và đếm số tổng sản phẩm của mỗi nước
SELECT NUOCSX_02_Ha, COUNT(*) AS TongSP
FROM SANPHAM_02_Ha
--Nhóm các dòng theo từng nước sản xuất
GROUP BY NUOCSX_02_Ha;

--III. Câu 31: Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm
--Tên nước sản xuất
--Sử dụng hàm MAX để tìm giá bán cao nhất
--Sử dụng hàm MIN để tìm giá bán thấp nhất
--Sử dụng hàm AVG để tìm giá bán trung bình
SELECT NUOCSX_02_Ha, MAX(GIA_02_Ha) AS MaxGia, MIN(GIA_02_Ha) AS MinGia, AVG(GIA_02_Ha) AS AvgGia
FROM SANPHAM_02_Ha
--Nhóm các sản phẩm theo từng nước sản xuất
GROUP BY NUOCSX_02_Ha;

--III. Câu 32: Doanh thu bán hàng mỗi ngày.
--Mỗi ngày (NGHD) sẽ cộng tất cả TRIGIA lại → ra doanh thu ngày đó
SELECT NGHD_02_Ha, SUM(TRIGIA_02_Ha) AS DoanhThu
FROM HOADON_02_Ha
--Nhóm các hóa đơn theo từng ngày
GROUP BY NGHD_02_Ha;

--III. Câu 33: Tổng số lượng của từng sản phẩm bán ra trong ngày 28/10/2006
SELECT CT.MASP_02_Ha, SUM(CT.SL_02_Ha) AS TongSL
FROM CTHD_02_Ha CT, HOADON_02_Ha HD
--Nối 2 bảng qua số hóa đơn
--Chỉ lấy các hóa đơn trong ngày 28/10/2006
WHERE CT.SOHD_02_Ha = HD.SOHD_02_Ha AND HD.NGHD_02_Ha = '2006-10-28'
--Nhóm theo từng sản phẩm để tính tổng số lượng
GROUP BY CT.MASP_02_Ha;

--III. Câu 34: Doanh thu bán hàng của từng tháng trong năm 2006
--Lấy tháng từ ngày hóa đơn
--Tổng doanh thu của tháng đó 
SELECT MONTH(NGHD_02_Ha) AS Thang, SUM(TRIGIA_02_Ha) AS DoanhThu
FROM HOADON_02_Ha
--Lọc năm 2006
WHERE YEAR(NGHD_02_Ha) = 2006
--Nhóm theo từng tháng
GROUP BY MONTH(NGHD_02_Ha);

--III. Câu 35: Khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất
--Mã khách hàng, họ tên khách hàng, số lần mua
SELECT TOP 1 KH.MAKH_02_Ha, KH.HOTEN_02_Ha, COUNT(*) AS SOLAN
FROM KHACHHANG_02_Ha KH, HOADON_02_Ha HD
--Nối khách hàng với hóa đơn
WHERE KH.MAKH_02_Ha = HD.MAKH_02_Ha
--Nhóm theo từng khách hàng
GROUP BY KH.MAKH_02_Ha, KH.HOTEN_02_Ha
--Sắp xếp giảm dần theo số lần mua
ORDER BY SOLAN DESC;

-- Câu 36: Tìm sản phẩm có tổng số lượng bán thấp nhất trong năm 2006
--Tổng số lượng đã bán
SELECT TOP 1 SP.MASP_02_Ha, SP.TENSP_02_Ha, SUM(CT.SL_02_Ha) AS TONGSL
FROM SANPHAM_02_Ha SP, CTHD_02_Ha CT, HOADON_02_Ha HD
--Nối các bảng lại với nhau
--Lọc các hóa đơn trong năm 2006
WHERE SP.MASP_02_Ha = CT.MASP_02_Ha AND CT.SOHD_02_Ha = HD.SOHD_02_Ha AND YEAR(HD.NGHD_02_Ha) = 2006
--Gom nhóm theo từng sản phẩm
GROUP BY SP.MASP_02_Ha, SP.TENSP_02_Ha
--Sắp xếp theo tổng số lượng tăng dần (ít nhất lên đầu)
ORDER BY TONGSL ASC;

-- III. Câu 37: Tháng có doanh thu bán hàng thấp nhất trong năm 2006
--Lấy tháng từ ngày hóa đơn
--Tính tổng doanh thu của từng tháng
SELECT TOP 1 MONTH(NGHD_02_Ha) AS THANG, SUM(TRIGIA_02_Ha) AS DOANHTHU
FROM HOADON_02_Ha
--Chỉ xét các hóa đơn trong năm 2006
WHERE YEAR(NGHD_02_Ha) = 2006
--Nhóm theo từng tháng để tính doanh thu mỗi tháng
GROUP BY MONTH(NGHD_02_Ha)
--Sắp xếp theo doanh thu tăng dần (thấp nhất lên đầu)
ORDER BY DOANHTHU ASC;

-- III. Câu 38: Mỗi nước sản xuất, tìm sản phẩm có giá bán cao nhất
SELECT MASP_02_Ha, TENSP_02_Ha, NUOCSX_02_Ha, GIA_02_Ha
FROM SANPHAM_02_Ha
--Chỉ lấy những sản phẩm có giá bằng giá cao nhất trong cùng nước sản xuất
WHERE GIA_02_Ha = (
    SELECT MAX(GIA_02_Ha)
    FROM SANPHAM_02_Ha SP2
    -- So sánh theo từng nước sản xuất
    WHERE SP2.NUOCSX_02_Ha = SANPHAM_02_Ha.NUOCSX_02_Ha
);

-- III. Câu 39: Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất
--Đếm số lần mua (số hóa đơn)
SELECT TOP 1 KH.MAKH_02_Ha, KH.HOTEN_02_Ha, COUNT(*) AS SOLAN
FROM KHACHHANG_02_Ha KH, HOADON_02_Ha HD
--Nối bảng khách hàng với hóa đơn theo mã khách hàng
--Chỉ xét các khách hàng thuộc top 10 có doanh số cao nhất
WHERE KH.MAKH_02_Ha = HD.MAKH_02_Ha AND KH.MAKH_02_Ha IN (
    SELECT TOP 10 MAKH_02_Ha
    FROM KHACHHANG_02_Ha
    --Sắp xếp giảm dần theo doanh số để lấy top 10
    ORDER BY DOANHSO_02_Ha DESC
)
--Nhóm theo từng khách hàng để tính số lần mua
GROUP BY KH.MAKH_02_Ha, KH.HOTEN_02_Ha
--Sắp xếp theo số lần mua giảm dần (nhiều nhất lên đầu)
ORDER BY SOLAN DESC;

-- III. Câu 40: Tìm nước sản xuất có ít nhất 3 sản phẩm có giá bán khác nhau
SELECT NUOCSX_02_Ha
FROM SANPHAM_02_Ha
--Nhóm theo từng nước sản xuất
GROUP BY NUOCSX_02_Ha
--Chỉ giữ những nước có ít nhất 3 mức giá khác nhau
HAVING COUNT(DISTINCT GIA_02_Ha) >= 3;