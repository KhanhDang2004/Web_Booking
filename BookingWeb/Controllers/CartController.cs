using BookingWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BookingWeb.Controllers
{
    public class CartController : Controller
    {
        BookingEntities1 db = new BookingEntities1();

        public ActionResult Index()
        {
            return View();
        }
      /*  public ActionResult CartPartial()
        {
            ViewBag.TotalNumber = GetTotalNumber();

            return PartialView();
        }*/
       /* private int GetTotalNumber()
        {
            int totalNumber = 0;
            List<CartItem> myCart = GetCart();
            if (myCart != null)
                totalNumber = myCart.Sum(sp => sp.SoLuong);
            return totalNumber;
        }*/
    }
}