using BLL;
using DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Api.BanHang.Controllers
{
    [Route("api-admin/[controller]")]
    [ApiController]
    public class TaiKhoanController : ControllerBase
    {
        private ITaiKhoanBusiness _taikhoanBusiness;
        public TaiKhoanController(ITaiKhoanBusiness TaiKhoanBusiness)
        {
            _taikhoanBusiness = TaiKhoanBusiness;
        }
        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            var user = _taikhoanBusiness.Login(model.TaiKhoan, model.MatKhau);
            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không đúng!" });
            return Ok(new { taikhoan = user.TenTaiKhoan, matkhau = user.MatKhau, token = user.token });
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public TaiKhoan GetDatabyID(string id)
        {
            return _taikhoanBusiness.GetDatabyID(id);
        }
        [Route("create-TaiKhoan")]
        [HttpPost]
        public TaiKhoan CreateItem([FromBody] TaiKhoan model)
        {
            _taikhoanBusiness.Create(model);
            return model;
        }
        [Route("update-TaiKhoan")]
        [HttpPost]
        public TaiKhoan UpdateItem([FromBody] TaiKhoan model)
        {
            _taikhoanBusiness.Update(model);
            return model;
        }
        [Route("delete-TaiKhoan")]
        [HttpDelete]
        public TaiKhoan Deleteitem([FromBody] TaiKhoan model)
        {
            _taikhoanBusiness.Delete(model);
            return model;
        }
    }
}
