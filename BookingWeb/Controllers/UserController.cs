using BookingWeb.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BookingWeb.Core;

namespace BookingWeb.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        BookingEntities db = new BookingEntities();
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(NguoiDung taikhoan)
        {
            //return RedirectToAction("Index", "Home");
            string matKhau = Extension.GetMd5Hash(taikhoan.MatKhau);
            var account = db.NguoiDungs.FirstOrDefault(k => k.Email == taikhoan.Email && k.MatKhau == matKhau);
            if (account != null)
            {
                Session["TaiKhoan"] = account;
                return RedirectToAction("Index", "Home");
            }
            else
            {

                ViewBag.ThongBao = "Email hoặc mật khẩu không chính xác";
            }
            return View();
        }

    }
}