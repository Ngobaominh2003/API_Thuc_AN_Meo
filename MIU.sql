CREATE DATABASE MIU;
GO

USE MIU;
GO

CREATE TABLE LoaiHoaDon (
    LoaiHoaDonID INT IDENTITY(1,1) PRIMARY KEY,
    TenLoaiHoaDon NVARCHAR(255) NULL
);

CREATE TABLE KhachHang (
    KhachHangID INT IDENTITY(1,1) PRIMARY KEY,
    TenKhachHang NVARCHAR(255) NULL,
    NgaySinh DATETIME NULL,
    GioiTinh NVARCHAR(10) NULL,
    DiaChi NVARCHAR(255) NULL,
    Email VARCHAR(100) CHECK (Email LIKE '%@%') NULL,
    SDT CHAR(11) NULL
);

CREATE TABLE NhanVien (
    NhanVienID INT IDENTITY(1,1) PRIMARY KEY,
    TenNhanVien NVARCHAR(255) NULL,
    GioiTinh NVARCHAR(10) NULL,
    DiaChi NVARCHAR(255) NULL,
    Email VARCHAR(100) CHECK (Email LIKE '%@%') NULL,
    SDT CHAR(11) NULL,
    ChucVu NVARCHAR(255) NULL
);

CREATE TABLE NhaCC (
    IDNhaCC INT IDENTITY(1,1) PRIMARY KEY,
    TenNhaCC NVARCHAR(255) NULL,
    DiaChi NVARCHAR(255) NULL,
    SDT CHAR(11) NULL
);

CREATE TABLE SanPham (
    SanPhamID INT IDENTITY(1,1) PRIMARY KEY,
    TenSanPham NVARCHAR(255) NULL,
    GiaBan INT NULL,
    SoLuong INT NULL,
    IDNhaCC INT NULL,
    FOREIGN KEY (IDNhaCC) REFERENCES NhaCC(IDNhaCC)
);

CREATE TABLE HoaDon (
    HoaDonID INT IDENTITY(1,1) PRIMARY KEY,
    NhanVienID INT NULL,
    KhachHangID INT NULL,
    LoaiHoaDonID INT NULL,
    TenSanPham NVARCHAR(255) NULL,
    SoLuong INT NULL,
    TongGia INT NULL,
    NgayLap DATETIME NULL,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID),
    FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID),
    FOREIGN KEY (LoaiHoaDonID) REFERENCES LoaiHoaDon(LoaiHoaDonID)
);

create  TABLE ChiTietHoaDonBan (
    IDChiTietHoaDonBan INT IDENTITY(1,1) PRIMARY KEY not null,
    HoaDonID INT NULL,
    SanPhamID INT NULL,
    KhachHangID INT NULL,
    SoLuong INT NULL,
    TongGia INT NULL,
    FOREIGN KEY (HoaDonID) REFERENCES HoaDon(HoaDonID),
    FOREIGN KEY (SanPhamID) REFERENCES SanPham(SanPhamID),
    FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID)
);

CREATE TABLE ChiTietHoaDonNhap (
    IDChiTietHoaDonNhap INT IDENTITY(1,1) PRIMARY KEY,
    HoaDonID INT NULL,
    SanPhamID INT NULL,
    IDNhaCC INT NULL,
    SoLuong INT NULL,
    TongGia MONEY NULL,
    FOREIGN KEY (HoaDonID) REFERENCES HoaDon(HoaDonID),
    FOREIGN KEY (SanPhamID) REFERENCES SanPham(SanPhamID),
    FOREIGN KEY (IDNhaCC) REFERENCES NhaCC(IDNhaCC)
);

CREATE TABLE TaiKhoan (
    TaiKhoanID INT IDENTITY(1,1) PRIMARY KEY,
    TenTaiKhoan NVARCHAR(255) NULL,
    MatKhau NVARCHAR(255) NULL,
    NhanVienID INT NULL,
    FOREIGN KEY (NhanVienID) REFERENCES NhanVien(NhanVienID)
);
GO

-- Insert into LoaiHoaDon
INSERT INTO LoaiHoaDon (TenLoaiHoaDon) VALUES 
('Hóa đơn bán hàng'), 
('Hóa đơn nhập hàng');

-- Insert into KhachHang
INSERT INTO KhachHang (TenKhachHang, NgaySinh, GioiTinh, DiaChi, Email, SDT) VALUES 
('Nguyen Van A', '1990-01-01', 'Nam', 'Ha Noi', 'nguyenvana@gmail.com', '0912345678'),
('Tran Thi B', '1995-02-02', 'Nữ', 'Ho Chi Minh', 'tranthib@gmail.com', '0912345679'),
('Le Van C', '1992-03-03', 'Nam', 'Da Nang', 'levanc@gmail.com', '0912345680'),
('Pham Thi D', '1988-04-04', 'Nữ', 'Hai Phong', 'phamthid@gmail.com', '0912345681'),
('Hoang Van E', '1998-05-05', 'Nam', 'Can Tho', 'hoangvane@gmail.com', '0912345682');

-- Insert into NhanVien
INSERT INTO NhanVien (TenNhanVien, GioiTinh, DiaChi, Email, SDT, ChucVu) VALUES 
('Tran Van X', 'Nam', 'Ha Noi', 'tranvanx@gmail.com', '0912345683', 'Quản lý'),
('Nguyen Thi Y', 'Nữ', 'Ho Chi Minh', 'nguyenthiy@gmail.com', '0912345684', 'Nhân viên'),
('Le Van Z', 'Nam', 'Da Nang', 'levanz@gmail.com', '0912345685', 'Nhân viên'),
('Pham Van K', 'Nam', 'Hai Phong', 'phamvank@gmail.com', '0912345686', 'Nhân viên'),
('Hoang Thi M', 'Nữ', 'Can Tho', 'hoangthim@gmail.com', '0912345687', 'Nhân viên');

-- Insert into NhaCC
INSERT INTO NhaCC (TenNhaCC, DiaChi, SDT) VALUES 
('Nha cung cap A', 'Ha Noi', '0912345688'),
('Nha cung cap B', 'Ho Chi Minh', '0912345689'),
('Nha cung cap C', 'Da Nang', '0912345690'),
('Nha cung cap D', 'Hai Phong', '0912345691'),
('Nha cung cap E', 'Can Tho', '0912345692');

-- Insert into SanPham
INSERT INTO SanPham (TenSanPham, GiaBan, SoLuong, IDNhaCC) VALUES 
('Thức ăn mèo A', 10000, 50, 1),
('Thức ăn mèo B', 15000, 30, 2),
('Thức ăn mèo C', 12000, 40, 3),
('Thức ăn mèo D', 18000, 20, 4),
('Thức ăn mèo E', 20000, 10, 5);

-- Insert into HoaDon
INSERT INTO HoaDon (NhanVienID, KhachHangID, LoaiHoaDonID, TenSanPham, SoLuong, TongGia, NgayLap) VALUES 
(1, 1, 1, 'Thức ăn mèo A', 2, 20000, '2023-10-20'),
(2, 2, 1, 'Thức ăn mèo B', 1, 15000, '2023-10-19'),
(3, 3, 1, 'Thức ăn mèo C', 3, 36000, '2023-10-18'),
(4, 4, 1, 'Thức ăn mèo D', 2, 36000, '2023-10-17'),
(5, 5, 1, 'Thức ăn mèo E', 1, 20000, '2023-10-16');

-- Insert into ChiTietHoaDonBan
INSERT INTO ChiTietHoaDonBan (HoaDonID, SanPhamID, KhachHangID, SoLuong, TongGia) VALUES 
(1, 1, 1, 2, 20000),
(2, 2, 2, 1, 15000),
(3, 3, 3, 3, 36000),
(4, 4, 4, 2, 36000),
(5, 5, 5, 1, 20000);

-- Insert into ChiTietHoaDonNhap
INSERT INTO ChiTietHoaDonNhap (HoaDonID, SanPhamID, IDNhaCC, SoLuong, TongGia) VALUES 
(1, 1, 1, 2, 20000),
(2, 2, 2, 1, 15000),
(3, 3, 3, 3, 36000),
(4, 4, 4, 2, 36000),
(5, 5, 5, 1, 20000);

-- Insert into TaiKhoan
INSERT INTO TaiKhoan (TenTaiKhoan, MatKhau, NhanVienID) VALUES 
('user1', 'password1', 1),
('user2', 'password2', 2),
('user3', 'password3', 3),
('user4', 'password4', 4),
('user5', 'password5', 5);
go