create database THUC_AN_MEO
USE THUC_AN_MEO
go

-- Tạo bảng HangSanXuats
CREATE TABLE dbo.HangSanXuat
(
    MaHang INT IDENTITY(1,1) PRIMARY KEY,
    TenHang NVARCHAR(50)
);

-- Tạo bảng LoaiTaiKhoans
CREATE TABLE dbo.LoaiTaiKhoan
(
    MaLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai NVARCHAR(50),
    MoTa NVARCHAR(250)
);

-- Tạo bảng KhachHangs
CREATE TABLE dbo.KhachHang
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TenKH NVARCHAR(50),
    GioiTinh BIT NOT NULL,
    DiaChi NVARCHAR(250),
    SDT NVARCHAR(50),
    Email NVARCHAR(250)
);

-- Tạo bảng NhaPhanPhois
CREATE TABLE dbo.NhaPhanPhoi
(
    MaNhaPhanPhoi INT IDENTITY(1,1) PRIMARY KEY,
    TenNhaPhanPhoi NVARCHAR(250),
    DiaChi NVARCHAR(MAX),
    SDT NVARCHAR(50)
);

-- Tạo bảng SanPhams
CREATE TABLE dbo.SanPham
(
    MaSanPham INT IDENTITY(1,1) PRIMARY KEY,
    TenSanPham NVARCHAR(150),
    Gia DECIMAL(18, 0),
    SoLuong INT
);

-- Tạo bảng SanPhams_NhaPhanPhois
CREATE TABLE dbo.SanPham_NhaPhanPhoi
(
    MaSanPham INT NOT NULL,
    MaNhaPhanPhoi INT NOT NULL,
    PRIMARY KEY CLUSTERED (MaNhaPhanPhoi ASC, MaSanPham ASC),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham),
    FOREIGN KEY (MaNhaPhanPhoi) REFERENCES NhaPhanPhoi(MaNhaPhanPhoi)
);

-- Tạo bảng TaiKhoans
CREATE TABLE dbo.TaiKhoan
(
    MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    LoaiTaiKhoan INT,
    TenTaiKhoan NVARCHAR(50),
    MatKhau NVARCHAR(50),
    Email NVARCHAR(150)
);

-- Tạo bảng ChiTietSanPhams
CREATE TABLE dbo.ChiTietSanPham
(
    MaChiTietSanPham INT IDENTITY(1,1) PRIMARY KEY,
    MaSanPham INT,
    MaNhaSanXuat INT,
    MoTa NVARCHAR(350) NOT NULL,
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Tạo bảng HoaDonNhaps
CREATE TABLE dbo.HoaDonNhap
(
    MaHoaDon INT IDENTITY(1,1) PRIMARY KEY,
    MaNhaPhanPhoi INT,
    NgayTao DATETIME,
    MaTaiKhoan INT,
    FOREIGN KEY (MaNhaPhanPhoi) REFERENCES NhaPhanPhoi(MaNhaPhanPhoi),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);

-- Tạo bảng HoaDons
CREATE TABLE dbo.HoaDon
(
    MaHoaDon INT IDENTITY(1,1) PRIMARY KEY,
    NgayTao DATETIME,
    TongGia DECIMAL(18, 0),
    TenKH NVARCHAR(50),
    GioiTinh BIT NOT NULL,
    Diachi NVARCHAR(250),
    Email NVARCHAR(50),
    SDT NVARCHAR(50)
);

-- Tạo bảng ChiTietHoaDonNhaps
CREATE TABLE dbo.ChiTietHoaDonNhap
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    MaHoaDon INT,
    MaSanPham INT,
    SoLuong INT,
    GiaNhap DECIMAL(18, 0),
    TongTien DECIMAL(18, 0),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDonNhap(MaHoaDon),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Tạo bảng ChiTietHoaDons
CREATE TABLE dbo.ChiTietHoaDon
(
    MaChiTietHoaDon INT IDENTITY(1,1) PRIMARY KEY,
    MaHoaDon INT,
    MaSanPham INT,
    SoLuong INT,
    TongGia DECIMAL(18, 0),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

-- Tạo bảng ChiTietTaiKhoans
CREATE TABLE dbo.ChiTietTaiKhoan
(
    MaChitietTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    MaTaiKhoan INT,
    HoTen NVARCHAR(50),
    DiaChi NVARCHAR(250),
    SDT NVARCHAR(11),
    FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan)
);
go

INSERT INTO dbo.HangSanXuat (TenHang)
VALUES ('Hãng A'),
       ('Hãng B'),
       ('Hãng C'),
       ('Hãng D'),
       ('Hãng E'),
       ('Hãng F'),
       ('Hãng G'),
       ('Hãng H'),
       ('Hãng I'),
       ('Hãng J');
go

INSERT INTO dbo.LoaiTaiKhoan (TenLoai, MoTa)
VALUES ('Loại 1', 'Mô tả loại 1'),
       ('Loại 2', 'Mô tả loại 2'),
       ('Loại 3', 'Mô tả loại 3'),
       ('Loại 4', 'Mô tả loại 4'),
       ('Loại 5', 'Mô tả loại 5'),
       ('Loại 6', 'Mô tả loại 6'),
       ('Loại 7', 'Mô tả loại 7'),
       ('Loại 8', 'Mô tả loại 8'),
       ('Loại 9', 'Mô tả loại 9'),
       ('Loại 10', 'Mô tả loại 10');
go

INSERT INTO dbo.KhachHang (TenKH, GioiTinh, DiaChi, SDT, Email)
VALUES ('Khách hàng 1', 1, 'Địa chỉ 1', '1234567890', 'email1@example.com'),
       ('Khách hàng 2', 0, 'Địa chỉ 2', '9876543210', 'email2@example.com'),
       ('Khách hàng 3', 1, 'Địa chỉ 3', '5555555555', 'email3@example.com'),
       ('Khách hàng 4', 0, 'Địa chỉ 4', '1111111111', 'email4@example.com'),
       ('Khách hàng 5', 1, 'Địa chỉ 5', '9999999999', 'email5@example.com'),
       ('Khách hàng 6', 1, 'Địa chỉ 6', '8888888888', 'email6@example.com'),
       ('Khách hàng 7', 0, 'Địa chỉ 7', '7777777777', 'email7@example.com'),
       ('Khách hàng 8', 1, 'Địa chỉ 8', '6666666666', 'email8@example.com'),
       ('Khách hàng 9', 0, 'Địa chỉ 9', '4444444444', 'email9@example.com'),
       ('Khách hàng 10', 1, 'Địa chỉ 10', '2222222222', 'email10@example.com');
go

INSERT INTO dbo.NhaPhanPhoi (TenNhaPhanPhoi, DiaChi, SDT)
VALUES ('Nhà phân phối 1', 'Địa chỉ 1', '1111111111'),
       ('Nhà phân phối 2', 'Địa chỉ 2', '2222222222'),
       ('Nhà phân phối 3', 'Địa chỉ 3', '3333333333'),
       ('Nhà phân phối 4', 'Địa chỉ 4', '4444444444'),
       ('Nhà phân phối 5', 'Địa chỉ 5', '5555555555'),
       ('Nhà phân phối 6', 'Địa chỉ 6', '6666666666'),
       ('Nhà phân phối 7', 'Địa chỉ 7', '7777777777'),
       ('Nhà phân phối 8', 'Địa chỉ 8', '8888888888'),
       ('Nhà phân phối 9', 'Địa chỉ 9', '9999999999'),
       ('Nhà phân phối 10', 'Địa chỉ 10', '1010101010');
go


INSERT INTO dbo.SanPham (TenSanPham, Gia, SoLuong)
VALUES ('Sản phẩm 1', 10000, 50),
       ('Sản phẩm 2', 20000, 30),
       ('Sản phẩm 3', 15000, 40),
       ('Sản phẩm 4', 25000, 20),
       ('Sản phẩm 5', 18000, 60),
       ('Sản phẩm 6', 30000, 25),
       ('Sản phẩm 7', 22000, 35),
       ('Sản phẩm 8', 28000, 45),
       ('Sản phẩm 9', 21000, 55),
       ('Sản phẩm 10', 32000, 15);
go

-- Ví dụ: Liên kết sản phẩm 1 với nhà phân phối 1 và sản phẩm 2 với nhà phân phối 2.
INSERT INTO dbo.SanPham_NhaPhanPhoi (MaSanPham, MaNhaPhanPhoi)
VALUES (1, 1),
       (2, 2);
go


INSERT INTO dbo.TaiKhoan (LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
VALUES (1, 'tai_khoan_1', 'password1', 'email1@example.com'),
       (2, 'tai_khoan_2', 'password2', 'email2@example.com'),
       (3, 'tai_khoan_3', 'password3', 'email3@example.com'),
       (4, 'tai_khoan_4', 'password4', 'email4@example.com'),
       (5, 'tai_khoan_5', 'password5', 'email5@example.com'),
       (6, 'tai_khoan_6', 'password6', 'email6@example.com'),
       (7, 'tai_khoan_7', 'password7', 'email7@example.com'),
       (8, 'tai_khoan_8', 'password8', 'email8@example.com'),
       (9, 'tai_khoan_9', 'password9', 'email9@example.com'),
       (10, 'tai_khoan_10', 'password10', 'email10@example.com');
go

INSERT INTO dbo.ChiTietSanPham (MaSanPham, MaNhaSanXuat, MoTa)
VALUES (1, 1, 'Mô tả sản phẩm 1'),
       (2, 2, 'Mô tả sản phẩm 2'),
       (3, 3, 'Mô tả sản phẩm 3'),
       (4, 4, 'Mô tả sản phẩm 4'),
       (5, 5, 'Mô tả sản phẩm 5'),
       (6, 6, 'Mô tả sản phẩm 6'),
       (7, 7, 'Mô tả sản phẩm 7'),
       (8, 8, 'Mô tả sản phẩm 8'),
       (9, 9, 'Mô tả sản phẩm 9'),
       (10, 10, 'Mô tả sản phẩm 10');
go

INSERT INTO dbo.HoaDonNhap (MaNhaPhanPhoi, NgayTao, MaTaiKhoan)
VALUES (1, '2023-10-04', 1),
       (2, '2023-10-05', 2),
       (3, '2023-10-06', 3),
       (4, '2023-10-07', 4),
       (5, '2023-10-08', 5),
       (6, '2023-10-09', 6),
       (7, '2023-10-10', 7),
       (8, '2023-10-11', 8),
       (9, '2023-10-12', 9),
       (10, '2023-10-13', 10);
go

INSERT INTO dbo.HoaDon (NgayTao, TongGia, TenKH, GioiTinh, Diachi, Email, SDT)
VALUES ('2023-10-04', 50000, 'Khách hàng A', 1, 'Địa chỉ A', 'emailA@example.com', '1111111111'),
       ('2023-10-05', 60000, 'Khách hàng B', 0, 'Địa chỉ B', 'emailB@example.com', '2222222222'),
       ('2023-10-06', 75000, 'Khách hàng C', 1, 'Địa chỉ C', 'emailC@example.com', '3333333333'),
       ('2023-10-07', 90000, 'Khách hàng D', 0, 'Địa chỉ D', 'emailD@example.com', '4444444444'),
       ('2023-10-08', 85000, 'Khách hàng E', 1, 'Địa chỉ E', 'emailE@example.com', '5555555555'),
       ('2023-10-09', 72000, 'Khách hàng F', 1, 'Địa chỉ F', 'emailF@example.com', '6666666666'),
       ('2023-10-10', 68000, 'Khách hàng G', 0, 'Địa chỉ G', 'emailG@example.com', '7777777777'),
       ('2023-10-11', 54000, 'Khách hàng H', 1, 'Địa chỉ H', 'emailH@example.com', '8888888888'),
       ('2023-10-12', 61000, 'Khách hàng I', 0, 'Địa chỉ I', 'emailI@example.com', '9999999999'),
       ('2023-10-13', 42000, 'Khách hàng J', 1, 'Địa chỉ J', 'emailJ@example.com', '1010101010');
go


INSERT INTO dbo.ChiTietHoaDonNhap (MaHoaDon, MaSanPham, SoLuong, GiaNhap, TongTien)
VALUES (1, 1, 10, 10000, 100000),
       (2, 2, 8, 20000, 160000),
       (3, 3, 12, 15000, 180000),
       (4, 4, 6, 25000, 150000),
       (5, 5, 15, 18000, 270000),
       (6, 6, 7, 30000, 210000),
       (7, 7, 9, 22000, 198000),
       (8, 8, 11, 28000, 308000),
       (9, 9, 5, 21000, 105000),
       (10, 10, 20, 32000, 640000);
go

INSERT INTO dbo.ChiTietHoaDon (MaHoaDon, MaSanPham, SoLuong, TongGia)
VALUES (1, 1, 5, 50000),
       (2, 2, 4, 80000),
       (3, 3, 6, 90000),
       (4, 4, 3, 75000),
       (5, 5, 8, 144000),
       (6, 6, 5, 150000),
       (7, 7, 7, 154000),
       (8, 8, 9, 252000),
       (9, 9, 4, 84000),
       (10, 10, 15, 480000);
go

INSERT INTO dbo.ChiTietTaiKhoan (MaTaiKhoan, HoTen, DiaChi, SDT)
VALUES (1, 'Người dùng 1', 'Địa chỉ 1', '1111111111'),
       (2, 'Người dùng 2', 'Địa chỉ 2', '2222222222'),
       (3, 'Người dùng 3', 'Địa chỉ 3', '3333333333'),
       (4, 'Người dùng 4', 'Địa chỉ 4', '4444444444'),
       (5, 'Người dùng 5', 'Địa chỉ 5', '5555555555'),
       (6, 'Người dùng 6', 'Địa chỉ 6', '6666666666'),
       (7, 'Người dùng 7', 'Địa chỉ 7', '7777777777'),
       (8, 'Người dùng 8', 'Địa chỉ 8', '8888888888'),
       (9, 'Người dùng 9', 'Địa chỉ 9', '9999999999'),
       (10, 'Người dùng 10', 'Địa chỉ 10', '1010101010');
go










Create PROCEDURE [dbo].[sp_khach_get_by_id](@id int)
AS
    BEGIN
      SELECT  *
      FROM KhachHang
      where id= @id;
    END;

GO

create PROCEDURE [dbo].[sp_khach_create](
@TenKH nvarchar(50),
@GioiTinh bit,
@DiaChi nvarchar(250),
@SDT nvarchar(50),
@Email nvarchar(250)
)
AS
    BEGIN
       insert into KhachHang(TenKH,GioiTinh,DiaChi,SDT,Email)
	   values(@TenKH,@GioiTinh,@DiaChi,@SDT,@Email);
    END;
	go
	

Create PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @dia_chi Nvarchar(250)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.Id,
							  k.TenKH,
							  k.DiaChi
                        INTO #Results1
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.Id,
							  k.TenKH,
							  k.DiaChi
                        INTO #Results2
                        FROM KhachHangs AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;


	go
	
	
create PROCEDURE [dbo].[sp_thong_ke_khach] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  h.TenKH,
							  h.Diachi
                        INTO #Results1
                        FROM HoaDon  h
						inner join ChiTietHoaDon c on c.MaHoaDon = h.MaHoaDon
						inner join SanPham s on s.MaSanPham = c.MaSanPham
					    WHERE  (@ten_khach = '' Or h.TenKH like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  h.TenKH,
							  h.Diachi
                        INTO #Results2
                        FROM HoaDon  h
						inner join ChiTietHoaDon c on c.MaHoaDon = h.MaHoaDon
						inner join SanPham s on s.MaSanPham = c.MaSanPham
					    WHERE  (@ten_khach = '' Or h.TenKH like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

	
GO


CREATE PROCEDURE [dbo].[sp_hoa_don_update]
(
    @MaHoaDon INT,
    @TenKH NVARCHAR(50),
    @Diachi NVARCHAR(250),
    @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
BEGIN
    UPDATE HoaDon
    SET
        TenKH = @TenKH,
        Diachi = @Diachi
    WHERE MaHoaDon = @MaHoaDon;

    IF (@list_json_chitiethoadon IS NOT NULL)
    BEGIN
        -- Insert data to temp table 
        SELECT
            JSON_VALUE(p.value, '$.maChiTietHoaDon') AS maChiTietHoaDon,
            JSON_VALUE(p.value, '$.maHoaDon') AS maHoaDon,
            JSON_VALUE(p.value, '$.maSanPham') AS maSanPham,
            JSON_VALUE(p.value, '$.soLuong') AS soLuong,
            JSON_VALUE(p.value, '$.tongGia') AS tongGia,
            JSON_VALUE(p.value, '$.status') AS status
        INTO #Results
        FROM OPENJSON(@list_json_chitiethoadon) AS p;

        -- Insert data to table with STATUS = 1;
        INSERT INTO ChiTietHoaDon (MaSanPham, MaHoaDon, SoLuong, TongGia)
        SELECT
            #Results.maSanPham,
            @MaHoaDon,
            #Results.soLuong,
            #Results.tongGia
        FROM #Results
        WHERE #Results.status = '1';

        -- Update data to table with STATUS = 2
        UPDATE ChiTietHoaDon
        SET
            SoLuong = #Results.soLuong,
            TongGia = #Results.tongGia
        FROM #Results
        WHERE ChiTietHoaDon.maChiTietHoaDon = #Results.maChiTietHoaDon AND #Results.status = '2';

        -- Delete data from table with STATUS = 3
        DELETE C
        FROM ChiTietHoaDon C
        INNER JOIN #Results R ON C.maChiTietHoaDon = R.maChiTietHoaDon
        WHERE R.status = '3';

        DROP TABLE #Results;
    END;

    SELECT '';
END;
go




CREATE PROCEDURE [dbo].[sp_hoadon_create]
(
    @TenKH NVARCHAR(50), 
    @Diachi NVARCHAR(250), 
    @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @MaHoaDon INT;
    
    INSERT INTO HoaDon
    (
        TenKH, 
        Diachi
    )
    VALUES
    (
        @TenKH, 
        @Diachi
    );

    SET @MaHoaDon = (SELECT SCOPE_IDENTITY());

    IF (@list_json_chitiethoadon IS NOT NULL)
    BEGIN
        INSERT INTO ChiTietHoaDon
        (
            MaSanPham, 
            MaHoaDon,
            SoLuong, 
            TongGia
        )
        SELECT 
            JSON_VALUE(p.value, '$.maSanPham'), 
            @MaHoaDon, 
            JSON_VALUE(p.value, '$.soLuong'), 
            JSON_VALUE(p.value, '$.tongGia')    
        FROM OPENJSON(@list_json_chitiethoadon) AS p;
    END;

    SELECT '';
END;
go



create PROCEDURE [dbo].[sp_hoadon_get_by_id](@MaHoaDon  int)
AS
    BEGIN
        SELECT h.*, 
        (
            SELECT c.*
            FROM ChiTietHoaDon AS c
            WHERE h.MaHoaDon = c.MaHoaDon FOR JSON PATH
        ) AS list_json_chitiethoadon
        FROM HoaDon AS h
        WHERE  h.MaHoaDon = @MaHoaDon;
    END;
	go

	

	


CREATE PROCEDURE [dbo].[sp_login]
(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
BEGIN
    SELECT *
    FROM TaiKhoan
    WHERE TenTaiKhoan = @taikhoan AND MatKhau = @matkhau;
END;
go
;






