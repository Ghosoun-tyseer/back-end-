-- ===============================================
-- Example: Company Database with Multiple Relations
-- ===============================================

CREATE DATABASE company_database;
USE company_database;


-- 1:1 Relationship: Employees ↔ Offices

CREATE TABLE offices (
    office_id INT PRIMARY KEY,
    office_number VARCHAR(10)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    office_id INT UNIQUE -- كل موظف له مكتب واحد فقط
);

-- إدخال بيانات المكاتب
INSERT INTO offices (office_id, office_number) VALUES
(1, 'A101'),
(2, 'B202'),
(3, 'C303');

-- إدخال بيانات الموظفين
INSERT INTO employees (employee_id, employee_name, office_id) VALUES
(1, 'John', 1),
(2, 'Alice', 2),
(3, 'Bob', 3);


-- 1:N Relationship: Departments ↔ Employees


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- إدخال بيانات الأقسام
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- إضافة عمود department_id للموظفين بعد إنشاء الجدول (يسمح بالقيم NULL مؤقتًا)
ALTER TABLE employees
ADD department_id INT NULL;

-- تحديث الموظفين لتعيين الأقسام
UPDATE employees SET department_id = 1 WHERE employee_id = 1; -- John -> HR
UPDATE employees SET department_id = 2 WHERE employee_id = 2; -- Alice -> IT
UPDATE employees SET department_id = 2 WHERE employee_id = 3; -- Bob -> IT

-- بعد تحديث البيانات، يمكن تعديل العمود ليصبح NOT NULL إذا أردنا فرض أن كل موظف له قسم
-- ALTER TABLE employees
-- MODIFY department_id INT NOT NULL;
select * from employees;
-- ============================
-- M:N Relationship: Employees ↔ Projects
-- ============================
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50)
);

-- جدول وسيط لتسجيل الموظفين في المشاريع
CREATE TABLE assignments (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id)
);

-- إدخال بيانات المشاريع
INSERT INTO projects (project_id, project_name) VALUES
(101, 'Website Redesign'),
(102, 'Payroll System'),
(103, 'Mobile App');

-- تسجيل الموظفين في المشاريع
INSERT INTO assignments (employee_id, project_id) VALUES
(1, 101), -- John -> Website Redesign
(2, 101), -- Alice -> Website Redesign
(2, 102), -- Alice -> Payroll System
(3, 103); -- Bob -> Mobile App

-- ============================
-- عرض البيانات باستخدام INNER JOIN فقط
-- ============================

-- مثال 1: الموظف ومكتبه
SELECT e.employee_name, o.office_number
FROM employees e
INNER JOIN offices o ON e.office_id = o.office_id;


-- إضافة موظفين جدد للأقسام المختلفة

-- إضافة موظفين جدد للأقسام المختلفة مع office_id غير مستخدمة
INSERT INTO employees (employee_id, employee_name, office_id, department_id)
VALUES
(4, 'Lina', 4, 1),  -- HR
(5, 'Tom', 5, 1),   -- HR
(6, 'Eva', 6, 2),   -- IT
(7, 'Mike', 7, 2),  -- IT
(8, 'Sophia', 8, 3),-- Finance
(9, 'David', 9, 3); -- Finance

-- مثال 2: عرض الأقسام وكل الموظفين فيها (1:N)
SELECT d.department_name, e.employee_name
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
ORDER BY d.department_name;

-- مثال 3: الموظف والمشاريع (M:N عبر جدول وسيط)
SELECT e.employee_name, p.project_name
FROM employees e
INNER JOIN assignments a ON e.employee_id = a.employee_id
INNER JOIN projects p ON a.project_id = p.project_id;


drop database company_database;