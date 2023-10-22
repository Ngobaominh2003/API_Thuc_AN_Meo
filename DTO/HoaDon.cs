namespace DTO
{
    public class HoaDon
    {
        public int HoaDonID { get; set; }
        public DateTime NgayLap { get; set; }
        public int NhanVienID { get; set; }
        public int KhachHangID { get; set; }
        public int LoaiHoaDonID { get; set; }
        public string TenSanPham { get; set; }
        public int SoLuong { get; set; }
        public int TongGia { get; set; }
        public List<ChiTietHoaDonBan> list_json_chitiethoadonban { get; set; }
    }
    public class ChiTietHoaDonBan
    {
        public int MaChiTietHoaDon { get; set; }
        public int HoaDonID { get; set; }
        public int SanPhamID { get; set; }
        public int KhachHangID { get; set; }
        public int SoLuong { get; set; }
        public int TongGia { get; set; }
        public int status { get; set; }
    }
}