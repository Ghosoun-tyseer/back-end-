using Microsoft.AspNetCore.Mvc;

namespace mvc1.Controllers
{
    public class UserController : Controller
    {
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

  

        [HttpPost]
        public IActionResult Register(IFormCollection form)
        {
            // Get data from form

            string name = form["Name"];
            string email = form["Email"];
            string password = form["Password"];
            string confirmPassword = form["ConfirmPassword"];

            // Check password match

            if (password != confirmPassword)
            {
                ViewBag.Error = "Password does not match";

                return View();
            }

            // Save data using TempData

            TempData["Email"] = email;
            TempData["Password"] = password;
            TempData["Name"] = name;

            // Redirect to Login page

            return RedirectToAction("Login");
        }

        // Login GET
    

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        
        // Login POST
   

        [HttpPost]
        public IActionResult Login(IFormCollection form)
        {
            // Get login data

            string email = form["Email"];
            string password = form["Password"];

            // Get registered data from TempData

            string savedEmail = TempData["Email"]?.ToString();
            string savedPassword = TempData["Password"]?.ToString();

            // Keep TempData after reading

            TempData.Keep();

            // Check email and password

            if (email == savedEmail && password == savedPassword)
            {
                return RedirectToAction("Index");
            }

            // Error message

            ViewBag.Error = "Invalid Email or Password";

            return View();
        }


        public IActionResult Index()
        {
            return View();
        }

        public ActionResult SignIn()
        {
            return View();
        }

        public ActionResult SignUp()
        {
            return View();
        }

       
        public ActionResult Profile()
        {
            return View();
        }

        public ActionResult Room()
        {
            return View();
        }
    }
}
