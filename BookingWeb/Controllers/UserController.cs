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
        BookingEntities1 db = new BookingEntities1();
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
        public ActionResult Login(KHACHHANG taikhoan)
        {
            //return RedirectToAction("Index", "Home");
            string matKhau = Extension.GetMd5Hash(taikhoan.MatKhau);
            var account = db.KHACHHANGs.FirstOrDefault(k => k.Email == taikhoan.Email && k.MatKhau == matKhau);
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
        [HttpGet]
        public ActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(KHACHHANG cus, string rePass)
        {
            if (ModelState.IsValid)
            {
                var checkEmail = db.KHACHHANGs.FirstOrDefault(c => c.Email == cus.Email);
                if (checkEmail != null)
                {
                    ViewBag.ThongBaoEmail = "Đã có tài khoản đăng nhập bằng Email này";
                    return View();
                }

                if (cus.MatKhau == rePass)
                {
                    cus.MatKhau = Extension.GetMd5Hash(cus.MatKhau);      
                        cus.NgayTao = DateTime.Now;
                        cus.TrangThai = true; 
                        db.KHACHHANGs.Add(cus);
                        db.SaveChanges();
                        return RedirectToAction("Login", "User");


                    

                }
                else
                {
                    ViewBag.ThongBao = "Mật khẩu xác nhận không chính xác";
                    return View(cus);
                }
            }
            return View(cus);
        }
            
            
    }
}