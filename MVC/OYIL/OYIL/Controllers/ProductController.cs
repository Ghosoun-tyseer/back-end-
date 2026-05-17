using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OYIL.Models;

namespace OYIL.Controllers
{
    public class ProductController : Controller
    {
        private readonly MyDbContext _context;


        public ProductController(MyDbContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            //استخدمنا Include هنا حتى نستطيع عرض اسم التصنيف مع المنتج داخل الـ View.
            var products = _context.Products.Include(p => p.Category).ToList();
            return View(products);
        }

        [HttpGet]
        public IActionResult Create()
        {
            ViewBag.Categories = _context.Categories.ToList();
            return View();
        }

        // POST: Category/Create
        [HttpPost]
        public IActionResult Create(Product product)
        {
            if (ModelState.IsValid)
            {
                _context.Products.Add(product);

                _context.SaveChanges();

                return RedirectToAction("Index");
            }
            //هذا السطر يرسل قائمة الـ Categories من الـ Controller إلى الـ View
            ViewBag.Categories = _context.Categories.ToList();

            return View(product);
        }



        [HttpGet]
        public IActionResult Edit(int id)
        {
            var product = _context.Products.Find(id);

            if (product == null)
            {
                return NotFound();
            }

            ViewBag.Categories = _context.Categories.ToList();

            return View(product);
        }


        [HttpPost]
        public IActionResult Edit(int id, Product product)
        {
            if (id != product.ProductId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                _context.Products.Update(product);

                _context.SaveChanges();

                return RedirectToAction("Index");
            }
            //إرسال قائمة Categories للـ Dropdown
            ViewBag.Categories = _context.Categories.ToList();

            return View(product);
        }



        [HttpGet]
        public IActionResult Delete(int id)
        {
            var product = _context.Products.Find(id);

            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        public IActionResult Delete(Product product)
        {
            var productInDb = _context.Products.Find(product.ProductId);

            if (productInDb == null)
            {
                return NotFound();
            }

            _context.Products.Remove(productInDb);

            _context.SaveChanges();

            return RedirectToAction("Index");
        }


        public IActionResult Details(int id)
        {
            var product = _context.Products
                .Include(p => p.Category)
                .FirstOrDefault(p => p.ProductId == id);

            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }
    }
}
