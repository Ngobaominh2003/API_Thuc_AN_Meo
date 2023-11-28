using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public partial interface ISanPhamBusiness
    {
        SanPham GetDatabyID(int  id);
        bool Create(SanPham model);
        bool Update(SanPham model);
        bool Delete(SanPham model);
        public List<SanPham> Search(int pageIndex, int pageSize, out long total, string ten_sanpham, string nhacc);
    }
}
