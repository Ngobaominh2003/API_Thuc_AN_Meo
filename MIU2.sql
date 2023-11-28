
drop PROCEDURE [dbo].[sp_hoadon_get_by_id](@HoaDonID       int)
AS
    BEGIN
        SELECT h.*, 
        (
            SELECT c.*
            FROM ChiTietHoaDonBan AS c
            WHERE h.HoaDonID = c.HoaDonID FOR JSON PATH
        ) AS list_json_chitiethoadonban
        FROM HoaDon AS h
        WHERE  h.HoaDonID = @HoaDonID;
    END;
	
	EXEC [dbo].[sp_hoadon_get_by_id] @HoaDonID = 1;


go
	create PROCEDURE [dbo].[sp_hoadon_create]
    @KhachHangID int,
    @TenSanPham NVARCHAR(255),
    @SoLuong INT,
    @list_json_chitiethoadonban NVARCHAR(MAX)
AS
BEGIN
    DECLARE @HoaDonID INT;

    INSERT INTO HoaDon (KhachHangID, TenSanPham, SoLuong)
    VALUES (@KhachHangID, @TenSanPham, @SoLuong);

    SET @HoaDonID = SCOPE_IDENTITY();

    IF (@list_json_chitiethoadonban IS NOT NULL)
    BEGIN
        INSERT INTO ChiTietHoaDonBan (HoaDonID, SanPhamID, SoLuong, TongGia)
        SELECT @HoaDonID, JSON_VALUE(p.value, '$.SanPhamID'), JSON_VALUE(p.value, '$.SoLuong'),
               JSON_VALUE(p.value, '$.TongGia')
        FROM OPENJSON(@list_json_chitiethoadonban) AS p;
    END;

    SELECT '';
END;

EXEC sp_hoadon_create '1', '0', '0', null
GO
-- Declare and initialize the input parameters

DECLARE @HoaDonID INT = 1; -- Replace with your actual values
DECLARE @NhanVienID INT = 2; -- Replace with your actual values
DECLARE @KhachHangID INT = 3; -- Replace with your actual values
DECLARE @LoaiHoaDonID INT = 2; -- Replace with your actual values
DECLARE @TenSanPham NVARCHAR(255) = 'Sample Product'; -- Replace with your actual values
DECLARE @NgayLap DATETIME = '2023-11-28'; -- Replace with your actual values
DECLARE @SoLuong INT = 5; -- Replace with your actual values
DECLARE @TongGia INT = 100; -- Replace with your actual values
DECLARE @list_json_chitiethoadonban NVARCHAR(MAX) = '[{"idChiTietHoaDonBan": 1, "HoaDonid": 1, "SanPhamid": 1, "KhachHangid": 1, "soLuong": 5, "tongGia": 100, "status": "1"}]'; -- Replace with your actual JSON data

EXEC [dbo].[sp_hoa_don_update]
   @HoaDonID,
   @NhanVienID,
   @KhachHangID,
   @LoaiHoaDonID,
   @TenSanPham,
   @NgayLap,
   @SoLuong,
   @TongGia,
   @list_json_chitiethoadonban;
go
create PROCEDURE [dbo].[sp_hoa_don_update]
(@HoaDonID INT,
    @NhanVienID INT,
    @KhachHangID INT,
    @LoaiHoaDonID INT,
    @TenSanPham NVARCHAR(255),
    @NgayLap DATETIME,
    @SoLuong INT,
    @TongGia INT,  
 @list_json_chitiethoadonban NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDon
		SET
			NhanVienID  = @NhanVienID ,
			KhachHangID = @KhachHangID,
			LoaiHoaDonID = @LoaiHoaDonID,
			TenSanPham = @TenSanPham,
			NgayLap = @NgayLap,
			SoLuong = @SoLuong,
			TongGia=@TongGia
		WHERE HoaDonID = @HoaDonID;
		
		IF(@list_json_chitiethoadonban IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.idChiTietHoaDonBan') as idChiTietHoaDonBan,
			  JSON_VALUE(p.value, '$.HoaDonid') as HoaDonid,
			  JSON_VALUE(p.value, '$.SanPhamid') as SanPhamid,
			  JSON_VALUE(p.value, '$.KhachHangid') as KhachHangid,
			  JSON_VALUE(p.value, '$.soLuong') as soLuong,
			  JSON_VALUE(p.value, '$.tongGia') as tongGia,
			  JSON_VALUE(p.value, '$.status') AS status 
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadonban) AS p;
		 
		  --Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDonBan (HoaDonID, 
						  SanPhamID,
                          KhachHangID, 
						  SoLuong,
                          TongGia ) 
			   SELECT
				  #Results.SanPhamid,
				  @HoaDonID,		  
				  #Results.KhachHangid,
				  #Results.soLuong,
				  #Results.tongGia
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			 --Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDonBan
			  SET
				 SoLuong = #Results.soLuong,
				 TongGia = #Results.tongGia
			  FROM #Results 
			  WHERE  ChiTietHoaDonBan.IDChiTietHoaDonBan = #Results.idCHiTietHoaDonBan AND #Results.status = '2';
			
			 --Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDonBan C
			INNER JOIN #Results R
				ON C.IDChiTietHoaDonBan=R.idChiTietHoaDonBan
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;
	
	go
create PROCEDURE [dbo].[sp_hoa_don_delete] (@id int)
as	
	begin
		delete from HoaDon
		where HoaDonID = @id
		delete from ChiTietHoaDonBan 
		where HoaDonID = @id
	end
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
                              ORDER BY h.NgayLap ASC)) AS RowNumber, 
                              s.SanPhamID,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayLap,
							  h.KhachHangID,
							  h.NhanVienID
                        INTO #Results1
                        FROM HoaDon  h
						inner join ChiTietHoaDonBan c on c.HoaDonID = h.HoaDonID
						inner join SanPham s on s.SanPhamID= c.SanPhamID
					    WHERE  (@ten_khach = '' Or h.KhachHangID like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayLap >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayLap <= @to_NgayTao)
                        OR (h.NgayLap BETWEEN @fr_NgayTao AND @to_NgayTao))              
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
                              ORDER BY h.NgayLap ASC)) AS RowNumber, 
                               s.SanPhamID,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayLap,
							  h.KhachHangID,
							  h.NhanVienID
                        INTO #Results2
                        FROM HoaDon h
						inner join ChiTietHoaDonBan c on c.HoaDonID = h.HoaDonID
						inner join SanPham s on s.SanPhamID = c.SanPhamID
					    WHERE  (@ten_khach = '' Or h.KhachHangID like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayLap >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
						AND @to_NgayTao IS NOT NULL
                            AND h.NgayLap <= @to_NgayTao)
                        OR (h.NgayLap BETWEEN @fr_NgayTao AND @to_NgayTao))              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
select * from HoaDon
select * from ChiTietHoaDonBan
select * from SanPham

exec sp_thong_ke_khach 1,0,'',null,null

go


create PROCEDURE [dbo].[sp_khach_get_by_id](@id int)
AS
    BEGIN
      SELECT  *
      FROM KhachHang
      where KhachHangID= @id;
    END;
	exec [dbo].[sp_khach_get_by_id] @id =1
	go

create   PROCEDURE [dbo].[sp_khach_create]
    @TenKhachHang NVARCHAR(255),
    @SDT CHAR(11),
    @Email NVARCHAR(100),
    @DiaChi NVARCHAR(255)
AS
BEGIN
    INSERT INTO KhachHang (TenKhachHang, SDT, Email, DiaChi)
    VALUES (@TenKhachHang, @SDT, @Email, @DiaChi);
END;
go

create PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
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
							  k.Email,
							  k.NgaySinh,
							  k.GioiTinh,
							  k.SDT,
							  k.Diachi
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
							  k.Email,
							  k.NgaySinh,
							  k.GioiTinh,
							  k.SDT,
							  k.Diachi
                        INTO #Results2
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKhachHang like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results2; 
        END;
    END;

exec sp_khach_search 1,0,'',''
select * from KhachHang
go

create PROCEDURE [dbo].[sp_khach_update](@id int,
@TenKhachHang nvarchar(50),
@Email nvarchar(250),
@SDT nvarchar(50),
@NgaySInh nvarchar(50),
@GioiTinh nvarchar(50),
@DiaChi nvarchar(250))


AS
	BEGIN
		update KhachHang
		set 
			TenKhachHang = @TenKhachHang,
			Email = @Email,
			SDT = @SDT,
			NgaySinh = @NgaySinh,
			GioiTinh=@GioiTinh,
			DiaChi=@DiaChi
		where KhachHangID = @id
	END
	
	go

CREATE PROCEDURE [dbo].[sp_khach_delete]
    @id int
AS
BEGIN
    DELETE FROM [MIU].[dbo].[KhachHang]
    WHERE [KhachHangID] = @id;
END;
EXEC [dbo].[sp_khach_delete] @id = 1;
go


create PROCEDURE [dbo].[sp_sanpham_get_by_id](@SanPhamID int)
AS
    BEGIN
		DECLARE @MaLoaiSanPham int;
		set @MaLoaiSanPham = (select MaLoai from SanPham where SanPhamID = @SanPhamID);
        SELECT s.*, 
        (
            SELECT top 6 sp.*
            FROM SanPham AS sp
            WHERE sp.MaLoai = s.MaLoai FOR JSON PATH
        ) AS list_json_chitiethoadon

        FROM SanPham AS s
        WHERE  s.SanPhamID = @SanPhamID;
    END;
EXEC sp_sanpham_get_by_id @SanPhamID =2;

	go

create PROCEDURE [dbo].[sp_sanpham_create](
@MaLoai int,		
@TenSanPham nvarchar(250),
@GiaBan int,
@SoLuong int,
@IDNhaCC int)

AS
    BEGIN
       insert into SanPham(MaLoai,TenSanPham,GiaBan,SoLuong,IDNhaCC)
	   values(@MaLoai,@TenSanPham,@GiaBan,@SoLuong,@IDNhaCC);
    END;			

select * from SanPham
go

create PROCEDURE [dbo].[sp_sanpham_update](@SanPhamID int,
@MaLoai int,		
@TenSanPham nvarchar(250),
@GiaBan int,
@SoLuong int,
@IDNhaCC int
)
AS
	BEGIN
		update SanPham
		set 
			MaLoai = @MaLoai,
			TenSanPham = @TenSanPham,
			GiaBan = @GiaBan,
			SoLuong = @SoLuong,
			IDNhaCC = @IDNhaCC

		where SanPhamID = @SanPhamID
	END
	go
create PROCEDURE [dbo].[sp_sanpham_delete](@id int)
AS
    BEGIN
      delete from SanPham
      where SanPhamID = @id
    END;
	go

	
create PROCEDURE [dbo].[sp_sanpham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_sanpham Nvarchar(50),
									   @nhacc Nvarchar(250)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenSanPham ASC)) AS RowNumber, 
                              s.SanPhamID,
							  s.MaLoai,
							  s.TenSanPham,
							  s.GiaBan,
							  s.SoLuong,
							  s.IDNhaCC
							  
                        INTO #Results1
                        FROM SanPham AS s
					    WHERE  (@ten_sanpham = '' Or s.TenSanPham like N'%'+@ten_sanpham+'%') and						
						(@nhacc = '' Or s.IDNhaCC like N'%'+@nhacc+'%');                   
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
                              ORDER BY TenSanPham ASC)) AS RowNumber, 
                              s.SanPhamID,
							  s.MaLoai,
							  s.TenSanPham,
							  s.GiaBan,
							  s.SoLuong,
							  s.IDNhaCC
                        INTO #Results2
                        FROM SanPham AS s
					    WHERE  (@ten_sanpham = '' Or s.TenSanPham like N'%'+@ten_sanpham+'%') and						
						(@nhacc = '' Or s.IDNhaCC like N'%'+@nhacc+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results2; 
        END;
    END;
	exec sp_sanpham_search 1,0,'',''
go
create PROCEDURE [dbo].[sp_login](@tentaikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @tentaikhoan and MatKhau = @matkhau;
    END;
	exec sp_login 'minh1','123'
	go
	create PROCEDURE [dbo].[sp_taikhoan_get_by_id](@id int)
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TaiKhoanID = @id;
    END;
	go
	create PROCEDURE [dbo].[sp_taikhoan_create](
@TenTaiKhoan nvarchar(50),
@MatKhau nvarchar(50))
AS
    BEGIN
      insert into TaiKhoan(TenTaiKhoan,MatKhau)
	  values(@TenTaiKhoan,@MatKhau)
    END;
	go
	create PROCEDURE [dbo].[sp_taikhoan_delete](@id int)
AS
    BEGIN
      delete from TaiKhoan
      where TaiKhoanID =@id
    END;
	go
	create PROCEDURE [dbo].[sp_taikhoan_update](
@TaiKhoanID int,
@TenTaiKhoan nvarchar(50),
@MatKhau nvarchar(50)
)
AS
    BEGIN
      update TaiKhoan
	  set 
		TenTaiKhoan =@TenTaiKhoan,
		MatKhau =@MatKhau
      where TaiKhoanID = @TaiKhoanID;
    END;
	go