using Microsoft.AspNetCore.Mvc;
using OYIL.Models;

namespace OYIL.Controllers
{
    public class UserController : Controller
    {
        private readonly MyDbContext _context;


        public UserController(MyDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult SignUp()
        {
            return View();
        }

        public IActionResult SignIn()
        {
            return View();
        }

    }
}
