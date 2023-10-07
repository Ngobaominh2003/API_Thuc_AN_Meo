using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class HoaDon
    {
        public int MaHoaDon { get; set; }
        public string TenKH { get; set; }
        public string Diachi { get; set; }
        public bool TrangThai { get; set; }
        public List<ChiTietHoaDon> list_json_chitiethoadon { get; set; }
    }
    public class ChiTietHoaDon
    {
        public int MaChiTietHoaDon { get; set; }
        public int MaHoaDon { get; set; }
        public int MaSanPham { get; set; }
        public int SoLuong { get; set; }
        public double TongGia { get; set; }
        public int status { get; set; }
    }
}
