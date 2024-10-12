using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BookingWeb.Models
{
    public class CartItem
    {
        BookingEntities1 db = new BookingEntities1();
        public int MaSanPham { get; set; }
        public string TenSanPham { get; set; }
        public string Anh { get; set; }
        public decimal Gia { get; set; }
        public int SoLuong { get; set; }


        public decimal FinalPrice()
        {
            return SoLuong * Gia;
        }
        public CartItem(int MaKhachSan)
        {
            this.MaSanPham = MaSanPham;
            var productDB = db.KHACHSANs.Single(s => s.MaKhachSan == this.MaSanPham);
            this.TenSanPham = productDB.TenKhachSan;
            this.Anh = productDB.MoTa;

            /*this.SoLuong = 1;*/
        }
    }
}
