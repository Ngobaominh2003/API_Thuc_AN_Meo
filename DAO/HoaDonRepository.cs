
using DTO;

namespace DAO
{
    public class HoaDonRepository : IHoaDonRepository
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public HoaDon GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_hoadon_get_by_id",
                     "@HoaDonID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HoaDon>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(HoaDon model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadon_create",
                "@KhachhangID", model.KhachHangID,
                "@NgayTao", model.NgayTao,
                "@LoaiHoaDonID", model.LoaiHoaDonID,
              
                "@list_json_chitiethoadon", model.list_json_chitiethoadonban != null ? MessageConvert.SerializeObject(model.list_json_chitiethoadonban) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Update(HoaDon model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_update",
                "@HoaDonID", model.HoaDonID,
                "@KhachHangID", model.KhachHangID,
                "@NgayTao", model.NgayTao,
                "@LoaiHoaDonID",model.LoaiHoaDonID,
               
                "@list_json_chitiethoadon", model.list_json_chitiethoadonban != null ? MessageConvert.SerializeObject(model.list_json_chitiethoadonban) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ThongKeKhach> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thong_ke_khach",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_khach", ten_khach,
                    "@fr_NgayTao", fr_NgayTao,
                    "@to_NgayTao", to_NgayTao
                );

                if (!string.IsNullOrEmpty(msgError))
                {
                    // Handle the error message here, e.g., log it or take appropriate action.
                    // You can also return an error response or throw a specific exception if needed.
                    throw new Exception(msgError);
                }

                if (dt.Rows.Count > 0)
                {
                    total = (long)dt.Rows[0]["RecordCount"];
                }

                return dt.ConvertTo<ThongKeKhach>().ToList();
            }
            catch (Exception ex)
            {
                // Handle the exception appropriately, e.g., log it, return an error response, or rethrow it.
                throw ex;
            }

        }
    }
}
