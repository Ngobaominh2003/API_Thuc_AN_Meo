using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public partial interface ITaiKhoanRepository
    {
        TaiKhoan Login(string tentaikhoan, string matkhau);
        TaiKhoan GetDatabyID(string id);
        bool Create(TaiKhoan model);
        bool Update(TaiKhoan model);
        bool Delete(TaiKhoan model);
        public List<TaiKhoan> Search(int pageIndex, int pageSize, out long total, string tentaikhoan, string matkhau);
    }
}
