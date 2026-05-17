using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OYIL.Models;

namespace OYIL.Controllers
{


    public class CategoryController : Controller
    {
        private readonly MyDbContext _context;


        public CategoryController(MyDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {

            var categories = _context.Categories.ToList();
            return View(categories);

            
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Category/Create
        [HttpPost]
        public IActionResult Create(Category category)
        {
            if (ModelState.IsValid)
            {
                _context.Categories.Add(category);
                _context.SaveChanges(); //important to save in db 
                return RedirectToAction("Index");
            }
            return View(category);
        }


        public IActionResult Edit(int id)
        {
            // find -> primary key 
            //fisOrDefault -> any column finds the first one  (multiple records with the same value)
            //singleOrDefaul-> only one record or default (similar to distinct)
            var category = _context.Categories.Find(id);
            if (category == null)
                return NotFound();

            return View(category);
        }

        [HttpPost]
        public IActionResult Edit(int id, Category category)
        {
            if (id != category.CategoryId)
                return NotFound();

            if (ModelState.IsValid)
            {
                _context.Update(category);
                _context.SaveChanges();


                return RedirectToAction("Index");
            }
            return View(category);
        }
        [HttpGet]
        public IActionResult Delete(int CategoryId)
        {
            var category = _context.Categories.Find(CategoryId);

            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }

        [HttpPost]
        public IActionResult Delete(Category category)
        {
            var categoryInDb = _context.Categories.Find(category.CategoryId);

            if (categoryInDb == null)
            {
                return NotFound();
            }

            _context.Categories.Remove(categoryInDb);

            _context.SaveChanges();

            return RedirectToAction("Index");
        }

        public IActionResult ProductsByCategory(int id)
        {
            var category = _context.Categories
                .Include(c => c.Products)
                .FirstOrDefault(c => c.CategoryId == id);

            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }
    


}
}
