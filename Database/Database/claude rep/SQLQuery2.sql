-- ===============================================
-- Example: students and courses JOINs
-- ===============================================
CREATE DATABASE students_database;

USE students_database;

-- 1. إنشاء جدول الطلاب
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- 2. إدخال بيانات الطلاب
INSERT INTO students (student_id, student_name) VALUES
(1, 'Ali'),
(2, 'Sara'),
(3, 'Omar'),
(4, 'Lina');

-- 3. إنشاء جدول الدورات
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50)
);

-- 4. إدخال بيانات الدورات
INSERT INTO courses (course_id, student_id, course_name) VALUES
(101, 1, 'Math'),
(102, 2, 'Science'),
(103, 2, 'English'),
(104, 5, 'History');

-- ===============================================
-- INNER JOIN: فقط الطلاب الذين لديهم دورة
-- ===============================================
SELECT students.student_name, courses.course_name
FROM students
INNER JOIN courses ON students.student_id = courses.student_id;

-- ===============================================
-- LEFT JOIN: كل الطلاب + الدورات إذا موجودة
-- ===============================================
SELECT students.student_name, courses.course_name
FROM students
LEFT JOIN courses ON students.student_id = courses.student_id;

-- ===============================================
-- RIGHT JOIN: كل الدورات + اسم الطالب إذا موجود
-- ===============================================
SELECT students.student_name, courses.course_name
FROM students
RIGHT JOIN courses ON students.student_id = courses.student_id;

-- ===============================================
-- FULL OUTER JOIN: كل الطلاب وكل الدورات
-- ===============================================
SELECT students.student_name, courses.course_name
FROM students
FULL OUTER JOIN courses ON students.student_id = courses.student_id;