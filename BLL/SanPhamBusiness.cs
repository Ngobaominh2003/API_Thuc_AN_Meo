using DAO;
using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SanPhamBusiness : ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }
        public SanPham GetDatabyID( int id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Create(SanPham model)
        {
            return _res.Create(model);
        }
        public bool Update(SanPham model)
        {
            return _res.Update(model);
        }
        public bool Delete(SanPham model)
        {
            return _res.Delete(model);
        }
        public List<SanPham> Search(int pageIndex, int pageSize, out long total, string ten_sanpham, string nhacc)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_sanpham, nhacc);
        }
    }
}
