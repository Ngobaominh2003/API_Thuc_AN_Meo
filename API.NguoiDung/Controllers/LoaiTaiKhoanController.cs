using BLL;
using DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.BanHang.Controllers
{
    [Route("api-admin/[controller]")]
    [ApiController]
    public class LoaiSanPhamController : ControllerBase
    {
        private ILoaiSanPhamBusiness _loaisanphamBusiness;
        public LoaiSanPhamController(ILoaiSanPhamBusiness loaisanphamBusiness)
        {
            _loaisanphamBusiness = loaisanphamBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public LoaiSanPham GetDatabyID(int id)
        {
            return _loaisanphamBusiness.GetDatabyID(id);
        }
        [Route("create-loaisach")]
        [HttpPost]
        public LoaiSanPham CreateItem([FromBody] LoaiSanPham model)
        {
            _loaisanphamBusiness.Create(model);
            return model;
        }
        [Route("update-loaisach")]
        [HttpPost]
        public LoaiSanPham UpdateItem([FromBody] LoaiSanPham model)
        {
            _loaisanphamBusiness.Update(model);
            return model;
        }
        [Route("delete-loaisach")]
        [HttpDelete]
        public LoaiSanPham DeleteItem([FromBody] LoaiSanPham model)
        {
            _loaisanphamBusiness.Delete(model);
            return model;
        }
        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page_index = int.Parse(formData["page"].ToString());
                var page_size = int.Parse(formData["pageSize"].ToString());
                string ten_loai = "";
                if (formData.Keys.Contains("ten_khach") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_khach"]))) { ten_loai = Convert.ToString(formData["ten_khach"]); }
                
                long total = 0;
                var data = _loaisanphamBusiness.Search(page_index, page_size, out total, ten_loai);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page_index,
                        PageSize = page_size
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
