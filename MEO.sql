use MEO
go


alter  PROCEDURE [dbo].[sp_hoadon_get_by_id](@HoaDonID        int)
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
go

alter  PROCEDURE [dbo].[sp_hoadon_create]
(@KhachHangID              int, 
 @NgayTao          DATE, 
 @LoaiHoaDonID         int,  
 @list_json_chitiethoadonban NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @HoaDonID INT;
        INSERT INTO HoaDon
                (KhachHangID, 
                 NgayTao, 
                 LoaiHoaDonID               
                )
                VALUES
                (@KhachHangID , 
                 @NgayTao  , 
                 @LoaiHoaDonID
                );

				SET @HoaDonID = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadonban IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDonBan
						 (SanPhamID, 
						  HoaDonID,
                          SoLuong, 
                          GiaBan               
                        )
                    SELECT JSON_VALUE(p.value, '$.SanPhamID'), 
                            @HoaDonID, 
                            JSON_VALUE(p.value, '$.SoLuong'), 
                            JSON_VALUE(p.value, '$.GiaBan')    
                    FROM OPENJSON(@list_json_chitiethoadonban) AS p;
                END;
        SELECT '';
    END;
	go

	alter PROCEDURE [dbo].[sp_hoa_don_update]
(@HoaDonID        int, 
 @KhachHangID       int, 
 @NgayTao         DATE, 
 @LoaiHoaDonID int,  
 @list_json_chitiethoadonban NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDon
		SET
			KhachHangID = @KhachHangID ,
			NgayTao = @NgayTao,
			LoaiHoaDonID = @LoaiHoaDonID
		WHERE @HoaDonID = @HoaDonID;
		
		IF(@list_json_chitiethoadonban IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.ChiTietHoaDonBanID') as ChiTietHoaDonBanID,
			  JSON_VALUE(p.value, '$.HoaDonID') as HoaDonID,
			  JSON_VALUE(p.value, '$.SanPhamID') as SanPhamID,
			  JSON_VALUE(p.value, '$.SoLuong') as SoLuong,
			  JSON_VALUE(p.value, '$.GiaBan') as GiaBan,
			  JSON_VALUE(p.value, '$.status') AS status 
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadonban) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDonBan (SanPhamID, 
						  HoaDonID,
                          SoLuong, 
                         GiaBan ) 
			   SELECT
				  #Results.SanPhamID,
				  @HoaDonID,
				  #Results.SoLuong,
				  #Results.GiaBan			 
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDonBan 
			  SET
				 SoLuong = #Results.soLuong,
				 GiaBan = #Results.GiaBan
			  FROM #Results 
			  WHERE  ChiTietHoaDonBan.ChiTietHoaDonBanID = #Results.ChiTietHoaDonBanID  AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDonBan C
			INNER JOIN #Results R
				ON C.ChiTietHoaDonBanID=R.ChiTietHoaDonBanID
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;

	
GO
