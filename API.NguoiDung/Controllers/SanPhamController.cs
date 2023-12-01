using BLL;
using DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BanHang.Controllers
{
    [Route("api-admin/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamController(ISanPhamBusiness sanphamBusiness)
        {
            _sanphamBusiness = sanphamBusiness;
        }
        [Route("get-by-id/{id}")]
        [HttpGet]
        public SanPham GetDatabyID(int id)
        {
            return _sanphamBusiness.GetDatabyID(id);
        }
        //[Route("create-sanpham")]
        //[HttpPost]
        //public SanPham CreateItem([FromBody] SanPham model)
        //{
        //    _sanphamBusiness.Create(model);
        //    return model;
        //}
        //[Route("update-sanpham")]
        //[HttpPost]
        //public SanPham UpdateItem([FromBody] SanPham model)
        //{
        //    _sanphamBusiness.Update(model);
        //    return model;
        //}
        //[Route("danhmuc")]
        //[HttpGet]
        //public SanPham Item([FromBody] SanPham model)
        //{
        //    _sanphamBusiness.Update(model);
        //    return model;
        //}
        //[Route("delete-sanpham")]
        //[HttpDelete]
        //public SanPham Deleteitem([FromBody] SanPham model)
        //{
        //    _sanphamBusiness.Delete(model);
        //    return model;
        //}
        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page_index = int.Parse(formData["page"].ToString());
                var page_size = int.Parse(formData["pageSize"].ToString());
                string ten_sanpham = "";
                if (formData.Keys.Contains("ten_sanpham") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_sanpham"]))) { ten_sanpham = Convert.ToString(formData["ten_sanpham"]); }
                string gia_ban = "";
                if (formData.Keys.Contains("gia_ban") && !string.IsNullOrEmpty(Convert.ToString(formData["gia_ban"]))) { gia_ban = Convert.ToString(formData["gia_ban"]); }
                long total = 0;
                var data = _sanphamBusiness.Search(page_index, page_size, out total, ten_sanpham, gia_ban);
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
