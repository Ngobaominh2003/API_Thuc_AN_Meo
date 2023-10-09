using BLL;
using DAO;
using DTO;

namespace BLL
{
    public class KhachBusiness : IKhachBusiness
    {
        private IKhachRepository _res;
        public KhachBusiness(IKhachRepository res)
        {
            _res = res;
        }
        public KhachHang GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Create(KhachHang model)
        {
            return _res.Create(model);
        }
        public bool Update(KhachHang model)
        {
            return _res.Update(model);
        }
        public List<KhachHang> Search(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_khach, dia_chi);
        }
    }
}