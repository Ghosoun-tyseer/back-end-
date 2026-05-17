using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace task2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //Q1
        
            string[] fruits = { "Apple", "Banana", "Mango", "Orange", "Pineapple" };

            for (int i = 0; i < fruits.Length; i++)
            {
                Console.WriteLine($"Fruit at index {i}: {fruits[i]}");
            }

     
            Console.WriteLine($"Total number of fruits: {fruits.Length}");


            //Q2
            int[] numbers = new int[5];

            Console.WriteLine("Input 5 numbers into the array:");

            
            for (int i = 0; i < numbers.Length; i++)
            {
                Console.Write($"Number at index {i}: ");
                numbers[i] = Convert.ToInt32(Console.ReadLine());
            }

            Console.WriteLine(); // سطر فارغ

            // 3. طباعة المصفوفة الأصلية
            Console.Write("Original array: ");
            foreach (int num in numbers)
            {
                Console.Write(num + " ");
            }

            Console.WriteLine();

            // 4. عكس المصفوفة (Reversing)
            // نستخدم حلقة تبدأ من النهاية إلى البداية لطباعة العناصر بشكل معكوس
            Console.Write("Reversed array: ");
            for (int i = numbers.Length - 1; i >= 0; i--)
            {
                Console.Write(numbers[i] + " ");
            }

            //Q3

            string[] colors = { "Red", "Blue", "Green", "rose", "Yellow", "Ruby" };

            int count = 0;
            string matchedColors = "";

           
            foreach (string color in colors)
            {
                if (color[0] == 'R' || color[0] == 'r')
                {
                 
                    if (count > 0)
                    {
                        matchedColors += ", ";
                    }

                    matchedColors += color;
                    count++; // زيادة العداد
                }
            }

            // 3. طباعة النتائج
            Console.WriteLine();

            Console.WriteLine($"Colors starting with 'R': {matchedColors}");
            Console.WriteLine($"Total count: {count}");




            //Q4
            int[] numbersArray = new int[6];
            double sum = 0;

            Console.WriteLine("Input 6 numbers into the array:");

            // 1. إدخال البيانات وحساب المجموع
            for (int i = 0; i < numbersArray.Length; i++)
            {
                Console.Write($"Number at index {i}: ");
                numbersArray[i] = Convert.ToInt32(Console.ReadLine());
                sum += numbersArray[i];
            }

            // 2. منطق إيجاد Min و Max يدوياً باستخدام المقارنات
            // نفترض أن أول عنصر في numbersArray هو الأصغر والأكبر كبداية
            int min = numbersArray[0];
            int max = numbersArray[0];

            // نبدأ اللوب من العنصر الثاني لمقارنته بالبقية
            for (int i = 1; i < numbersArray.Length; i++)
            {
                // إذا وجدنا رقم أكبر من القيمة المخزنة في max، نقوم بتحديثها
                if (numbersArray[i] > max)
                {
                    max = numbersArray[i];
                }

                // إذا وجدنا رقم أصغر من القيمة المخزنة في min، نقوم بتحديثها
                if (numbersArray[i] < min)
                {
                    min = numbersArray[i];
                }
            }

            // 3. الترتيب (لأغراض العرض فقط)
            Array.Sort(numbersArray);

            // 4. حساب المتوسط والمخرجات النهائية
            double average = sum / numbersArray.Length;

            Console.WriteLine("\n----------------------------");
            Console.WriteLine($"Sum of elements: {sum}");
            Console.WriteLine($"Average of elements: {average}");
            Console.WriteLine($"Min : {min}");
            Console.WriteLine($"Max : {max}");

            // طباعة العناصر بعد ترتيبها
            Console.WriteLine($"Sort : {string.Join(",", numbersArray)}");


            Console.ReadKey();
        }


    }
}
