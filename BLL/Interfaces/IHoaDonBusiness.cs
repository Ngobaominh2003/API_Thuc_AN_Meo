using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial interface IHoaDonBusiness
    {
        HoaDon GetDatabyID(int id);
        bool Create(HoaDon model);
        bool Update(HoaDon model);
        public List<ThongKeKhach> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
