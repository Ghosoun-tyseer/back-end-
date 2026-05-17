-- ===============================
-- CREATE DATABASE
-- ===============================
CREATE DATABASE university_db;

USE university_db;

-- ===============================
-- 1. ONE-TO-ONE RELATIONSHIP
-- ===============================

-- Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Student Cards Table (One-to-One)
CREATE TABLE student_cards (
    card_id INT PRIMARY KEY,
    student_id INT UNIQUE, -- ensures one card per student
    issue_date DATE,
    
    -- foreign key
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Insert Students
INSERT INTO students VALUES (1, 'Ahmad');
INSERT INTO students VALUES (2, 'Sara');

-- Insert Cards
INSERT INTO student_cards VALUES (101, 1, '2025-01-01');
INSERT INTO student_cards VALUES (102, 2, '2025-02-01');

-- Query One-to-One
SELECT s.name, sc.card_id
FROM students s
JOIN student_cards sc 
ON s.student_id = sc.student_id;

-- ===============================
-- 2. ONE-TO-MANY RELATIONSHIP
-- ===============================

-- Assignments Table
CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY,
    title VARCHAR(100),
    student_id INT,
    
    -- foreign key
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Insert Assignments
INSERT INTO assignments VALUES (1, 'HTML Task', 1);
INSERT INTO assignments VALUES (2, 'CSS Task', 1);
INSERT INTO assignments VALUES (3, 'JS Task', 2);

-- Query One-to-Many
SELECT s.name, a.title
FROM students s
JOIN assignments a 
ON s.student_id = a.student_id;

-- ===============================
-- 3. MANY-TO-MANY RELATIONSHIP
-- ===============================

-- Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

-- Junction Table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,

    -- foreign keys
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert Courses
INSERT INTO courses VALUES (1, 'Database');
INSERT INTO courses VALUES (2, 'Web Development');

-- Insert Enrollments
INSERT INTO enrollments VALUES (1, 1, 1); -- ahmad -> database
INSERT INTO enrollments VALUES (2, 1, 2); -- ahmad -> web development
INSERT INTO enrollments VALUES (3, 2, 1); -- sara -> database

-- Query Many-to-Many
SELECT s.name, c.course_name
FROM students s
JOIN enrollments e 
    ON s.student_id = e.student_id
JOIN courses c 
    ON e.course_id = c.course_id;

-- ===============================
-- 4. ADVANCED QUERIES
-- ===============================

-- count courses per student
SELECT s.name, COUNT(e.course_id) AS total_courses
FROM students s
LEFT JOIN enrollments e 
    ON s.student_id = e.student_id
GROUP BY s.name;

-- students with more than one assignment
SELECT s.name
FROM students s
JOIN assignments a 
    ON s.student_id = a.student_id
GROUP BY s.name
HAVING COUNT(a.assignment_id) > 1;

-- students not enrolled in any course
SELECT s.name
FROM students s
LEFT JOIN enrollments e 
    ON s.student_id = e.student_id
WHERE e.student_id IS NULL;