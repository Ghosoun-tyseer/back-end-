using System;

namespace StudentSystem
{
    // 1. What is a class? 
    // A class is a blueprint or a template for creating objects. 
    // It defines data (fields) and behaviors (methods).
    // Example from this code: The 'Student' class.
    class Student
    {
        // Fields
        public string name;
        public int age;
        public double grade;

        // Constant
        public const string universityName = "Yarmouk University";

        // Static Member - shared by all instances
        public static int studentCount = 0;

        // Constructor: Runs every time a new student is created
        public Student(string n, int a, double g)
        {
           name = n;
            age = a;
            grade = g;

            // Increment the counter whenever a new object is instantiated
            studentCount++;
        }

        // Method: Display student details
        public void DisplayInfo()
        {
            Console.WriteLine($"University: {universityName}");
            Console.WriteLine($"Name: {name}, Age: {age}, Grade: {grade}");
        }

        // Method: Update grade
        public void UpdateGrade(double newGrade)
        {
            grade = newGrade;
            Console.WriteLine($"Grade updated for {name} to: {grade}");
        }

        // Method: Check if passed
        public bool IsPassed()
        {
            return grade >= 50;
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // 2. What is an object?
            // An object is an instance of a class created at runtime.
            // Example from this code: 's1', 's2', and 's3' are objects.

            // Creating 3 Objects
            Student s1 = new Student("Ghosoun", 20, 85.5);
            Student s2 = new Student("Sara", 22, 45.0);
            Student s3 = new Student("Omar", 21, 70.0);

            // Using Methods for Student 1
            s1.DisplayInfo();
            Console.WriteLine($"Status: {(s1.IsPassed() ? "Passed" : "Failed")}");
            Console.WriteLine();

            // Using Methods for Student 2
            s2.DisplayInfo();
            Console.WriteLine($"Status: {(s2.IsPassed() ? "Passed" : "Failed")}");
            s2.UpdateGrade(55.0); // Updating grade
            Console.WriteLine($"New Status: {(s2.IsPassed() ? "Passed" : "Failed")}");
            Console.WriteLine();

            // Using Methods for Student 3
            s3.DisplayInfo();
            Console.WriteLine($"Status: {(s3.IsPassed() ? "Passed" : "Failed")}");
            Console.WriteLine();

            // Display Total Student Count (Static Member)
            Console.WriteLine($"Total number of students created: {Student.studentCount}");
      
        
        //part2
        Console.WriteLine("  Even or Odd ");
            CheckEvenOdd(7);

            Console.WriteLine("\n2nd Smallest ");
            FindSecondSmallest(new int[] { 4, -3, 7, 2, 0 });

            Console.WriteLine("\n Factorial");
            CalculateFactorial(5);

            Console.WriteLine("\n Largest Number ");
            FindLargest(new int[] { 3, 1, 4, 1, 5, 9 });

            Console.WriteLine("\n Number Pattern");
            PrintNumberPattern(5);

            Console.WriteLine("\n Pyramid Pattern ");
            PrintPyramid(4);

            Console.WriteLine("\n Sum Even & Odd");
            SumEvenOdd(new int[] { 1, 2, 3, 4, 5, 6 });

            Console.WriteLine("\n Common Elements ");
            FindCommonElements(new int[] { 1, 2, 3, 4 }, new int[] { 3, 4, 5, 6 });

            Console.WriteLine("\n");
            
        }

        // 1. Even or Odd
        static void CheckEvenOdd(int num)
        {
            string result = (num % 2 == 0) ? "even" : "odd";
            Console.WriteLine($"The number {num} is {result}.");
        }

        // 2. 2nd Smallest
        static void FindSecondSmallest(int[] nums)
        {
            Array.Sort(nums);
            Console.WriteLine($"2nd smallest of {string.Join(", ", nums)} is: {nums[1]}");
        }

        // 3. Factorial
        static void CalculateFactorial(int n)
        {
            long fact = 1;
            for (int i = 1; i <= n; i++) {
                fact *= i;
            }
            Console.WriteLine($"Factorial of {n} is: {fact}");
        }

        // 5. Largest in Array
        static void FindLargest(int[] arr)
        {
            int max = arr[0];
            foreach (int val in arr)
            {
                if (val > max) max = val;
            }
            Console.WriteLine($"Largest number is: {max}");
        }

        // 6. Number Pattern
        static void PrintNumberPattern(int n)
        {
            int current = 1;
            for (int i = 1; i <= n; i++) //للاسطر
            {
                for (int j = 1; j <= i; j++) //لعدد القيم داخل السطر
                {
                    Console.Write(current + " ");
                    current++;
                }
                Console.WriteLine();
            }
        }

        // 7. Pyramid Pattern (Optional)
        static void PrintPyramid(int n)
        {
            for (int i = 1; i <= n; i++)
            {
                for (int j = 1; j <= n - i; j++) Console.Write(" ");
                for (int k = 1; k <= (2 * i - 1); k++) Console.Write("*");
                Console.WriteLine();
            }
        }

        // 8. Sum of Even and Odd (Optional)
        static void SumEvenOdd(int[] arr)
        {
            int evenSum = 0, oddSum = 0;
            foreach (int n in arr)
            {
                if (n % 2 == 0) evenSum += n;
                else oddSum += n;
            }
            Console.WriteLine($"Sum of Even: {evenSum}, Sum of Odd: {oddSum}");
        }

        // 9. Common Elements (Optional)
        static void FindCommonElements(int[] arr1, int[] arr2)
        {
            Console.Write("Common elements: ");
            foreach (int a in arr1)
            {
                foreach (int b in arr2)
                {
                    if (a == b) Console.Write(a + " ");
                }
            }
            Console.WriteLine();
            Console.ReadKey();


        }
    }
}