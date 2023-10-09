-- Tạo cơ sở dữ liệu
CREATE DATABASE TenCS;

-- Sử dụng cơ sở dữ liệu mới tạo
USE TenCS;
go
-- Tạo bảng LoaiHoaDon
CREATE TABLE dbo.LoaiHoaDon (
    LoaiHoaDonID INT PRIMARY KEY,
    TenLoaiHoaDon NVARCHAR(255)
);

-- Tạo bảng NhaCC (Nhà cung cấp)
CREATE TABLE dbo.NhaCC (
    NhaCCID INT PRIMARY KEY,
    TenNhaCC NVARCHAR(255),
    SDT NVARCHAR(20), -- Thêm kiểu dữ liệu cho SDT
    DiaChi NVARCHAR(255)
);

-- Tạo bảng SanPham
CREATE TABLE dbo.SanPham (
    SanPhamID INT PRIMARY KEY,
    TenSanPham NVARCHAR(255),
    GiaBan DECIMAL(18, 2),
    MoTa NVARCHAR(MAX), -- Thêm kiểu dữ liệu cho MoTa
    MaNhaCC INT,
    LoaiSanPham NVARCHAR(255),
    FOREIGN KEY (MaNhaCC) REFERENCES dbo.NhaCC(NhaCCID)
);

-- Tạo bảng KhachHang
CREATE TABLE dbo.KhachHang (
    KhachHangID INT PRIMARY KEY,
    TenKhachHang NVARCHAR(255),
    GioiTinh NVARCHAR(10), -- Thêm kiểu dữ liệu cho GioiTinh
    SDT NVARCHAR(20), -- Thêm kiểu dữ liệu cho SDT
    Email NVARCHAR(255), -- Thêm kiểu dữ liệu cho Email
    DiaChi NVARCHAR(255)
);

-- Tạo bảng HoaDon
CREATE TABLE dbo.HoaDon (
    HoaDonID INT PRIMARY KEY,
    MaKhachHang INT,
    NgayTao DATE,
    LoaiHoaDonID INT,
    FOREIGN KEY (MaKhachHang) REFERENCES dbo.KhachHang(KhachHangID),
    FOREIGN KEY (LoaiHoaDonID) REFERENCES dbo.LoaiHoaDon(LoaiHoaDonID)
);

-- Tạo bảng TaiKhoan
CREATE TABLE dbo.TaiKhoan (
    TaiKhoanID INT PRIMARY KEY,
    TenTaiKhoan NVARCHAR(255),
    MatKhau NVARCHAR(255),
    LoaiTaiKhoan NVARCHAR(50) -- Thêm kiểu dữ liệu cho LoaiTaiKhoan
);

-- Tạo bảng ChiTietHoaDonBan
CREATE TABLE dbo.ChiTietHoaDonBan (
    ChiTietHoaDonBanID INT PRIMARY KEY,
    HoaDonID INT,
    SanPhamID INT,
    SoLuong INT,
    GiaBan DECIMAL(18, 2),
    FOREIGN KEY (HoaDonID) REFERENCES dbo.HoaDon(HoaDonID),
    FOREIGN KEY (SanPhamID) REFERENCES dbo.SanPham(SanPhamID)
);

-- Tạo bảng ChiTietHoaDonNhap
CREATE TABLE dbo.ChiTietHoaDonNhap (
    ChiTietHoaDonNhapID INT PRIMARY KEY,
    HoaDonID INT,
    SanPhamID INT,
    SoLuong INT,
    GiaNhap DECIMAL(18, 2),
    FOREIGN KEY (HoaDonID) REFERENCES dbo.HoaDon(HoaDonID),
    FOREIGN KEY (SanPhamID) REFERENCES dbo.SanPham(SanPhamID)
);
go

-- Chèn dữ liệu vào bảng LoaiHoaDon
INSERT INTO dbo.LoaiHoaDon (LoaiHoaDonID, TenLoaiHoaDon)
VALUES
    (1, N'Loại 1'),
    (2, N'Loại 2'),
    (3, N'Loại 3'),
    (4, N'Loại 4'),
    (5, N'Loại 5');

-- Chèn dữ liệu vào bảng NhaCC (Nhà cung cấp)
INSERT INTO dbo.NhaCC (NhaCCID, TenNhaCC, SDT, DiaChi)
VALUES
    (1, N'Nhà cung cấp A', N'0123456789', N'Địa chỉ A'),
    (2, N'Nhà cung cấp B', N'0987654321', N'Địa chỉ B'),
    (3, N'Nhà cung cấp C', N'0365478963', N'Địa chỉ C'),
    (4, N'Nhà cung cấp D', N'0765432189', N'Địa chỉ D'),
    (5, N'Nhà cung cấp E', N'0123987654', N'Địa chỉ E');

-- Chèn dữ liệu vào bảng SanPham
INSERT INTO dbo.SanPham (SanPhamID, TenSanPham, GiaBan, MoTa, MaNhaCC, LoaiSanPham)
VALUES
    (1, N'Sản phẩm 1', 10.99, N'Mô tả sản phẩm 1', 1, N'Loại sản phẩm 1'),
    (2, N'Sản phẩm 2', 15.99, N'Mô tả sản phẩm 2', 2, N'Loại sản phẩm 2'),
    (3, N'Sản phẩm 3', 8.99, N'Mô tả sản phẩm 3', 3, N'Loại sản phẩm 1'),
    (4, N'Sản phẩm 4', 12.99, N'Mô tả sản phẩm 4', 4, N'Loại sản phẩm 3'),
    (5, N'Sản phẩm 5', 9.99, N'Mô tả sản phẩm 5', 5, N'Loại sản phẩm 2');

-- Chèn dữ liệu vào bảng KhachHang
INSERT INTO dbo.KhachHang (KhachHangID, TenKhachHang, GioiTinh, SDT, Email, DiaChi)
VALUES
    (1, N'Khách hàng 1', N'Nam', N'0123456789', N'khachhang1@example.com', N'Địa chỉ khách hàng 1'),
    (2, N'Khách hàng 2', N'Nữ', N'0987654321', N'khachhang2@example.com', N'Địa chỉ khách hàng 2'),
    (3, N'Khách hàng 3', N'Nam', N'0365478963', N'khachhang3@example.com', N'Địa chỉ khách hàng 3'),
    (4, N'Khách hàng 4', N'Nữ', N'0765432189', N'khachhang4@example.com', N'Địa chỉ khách hàng 4'),
    (5, N'Khách hàng 5', N'Nam', N'0123987654', N'khachhang5@example.com', N'Địa chỉ khách hàng 5');

-- Chèn dữ liệu vào bảng HoaDon
INSERT INTO dbo.HoaDon (HoaDonID, MaKhachHang, NgayTao, LoaiHoaDonID)
VALUES
    (1, 1, '2023-10-10', 1),
    (2, 2, '2023-10-11', 2),
    (3, 3, '2023-10-12', 3),
    (4, 4, '2023-10-13', 4),
    (5, 5, '2023-10-14', 5);

-- Chèn dữ liệu vào bảng TaiKhoan
INSERT INTO dbo.TaiKhoan (TaiKhoanID, TenTaiKhoan, MatKhau, LoaiTaiKhoan)
VALUES
    (1, N'Tài khoản 1', N'MatKhau1', N'Loại 1'),
    (2, N'Tài khoản 2', N'MatKhau2', N'Loại 2'),
    (3, N'Tài khoản 3', N'MatKhau3', N'Loại 3'),
    (4, N'Tài khoản 4', N'MatKhau4', N'Loại 4'),
    (5, N'Tài khoản 5', N'MatKhau5', N'Loại 5');

-- Chèn dữ liệu vào bảng ChiTietHoaDonBan
INSERT INTO dbo.ChiTietHoaDonBan (ChiTietHoaDonBanID, HoaDonID, SanPhamID, SoLuong, GiaBan)
VALUES
    (1, 1, 1, 3, 32.97),
    (2, 2, 2, 2, 31.98),
    (3, 3, 3, 4, 35.96),
    (4, 4, 4, 1, 12.99),
    (5, 5, 5, 5, 49.95);

-- Chèn dữ liệu vào bảng ChiTietHoaDonNhap
INSERT INTO dbo.ChiTietHoaDonNhap (ChiTietHoaDonNhapID, HoaDonID, SanPhamID, SoLuong, GiaNhap)
VALUES
    (1, 1, 1, 10, 80.00),
    (2, 2, 2, 8, 100.00),
    (3, 3, 3, 12, 120.00),
    (4, 4, 4, 6, 78.00),
    (5, 5, 5, 15, 150.00);
	go
-------để truy vấn----
CREATE PROCEDURE [dbo].[sp_khach_get_by_id](@id int)
AS
BEGIN
    SELECT *
    FROM KhachHang
    WHERE KhachHangID = @id;
END;

go

CREATE PROCEDURE [dbo].[sp_sanpham_get_by_id](@id int)
AS
BEGIN
    SELECT *
    FROM SanPham
    WHERE SanPhamID = @id;
END;
go

CREATE PROCEDURE [dbo].[sp_taikhoan_get_by_id](@id int)
AS
BEGIN
    SELECT *
    FROM TaiKhoan
    WHERE TaiKhoanID= @id;
END;
go
-----thêm  bản ghi mới, chèn dữ liệu-----
CREATE PROCEDURE [dbo].[sp_khach_create](
    
	@TenKhachHang NVARCHAR(255),
    @GioiTinh NVARCHAR(10),
    @SDT NVARCHAR(20), 
    @Email NVARCHAR(255), 
    @DiaChi NVARCHAR(255)
)
AS
BEGIN
    INSERT INTO KhachHang (TenKhachHang, GioiTinh, DiaChi, SDT, Email)
    VALUES (@TenKhachHang, @GioiTinh, @DiaChi, @SDT, @Email);
END;
GO

CREATE PROCEDURE [dbo].[sp_sanpham_create](
    @SanPhamID INT,
    @TenSanPham NVARCHAR(255),
    @GiaBan DECIMAL(18, 2),
    @MoTa NVARCHAR(MAX),
    @MaNhaCC INT,
    @LoaiSanPham NVARCHAR(255)
)
AS
BEGIN
    INSERT INTO SanPham(SanPhamID, TenSanPham, GiaBan, MoTa, MaNhaCC, LoaiSanPham)
    VALUES (@SanPhamID, @TenSanPham, @GiaBan, @MoTa, @MaNhaCC, @LoaiSanPham);
END;
GO

CREATE PROCEDURE [dbo].[sp_taikhoan_create](
    @TaiKhoanID INT,
    @TenTaiKhoan NVARCHAR(255),
    @MatKhau NVARCHAR(255),
    @LoaiTaiKhoan NVARCHAR(50) 
)
AS
BEGIN
    INSERT INTO TaiKhoan(TaiKhoanID, TenTaiKhoan, MatKhau, LoaiTaiKhoan)
    VALUES (@TaiKhoanID, @TenTaiKhoan, @MatKhau, @LoaiTaiKhoan);
END;
GO

-----Tìm kiếm----
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
                              ORDER BY TenKhachHang ASC)) AS RowNumber, 
                              k.KhachHangID,
							  k.TenKhachHang,
							  k.DiaChi
                        INTO #Results1
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKhachHang like N'%'+@ten_khach+'%') and						
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
                              ORDER BY TenKhachHang ASC)) AS RowNumber, 
                              k.KhachHangID,
							  k.TenKhachHang,
							  k.DiaChi
                        INTO #Results2
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKhachHang like N'%'+@ten_khach+'%') and						
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


CREATE PROCEDURE [dbo].[sp_sanpham_search]
(
    @page_index INT,
    @page_size INT,
    @ten_san_pham NVARCHAR(255),
    @gia_tu DECIMAL(18, 2),
    @gia_den DECIMAL(18, 2)
)
AS
BEGIN
    DECLARE @RecordCount BIGINT;
    IF (@page_size <> 0)
    BEGIN
        SET NOCOUNT ON;

        SELECT 
            ROW_NUMBER() OVER(ORDER BY SanPhamID ASC) AS RowNumber,
            *
        INTO #Results
        FROM SanPham
        WHERE 
            (@ten_san_pham = '' OR TenSanPham LIKE '%' + @ten_san_pham + '%') AND
            (@gia_tu IS NULL OR GiaBan >= @gia_tu) AND
            (@gia_den IS NULL OR GiaBan <= @gia_den);

        SELECT @RecordCount = COUNT(*) FROM #Results;
        
        SELECT *, @RecordCount AS RecordCount
        FROM #Results
        WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
            OR @page_index = -1;

        DROP TABLE #Results;
    END
    ELSE
    BEGIN
        SET NOCOUNT ON;

        SELECT 
            ROW_NUMBER() OVER(ORDER BY SanPhamID ASC) AS RowNumber,
            *
        INTO #Results3
        FROM SanPham
        WHERE
            (@ten_san_pham = '' OR TenSanPham LIKE '%' + @ten_san_pham + '%') AND
            (@gia_tu IS NULL OR GiaBan >= @gia_tu) AND
            (@gia_den IS NULL OR GiaBan <= @gia_den);

        SELECT @RecordCount = COUNT(*) FROM #Results3;

        SELECT *, @RecordCount AS RecordCount
        FROM #Results3;

        DROP TABLE #Results;
    END
END
go

CREATE PROCEDURE [dbo].[sp_taikhoan_search]
(
    @page_index INT,
    @page_size INT, 
    @ten_tai_khoan NVARCHAR(255),
    @loai_tai_khoan NVARCHAR(50)
)
AS
BEGIN
  SET NOCOUNT ON;

  SELECT 
    ROW_NUMBER() OVER(ORDER BY TaiKhoanID ASC) AS RowNumber,
    * 
  INTO #Results
  FROM TaiKhoan
  WHERE
    (@ten_tai_khoan = '' OR TenTaiKhoan LIKE '%' + @ten_tai_khoan + '%') AND 
    (@loai_tai_khoan = '' OR LoaiTaiKhoan = @loai_tai_khoan)

  DECLARE @RecordCount INT;
  SELECT @RecordCount = COUNT(*) FROM #Results;

  IF (@page_size > 0)
  BEGIN
    SELECT *, @RecordCount AS RecordCount
    FROM #Results
    WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
      OR @page_index = -1;
  END
  ELSE
  BEGIN
    SELECT *, @RecordCount AS RecordCount
    FROM #Results;
  END

  DROP TABLE #Results;
END
go
 ----Thống KÊ----

CREATE PROCEDURE [dbo].[sp_thong_ke_khach]
(
    @page_index INT,
    @page_size INT,
    @ten_khach NVARCHAR(50),
    @fr_NgayTao DATETIME,
    @to_NgayTao DATETIME
)
AS
BEGIN
  SET NOCOUNT ON;

  SELECT
    ROW_NUMBER() OVER(ORDER BY h.NgayTao ASC) AS RowNumber,
    s.SanPhamID, 
    s.TenSanPham,
    c.SoLuong,
    c.GiaBan * c.SoLuong AS TongGia, 
    h.NgayTao,
    kh.TenKhachHang, 
    kh.DiaChi
  INTO #Results
  FROM HoaDon h  
  INNER JOIN ChiTietHoaDonBan c ON c.HoaDonID = h.HoaDonID
  INNER JOIN SanPham s ON s.SanPhamID = c.SanPhamID
  INNER JOIN KhachHang kh ON kh.KhachHangID = h.MaKhachHang
  WHERE 
    (@ten_khach = '' OR kh.TenKhachHang LIKE N'%' + @ten_khach + '%') AND
    (@fr_NgayTao IS NULL AND @to_NgayTao IS NULL) OR
    (@fr_NgayTao IS NOT NULL AND @to_NgayTao IS NULL AND h.NgayTao >= @fr_NgayTao) OR
    (@fr_NgayTao IS NULL AND @to_NgayTao IS NOT NULL AND h.NgayTao <= @to_NgayTao) OR
    (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao)

  DECLARE @RecordCount INT
  SELECT @RecordCount = COUNT(*) FROM #Results

  IF (@page_size > 0)
  BEGIN
    SELECT *, @RecordCount AS RecordCount
    FROM #Results
    WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND (@page_index * @page_size)

    ORDER BY NgayTao ASC
  END
  ELSE
  BEGIN
    SELECT *, @RecordCount AS RecordCount
    FROM #Results
    
    ORDER BY NgayTao ASC
  END

  DROP TABLE #Results
END

go

----thủ tục lưu trữ được thiết kế để cập nhật thông tin---

CREATE PROCEDURE [dbo].[sp_khach_update]
(
    @KhachHangID INT,
    @TenKhachHang NVARCHAR(255),
    @GioiTinh NVARCHAR(10),
    @SDT NVARCHAR(20),
    @Email NVARCHAR(255),
    @DiaChi NVARCHAR(255)
)
AS
BEGIN
    UPDATE KhachHang 
    SET 
        TenKhachHang = @TenKhachHang,
        GioiTinh = @GioiTinh,
        SDT = @SDT,
        Email = @Email,
        DiaChi = @DiaChi
    WHERE 
        KhachHangID = @KhachHangID
END
go

CREATE PROCEDURE [dbo].[sp_sanpham_update]
(
    @SanPhamID INT,
    @TenSanPham NVARCHAR(255),
    @GiaBan DECIMAL(18,2), 
    @MoTa NVARCHAR(MAX),
    @MaNhaCC INT,
    @LoaiSanPham NVARCHAR(255)
)
AS
BEGIN
    UPDATE SanPham 
    SET
        TenSanPham = @TenSanPham,
        GiaBan = @GiaBan,
        MoTa = @MoTa,
        MaNhaCC = @MaNhaCC, 
        LoaiSanPham = @LoaiSanPham
    WHERE 
        SanPhamID = @SanPhamID
END
go

CREATE PROCEDURE [dbo].[sp_taikhoan_update]
(
    @TaiKhoanID INT,
    @TenTaiKhoan NVARCHAR(255),
    @MatKhau NVARCHAR(255),
    @LoaiTaiKhoan NVARCHAR(50)
)
AS 
BEGIN
    UPDATE TaiKhoan
    SET 
        TenTaiKhoan = @TenTaiKhoan,
        MatKhau = @MatKhau, 
        LoaiTaiKhoan = @LoaiTaiKhoan
    WHERE
        TaiKhoanID = @TaiKhoanID
END
go

---đăng nhập--

CREATE PROCEDURE [dbo].[sp_login]
(
    @taikhoan NVARCHAR(50),
    @matkhau NVARCHAR(255)
)
AS
BEGIN
    IF (EXISTS (SELECT 1 FROM TaiKhoan WHERE TenTaiKhoan = @taikhoan AND MatKhau = @matkhau))
       SELECT 1 AS LoginSuccess
    ELSE
       SELECT 0 AS LoginSuccess
END