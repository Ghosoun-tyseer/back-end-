using System;
using System.Collections.Generic;
using System.IO;

namespace ProductInventorySystem
{
   
    class Product
    {
        private string name;
        private decimal price;
        private int stock;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public decimal Price
        {
            get { return price; }
            set
            {
                // التأكد من أن السعر ليس سالباً
                if (value > 0) price = value;
                else Console.WriteLine("Price cannot be zero or negative.");
            }
        }

        public int Stock
        {
            get { return stock; }
            set
            {
                // التأكد من أن المخزون ليس سالباً
                if (value >= 0) stock = value;
                else Console.WriteLine("stock value must never go below zero.");
            }
        }

        public Product(string name, decimal price, int stock)
        {
            Name = name;
            Price = price;
            Stock = stock;
        }

        // تقليل المخزون عند البيع
        public void Sell(int quantity)
        {
            if (quantity <= stock)
            {
                stock -= quantity;
                Console.WriteLine($"{quantity} units of {name} sold.");
            }
            else
            {
                Console.WriteLine($"Insufficient stock for {name}!");
            }
        }

        // زيادة المخزون عند التوريد
        public void Restock(int quantity)
        {
            if (quantity > 0)
            {
                stock += quantity;
                Console.WriteLine($"{quantity} units added to {name} stock.");
            }
            
        }

        public string GetProductDetails()
        {
            return $"Name: {Name}, Price: {Price}, Stock: {Stock}";
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            string fileName = "products.txt";

            Product laptop = new Product("Laptop", 800, 10);
            Product smartphone = new Product("Smartphone", 500, 20);
            Product headphones = new Product("Headphones", 50, 50);


            laptop.Sell(2);          
            smartphone.Restock(5);   
            headphones.Sell(60);     // ستظهر رسالة "Insufficient stock"


            //  حفظ البيانات في الملف
            using (StreamWriter sw = new StreamWriter(fileName))
            {
                sw.WriteLine(laptop.GetProductDetails());
                sw.WriteLine(smartphone.GetProductDetails());
                sw.WriteLine(headphones.GetProductDetails());
            }
            Console.WriteLine("\nData saved to products.txt successfully.");


            // 5. قراءة البيانات من الملف  
            Console.WriteLine("\nReading Data from File");

            if (File.Exists(fileName))
            {
                // استخدام using للقراءة أيضاً بدلاً من ReadAllText لضمان إدارة الموارد
                using (StreamReader sr = new StreamReader(fileName))
                {
                    string line;
                    while ((line = sr.ReadLine()) != null)
                    {
                        Console.WriteLine(line);
                    }
                }
            }
            else
            {
                Console.WriteLine("Error:The file does not exist.");
            }

            Console.ReadKey();
        }
    }
}