using BLL;
using DAO;
using DTO;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Sockets;
using System.Security.Claims;
using System.Text;

namespace BLL
{
    public class TaiKhoanBusiness : ITaiKhoanBusiness
    {
        private ITaiKhoanRepository _res;
        private string secret;
        public TaiKhoanBusiness(ITaiKhoanRepository res, IConfiguration configuration)
        {
            _res = res;
            secret = configuration["AppSettings:Secret"];
        }

        public TaiKhoan Login(string tentaikhoan, string matkhau)
        {
            var user = _res.Login(tentaikhoan, matkhau);
            if (user == null)
                return null;
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.TenTaiKhoan.ToString()),
                    new Claim(ClaimTypes.Name, user.MatKhau.ToString()),

                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.Aes128CbcHmacSha256)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.token = tokenHandler.WriteToken(token);
            return user;
        }
        public TaiKhoan GetDatabyID(string id)
        {
            return _res.GetDatabyID(id);
        }
        public bool Create(TaiKhoan model)
        {
            return _res.Create(model);
        }
        public bool Update(TaiKhoan model)
        {
            return _res.Update(model);
        }
        public bool Delete(TaiKhoan model)
        {
            return _res.Delete(model);
        }
        public List<TaiKhoan> Search(int pageIndex, int pageSize, out long total, string tentaikhoan, string matkhau)
        {
            return _res.Search(pageIndex, pageSize, out total, tentaikhoan, matkhau);
        }
    }
}