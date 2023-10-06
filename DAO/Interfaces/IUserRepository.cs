using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public partial interface IUserRepository
    {
        TaiKhoan Login(string taikhoan, string matkhau);
    }
}
