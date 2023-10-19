using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class HoaDon
    {

        public int HoaDonID { get; set; }
        public int KhachHangID { get; set; }
        public DateTime NgayTao { get; set; }
        public int LoaiHoaDonID { get; set; }
        
        public List<ChiTietHoaDonBan> list_json_chitiethoadonban { get; set; }
    }
    public class ChiTietHoaDonBan
    {
        public int ChiTietHoaDonID { get; set; }
        public int HoaDonID { get; set; }
        public int SanPhamID { get; set; }
        public int SoLuong { get; set; }
        public decimal GiaBan { get; set; }
        public int status { get; set; }
    }
}
