using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace project1
{
    internal class Program
    {
        static void Main(string[] args)
        {

       
            Console.WriteLine("hello , what is your name?");

            string userName = Console.ReadLine();
            Console.WriteLine("name:" + userName);

            int age = 24;
               Convert.ToInt32(age);
            Console.WriteLine("age:"+age);

            double price = 34.5;

            Console.WriteLine("price:" +price);

            char grade = 'A';
            Console.WriteLine(" grade:" + grade);

            bool isLoggedIn = true;
            Console.WriteLine("  isLoggedIn:" + isLoggedIn);

            string Address = "jordan, ajloun";
            Console.WriteLine("Address:" + Address);

            double tempretaure = 25.3;
            Console.WriteLine("tempretaure :" + tempretaure);


            // سطر إضافي لإبقاء الشاشة مفتوحة
         
            Console.ReadKey();
        }
    }
}

