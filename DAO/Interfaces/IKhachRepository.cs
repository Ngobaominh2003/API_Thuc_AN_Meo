using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public partial interface IKhachRepository
    {
        KhachHang GetDatabyID(string id);
        bool Create(KhachHang model);
        bool Update(KhachHang model);
        public List<KhachHang> Search(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi);
    }
}
