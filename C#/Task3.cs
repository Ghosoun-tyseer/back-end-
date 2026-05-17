using System;
using System.Collections.Generic;

namespace StudentManagementSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            //  Part 1: Student Names (List + Strings) 
            List<string> students = new List<string>();
            Console.WriteLine(" Part 1: Enter 5 Student Names ");
            for (int i = 0; i < 5; i++)
            {
                Console.Write($"Enter name for student {i}: ");
                string inputName = Console.ReadLine();
                // Trim, ToUpper, and Add to list
                students.Add(inputName.Trim().ToUpper());
            }

            // --- Part 2: Search Student (String Methods) 
         
            Console.Write("Enter name to search: ");
            string searchName = Console.ReadLine().Trim().ToUpper();

            if (students.Contains(searchName))
            {
                Console.WriteLine("Result: Student Found");
            }
            else
            {
                Console.WriteLine("Result: Student Not Found");
            }

            // Part 3: Remove Student (List) 
            
            Console.Write("Enter name to remove: ");
            string removeName = Console.ReadLine().Trim().ToUpper();

            if (students.Remove(removeName))
            {
                Console.WriteLine($"{removeName} has been removed.");
            }
            else
            {
                Console.WriteLine("Error: Name not found in the list.");
            }

            // Part 4: Sorting (List) 
 
            students.Sort();
            Console.WriteLine("Sorted Student List:");
            foreach (var name in students)
            {
                Console.WriteLine("- " + name);
            }

            // Part 5: Skills Processing (Split + Array)
           
            Console.Write("Enter skills (comma separated like C#,HTML,CSS): ");
            string skillsInput = Console.ReadLine();
            string[] skills = skillsInput.Split(',');

            Console.WriteLine("Individual Skills:");
            foreach (string skill in skills)
            {
                Console.WriteLine("-> " + skill.Trim());
            }

            // --- Part 6: Grades System (2D Array) ---
           
            int[,] grades = new int[3, 3]; // 3 Students, 3 Subjects

            for (int i = 0; i < 3; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    Console.Write($"Enter grade for Student {i}, Subject {j}: ");
                    grades[i, j] = Convert.ToInt32(Console.ReadLine());
                }
            }

            Console.WriteLine("\nAll Grades Matrix:");
            for (int i = 0; i < 3; i++)
            {
                for (int j = 0; j < 3; j++)
                {
                    Console.Write(grades[i, j] + "\t");
                }  
                Console.WriteLine();
            }

            // Modify one grade manually 
            Console.WriteLine("\nUpdating Student 1, Subject 1 grade to 100");
            grades[0, 0] = 100;

            //  Part 7: Jagged Array (Advanced) 
            Console.WriteLine("\n  Jagged Array :");
            int[][] exams = new int[3][];
            exams[0] = new int[] { 85, 90 };       // Student 1 
            exams[1] = new int[] { 70, 88, 92 };   // Student 2 
            exams[2] = new int[] { 95 };           // Student 3 

            for (int i = 0; i < exams.Length; i++)
            {
                Console.Write($"Student {i} Exam Scores: ");
                for (int j = 0; j < exams[i].Length; j++)
                {
                    Console.Write(exams[i][j] + " ");
                }
                Console.WriteLine();
            }

            //  Part 8: String Comparison 
         
            Console.Write("Enter admin password: ");
            string password = Console.ReadLine();

            if (string.Equals(password, "ADMIN123"))
            {
                Console.WriteLine("Access Granted");
            }
            else
            {
                Console.WriteLine("Access Denied");
            }

            Console.WriteLine("\nfinally Task Completed Successfully ");
            Console.ReadKey();
        }
    }
}