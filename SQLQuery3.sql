CREATE DATABASE  THUC_AN_MEO
USE [THUC_AN_MEO]
GO
-- Bảng lưu thông tin về loại tài khoản
CREATE TABLE LoaiTaiKhoans (
    LoaiTaiKhoanID INT PRIMARY KEY,
    TenLoai NVARCHAR(255)
);

-- Bảng lưu thông tin về hãng sản xuất
CREATE TABLE HangSanXuats (
    HangSanXuatID INT PRIMARY KEY,
    TenHangSanXuat NVARCHAR(255)
);

-- Bảng lưu thông tin về sản phẩm
CREATE TABLE SanPhams (
    SanPhamID INT PRIMARY KEY,
    TenSanPham NVARCHAR(255),
    Gia DECIMAL(18, 2)
);

-- Bảng lưu thông tin về nhà phân phối
CREATE TABLE NhaPhanPhois (
    NhaPhanPhoiID INT PRIMARY KEY,
    TenNhaPhanPhoi NVARCHAR(255),
    DiaChi NVARCHAR(255),
    DienThoai NVARCHAR(20)
);

-- Bảng lưu thông tin về tài khoản
CREATE TABLE TaiKhoans (
    TaiKhoanID INT PRIMARY KEY,
    TenTaiKhoan NVARCHAR(255),
    LoaiTaiKhoanID INT,
    FOREIGN KEY (LoaiTaiKhoanID) REFERENCES LoaiTaiKhoans(LoaiTaiKhoanID)
);

-- Bảng lưu thông tin về hóa đơn nhập
CREATE TABLE HoaDonNhaps (
    HoaDonNhapID INT PRIMARY KEY,
    NgayNhap DATE,
    NhaPhanPhoiID INT,
    FOREIGN KEY (NhaPhanPhoiID) REFERENCES NhaPhanPhois(NhaPhanPhoiID)
);

-- Bảng lưu thông tin về chi tiết hóa đơn nhập
CREATE TABLE ChiTietHoaDonNhaps (
    ChiTietHoaDonNhapID INT PRIMARY KEY,
    HoaDonNhapID INT,
    SanPhamID INT,
    SoLuong INT,
    FOREIGN KEY (HoaDonNhapID) REFERENCES HoaDonNhaps(HoaDonNhapID),
    FOREIGN KEY (SanPhamID) REFERENCES SanPhams(SanPhamID)
);

-- Bảng lưu thông tin về khách hàng
CREATE TABLE KhachHangs (
    KhachHangID INT PRIMARY KEY,
    TenKhachHang NVARCHAR(255),
    DiaChi NVARCHAR(255),
    DienThoai NVARCHAR(20)
);

-- Bảng lưu thông tin về hóa đơn
CREATE TABLE HoaDons (
    HoaDonID INT PRIMARY KEY,
    NgayLap DATE,
    KhachHangID INT,
    FOREIGN KEY (KhachHangID) REFERENCES KhachHangs(KhachHangID)
);

-- Bảng lưu thông tin về chi tiết hóa đơn
CREATE TABLE ChiTietHoaDons (
    ChiTietHoaDonID INT PRIMARY KEY,
    HoaDonID INT,
    SanPhamID INT,
    SoLuong INT,
    FOREIGN KEY (HoaDonID) REFERENCES HoaDons(HoaDonID),
    FOREIGN KEY (SanPhamID) REFERENCES SanPhams(SanPhamID)
);

-- Bảng lưu thông tin về sản phẩm của từng nhà phân phối
CREATE TABLE SanPhams_NhaPhanPhois (
    SanPham_NhaPhanPhoiID INT PRIMARY KEY,
    SanPhamID INT,
    NhaPhanPhoiID INT,
    FOREIGN KEY (SanPhamID) REFERENCES SanPhams(SanPhamID),
    FOREIGN KEY (NhaPhanPhoiID) REFERENCES NhaPhanPhois(NhaPhanPhoiID)
);

-- Bảng lưu thông tin về chi tiết tài khoản
CREATE TABLE ChiTietTaiKhoans (
    ChiTietTaiKhoanID INT PRIMARY KEY,
    TaiKhoanID INT,
    HoaDonID INT,
    SoTien DECIMAL(18, 2),
    FOREIGN KEY (TaiKhoanID) REFERENCES TaiKhoans(TaiKhoanID),
    FOREIGN KEY (HoaDonID) REFERENCES HoaDons(HoaDonID)
);



-- Thêm 10 bản ghi vào bảng LoaiTaiKhoans
INSERT INTO LoaiTaiKhoans (LoaiTaiKhoanID, TenLoai)
VALUES
    (1, N'Loại 1'),
    (2, N'Loại 2'),
    (3, N'Loại 3'),
    (4, N'Loại 4'),
    (5, N'Loại 5'),
    (6, N'Loại 6'),
    (7, N'Loại 7'),
    (8, N'Loại 8'),
    (9, N'Loại 9'),
    (10, N'Loại 10');

-- Thêm 10 bản ghi vào bảng HangSanXuats
INSERT INTO HangSanXuats (HangSanXuatID, TenHangSanXuat)
VALUES
    (1, N'Hãng 1'),
    (2, N'Hãng 2'),
    (3, N'Hãng 3'),
    (4, N'Hãng 4'),
    (5, N'Hãng 5'),
    (6, N'Hãng 6'),
    (7, N'Hãng 7'),
    (8, N'Hãng 8'),
    (9, N'Hãng 9'),
    (10, N'Hãng 10');

-- Thêm 10 bản ghi vào bảng SanPhams
INSERT INTO SanPhams (SanPhamID, TenSanPham, Gia)
VALUES
    (1, N'Sản phẩm 1', 10.99),
    (2, N'Sản phẩm 2', 15.99),
    (3, N'Sản phẩm 3', 12.49),
    (4, N'Sản phẩm 4', 8.99),
    (5, N'Sản phẩm 5', 9.99),
    (6, N'Sản phẩm 6', 11.99),
    (7, N'Sản phẩm 7', 14.99),
    (8, N'Sản phẩm 8', 7.99),
    (9, N'Sản phẩm 9', 13.99),
    (10, N'Sản phẩm 10', 16.99);

-- Thêm 10 bản ghi vào bảng NhaPhanPhois
INSERT INTO NhaPhanPhois (NhaPhanPhoiID, TenNhaPhanPhoi, DiaChi, DienThoai)
VALUES
    (1, N'Nhà phân phối 1', N'Địa chỉ 1', '0123456781'),
    (2, N'Nhà phân phối 2', N'Địa chỉ 2', '0123456782'),
    (3, N'Nhà phân phối 3', N'Địa chỉ 3', '0123456783'),
    (4, N'Nhà phân phối 4', N'Địa chỉ 4', '0123456784'),
    (5, N'Nhà phân phối 5', N'Địa chỉ 5', '0123456785'),
    (6, N'Nhà phân phối 6', N'Địa chỉ 6', '0123456786'),
    (7, N'Nhà phân phối 7', N'Địa chỉ 7', '0123456787'),
    (8, N'Nhà phân phối 8', N'Địa chỉ 8', '0123456788'),
    (9, N'Nhà phân phối 9', N'Địa chỉ 9', '0123456789'),
    (10, N'Nhà phân phối 10', N'Địa chỉ 10', '0123456780');

-- Thêm 10 bản ghi vào bảng TaiKhoans
INSERT INTO TaiKhoans (TaiKhoanID, TenTaiKhoan, LoaiTaiKhoanID)
VALUES
    (1, N'Tài khoản 1', 1),
    (2, N'Tài khoản 2', 2),
    (3, N'Tài khoản 3', 3),
    (4, N'Tài khoản 4', 4),
    (5, N'Tài khoản 5', 5),
    (6, N'Tài khoản 6', 6),
    (7, N'Tài khoản 7', 7),
    (8, N'Tài khoản 8', 8),
    (9, N'Tài khoản 9', 9),
    (10, N'Tài khoản 10', 10);
    
-- Thêm 10 bản ghi vào bảng HoaDonNhaps
INSERT INTO HoaDonNhaps (HoaDonNhapID, NgayNhap, NhaPhanPhoiID)
VALUES
    (1, '2023-01-01', 1),
    (2, '2023-01-02', 2),
    (3, '2023-01-03', 3),
    (4, '2023-01-04', 4),
    (5, '2023-01-05', 5),
    (6, '2023-01-06', 6),
    (7, '2023-01-07', 7),
    (8, '2023-01-08', 8),
    (9, '2023-01-09', 9),
    (10, '2023-01-10', 10);
    
-- Thêm 10 bản ghi vào bảng ChiTietHoaDonNhaps
INSERT INTO ChiTietHoaDonNhaps (ChiTietHoaDonNhapID, HoaDonNhapID, SanPhamID, SoLuong)
VALUES
    (1, 1, 1, 5),
    (2, 1, 2, 3),
    (3, 2, 3, 7),
    (4, 2, 4, 2),
    (5, 3, 5, 10),
    (6, 3, 6, 4),
    (7, 4, 7, 8),
    (8, 4, 8, 6),
    (9, 5, 9, 9),
    (10, 5, 10, 1);
    
-- Thêm 10 bản ghi vào bảng KhachHangs
INSERT INTO KhachHangs (KhachHangID, TenKhachHang, DiaChi, DienThoai)
VALUES
    (1, N'Khách hàng 1', N'Địa chỉ 1', '0123456781'),
    (2, N'Khách hàng 2', N'Địa chỉ 2', '0123456782'),
    (3, N'Khách hàng 3', N'Địa chỉ 3', '0123456783'),
    (4, N'Khách hàng 4', N'Địa chỉ 4', '0123456784'),
    (5, N'Khách hàng 5', N'Địa chỉ 5', '0123456785'),
    (6, N'Khách hàng 6', N'Địa chỉ 6', '0123456786'),
    (7, N'Khách hàng 7', N'Địa chỉ 7', '0123456787'),
    (8, N'Khách hàng 8', N'Địa chỉ 8', '0123456788'),
    (9, N'Khách hàng 9', N'Địa chỉ 9', '0123456789'),
    (10, N'Khách hàng 10', N'Địa chỉ 10', '0123456780');

-- Thêm 10 bản ghi vào bảng HoaDons
INSERT INTO HoaDons (HoaDonID, NgayLap, KhachHangID)
VALUES
    (1, '2023-01-01', 1),
    (2, '2023-01-02', 2),
    (3, '2023-01-03', 3),
    (4, '2023-01-04', 4),
    (5, '2023-01-05', 5),
    (6, '2023-01-06', 6),
    (7, '2023-01-07', 7),
    (8, '2023-01-08', 8),
    (9, '2023-01-09', 9),
    (10, '2023-01-10', 10);
    
-- Thêm 10 bản ghi vào bảng ChiTietHoaDons
INSERT INTO ChiTietHoaDons (ChiTietHoaDonID, HoaDonID, SanPhamID, SoLuong)
VALUES
    (1, 1, 1, 5),
    (2, 1, 2, 3),
    (3, 2, 3, 7),
    (4, 2, 4, 2),
    (5, 3, 5, 10),
    (6, 3, 6, 4),
    (7, 4, 7, 8),
    (8, 4, 8, 6),
    (9, 5, 9, 9),
    (10, 5, 10, 1);

-- Thêm 10 bản ghi vào bảng SanPhams_NhaPhanPhois
INSERT INTO SanPhams_NhaPhanPhois (SanPham_NhaPhanPhoiID, SanPhamID, NhaPhanPhoiID)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10);
    
-- Thêm 10 bản ghi vào bảng ChiTietTaiKhoans
INSERT INTO ChiTietTaiKhoans (ChiTietTaiKhoanID, TaiKhoanID, HoaDonID, SoTien)
VALUES
    (1, 1, 1, 100.50),
    (2, 1, 2, 50.25),
    (3, 2, 3, 75.75),
    (4, 2, 4, 30.00),
    (5, 3, 5, 90.00),
    (6, 3, 6, 40.50),
    (7, 4, 7, 60.75),
    (8, 4, 8, 25.25),
    (9, 5, 9, 80.00),
    (10, 5, 10, 35.50);
go



	CREATE PROCEDURE [dbo].[sp_khach_get_by_id](@id int)
AS
BEGIN
    SELECT *
    FROM KhachHangs
    WHERE KhachHangID = @id;
END;
go


CREATE PROCEDURE [dbo].[sp_khach_create](
    @TenKhachHang NVARCHAR(255),
    @DiaChi NVARCHAR(255),
    @DienThoai NVARCHAR(20)
)
AS
BEGIN
    INSERT INTO KhachHangs(TenKhachHang, DiaChi, DienThoai)
    VALUES (@TenKhachHang, @DiaChi, @DienThoai);
END;
go


CREATE PROCEDURE [dbo].[sp_khach_search] (
    @page_index INT, 
    @page_size INT,
    @ten_khach NVARCHAR(50),
    @dia_chi NVARCHAR(250)
)
AS
BEGIN
    IF (@page_size <> 0)
    BEGIN
        DECLARE @RecordCount INT;
        
        SET NOCOUNT ON;

        SELECT 
            ROW_NUMBER() OVER (ORDER BY TenKhachHang ASC) AS RowNumber, 
            KhachHangID AS Id,
            TenKhachHang AS TenKH,
            DiaChi
        INTO #Results1
        FROM KhachHangs
        WHERE (@ten_khach = '' OR TenKhachHang LIKE N'%' + @ten_khach + '%')
          AND (@dia_chi = '' OR DiaChi LIKE N'%' + @dia_chi + '%');

        SELECT @RecordCount = COUNT(*)
        FROM #Results1;

        SELECT *, @RecordCount AS RecordCount
        FROM #Results1
        WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
            OR @page_index = -1;

        DROP TABLE #Results1; 
    END;
    ELSE
    BEGIN
        SET NOCOUNT ON;

        SELECT 
            ROW_NUMBER() OVER (ORDER BY TenKhachHang ASC) AS RowNumber, 
            KhachHangID AS Id,
            TenKhachHang AS TenKH,
            DiaChi
        INTO #Results2
        FROM KhachHangs
        WHERE (@ten_khach = '' OR TenKhachHang LIKE N'%' + @ten_khach + '%')
          AND (@dia_chi = '' OR DiaChi LIKE N'%' + @dia_chi + '%');

        SELECT @RecordCount = COUNT(*)
        FROM #Results2;

        SELECT *, @RecordCount AS RecordCount
        FROM #Results2;                        

        DROP TABLE #Results2; 
    END;
END;
go



