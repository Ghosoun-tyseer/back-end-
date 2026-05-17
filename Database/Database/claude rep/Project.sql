
CREATE DATABASE library_database;


USE library_database;


CREATE TABLE categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(100) NOT NULL UNIQUE,
    category_description NVARCHAR(255)
);
--------------------------------------------------------------

CREATE TABLE books (
    book_id INT PRIMARY KEY IDENTITY(1,1),
    book_title NVARCHAR(200) NOT NULL,
    author NVARCHAR(100) NOT NULL,
    genre NVARCHAR(100),
    publication_year DATE ,
    availability_status NVARCHAR(100),
    category_id INT NOT NULL,
    
    CHECK (availability_status IN ('Available', 'Borrowed')),

    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE
);

-------------------------------------------------------------------------

CREATE TABLE members (
    member_id INT PRIMARY KEY IDENTITY(1,1),
    member_name NVARCHAR(100) NOT NULL,
    contact_info NVARCHAR(50) NOT NULL,
    membership_type VARCHAR(20) NOT NULL,
    registration_date DATE NOT NULL DEFAULT GETDATE(),
    CHECK (membership_type IN ('Student', 'Teacher', 'Visitor'))
);

----------------------------------------------------------------------
CREATE TABLE library_staff (
    staff_id INT PRIMARY KEY IDENTITY(1,1),
    staff_name NVARCHAR(100) NOT NULL,
    contact_information NVARCHAR(50),
    assigned_section NVARCHAR(100),
    employment_date DATE
);

---------------------------------------------------------------------------------

CREATE TABLE member_book ( --JUNCTION TABLE
    member_book_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrowing_date DATE NOT NULL ,
    due_date DATE NOT NULL,
    return_date DATE NULL ,

    CHECK (due_date >= borrowing_date),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
   
);

------------------------------------------------------------------------------------------------------
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATE DEFAULT GETDATE(),
    status VARCHAR(20) ,
    CHECK (status IN ('Pending', 'Cancelled', 'Completed')),

    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,

    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

------------------------------------------------------------------------------

CREATE TABLE financial_fines (
    fine_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20) ,
    CHECK (payment_status IN ('Paid', 'Unpaid')),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
-------------------------------------------------------------------------------

---insert 


INSERT INTO categories (category_name, category_description) VALUES
('Programming','Programming books'),
('Database', 'Database books'),
('Science Fiction', 'Science fiction'),
('History', 'Historical books'),
('Mathematics', 'Mathematics books');


INSERT INTO books (book_title, author, genre, publication_year, availability_status, category_id) VALUES
('Database Fundamentals', 'John Smith', 'Education', '2020-01-01', 'Available', 2),
('SQL for Beginners', 'Alice Brown', 'Education', '2021-01-01', 'Borrowed', 2),
('C# Programming', 'Mark Lee', 'Programming', '2019-01-01', 'Available', 1),
('Future World', 'Tom Hardy', 'Sci-Fi', '2018-01-01', 'Available', 3),
('Algebra Basics', 'David Kim', 'Math', '2017-01-01', 'Available', 5);


INSERT INTO members (member_name, contact_info, membership_type, registration_date) VALUES
('ghosoun tyseer', '1234567890', 'Student', '2025-01-01'),
('malek tyseer', '1112223333', 'Teacher', '2024-05-10'),
('rana ahmed', '9998887777', 'Visitor', '2024-01-05'),
('mousa khaled', '5556667777', 'Student', '2024-01-08'),
('sara mazen', '4445556666', 'Teacher', '2023-12-01');


INSERT INTO library_staff (staff_name, contact_information, assigned_section, employment_date) VALUES
('Omar', '777888999', 'IT', '2020-01-01'),
('Mona', '222333444', 'Books', '2019-03-10'),
('Yousef', '555111222', 'Support', '2021-06-15'),
('Rania', '888777666', 'Archives', '2018-07-20'),
('Hani', '999000111', 'Front Desk', '2022-09-01');


INSERT INTO member_book (member_id, book_id, borrowing_date, due_date, return_date) VALUES
(1, 2, '2024-01-01', '2024-01-05', '2024-01-07'), -- late
(2, 3, '2024-01-02', '2024-01-06', '2024-01-05'),
(3, 2, '2024-01-03', '2024-01-07', NULL),
(4, 3, '2024-01-04', '2024-01-08', '2024-01-08'),
(1, 4, '2024-02-07', '2024-02-14', '2024-02-16'); -- late


INSERT INTO reservations (member_id, book_id, reservation_date, status) VALUES
(1, 1, '2026-01-05', 'Pending'),
(2, 2, '2026-01-18', 'Completed'),
(3, 3, '2026-02-03', 'Cancelled'),
(1, 3, '2026-03-10', 'Completed'),
(4, 2, '2026-04-01', 'Pending');


INSERT INTO financial_fines (member_id, amount, payment_status) VALUES
(1, 2.00, 'Unpaid'),
(2, 1.00, 'Paid'),
(3, 3.50, 'Unpaid'),
(4, 0.75, 'Paid'),
(5, 4.00, 'Unpaid');


------------------------------------------
--Queries:

--Q1:Retrieve members who registered on a specific date (01-01-2025).
SELECT member_name
FROM members
WHERE registration_date = '2025-01-01';


--Q2:Retrieve all details of the book titled "Database Fundamentals". 
SELECT *
FROM books
WHERE book_title = 'Database Fundamentals';

--Q3:Add a new column called Email to the Members table with an appropriate data type.
ALTER TABLE members
ADD email VARCHAR(100);

select * from members;

--Q4:Insert a new member with the following details: 
--Name: Omar 
--Contact: 9876543210 
--Membership Type: Student 
--Registration Date: 05-06-2024 
--Email: Omar@gmail.com 

INSERT INTO members (member_name, contact_info, membership_type, registration_date, email)
VALUES ('Omar', '9876543210', 'Student', '2024-06-05', 'Omar@gmail.com');
select * from members;

--Q5:• Retrieve all members who have made reservations. 
SELECT DISTINCT m.*  --* لوحدها تعيد كل معلومات الجدولين
FROM members m
JOIN reservations r ON m.member_id = r.member_id; 
-- DISTINCT:تعيد 4 صفوف لان هناك عضو مكرر لديه حجزين 


--Q6:• Retrieve members who borrowed the book titled "SQL for Beginners". 

SELECT DISTINCT m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
JOIN books b ON mb.book_id = b.book_id
WHERE b.book_title = 'SQL for Beginners';  

--Q7:Retrieve members who borrowed and returned the book titled "C# Programming". 
SELECT DISTINCT m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
JOIN books b ON mb.book_id = b.book_id
WHERE b.book_title = 'C# Programming' --id=3
AND mb.return_date IS NOT NULL;

SELECT * FROM member_book;

INSERT INTO members (member_name, contact_info, membership_type, registration_date, email)
VALUES ('Hassan', '777123456', 'Student', '2026-04-14', 'hassan@gmail.com');

INSERT INTO member_book (member_id, book_id, borrowing_date, due_date, return_date)
VALUES (6, 3, '2026-04-14', '2026-04-20', NULL);


--Q8:Find members who returned books after their due date. 
SELECT DISTINCT m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
WHERE mb.return_date > mb.due_date;

--Q9:Identify books that were borrowed more than 3 times. 
SELECT b.book_title, COUNT(*) AS borrow_count
FROM books b
JOIN member_book mb ON b.book_id = mb.book_id
GROUP BY b.book_title  
HAVING COUNT(*) > 2; --لا يوجد 


--Q10:Find members who borrowed books between 01-01-2024 and 10-01-2024. 
SELECT  m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
WHERE mb.borrowing_date BETWEEN '2024-01-01' AND '2024-01-10';


--Q11: Count the total number of books in the library. 
SELECT COUNT(*) AS total_books
FROM books;


--Q12:Find members who borrowed books but have not returned them yet. 
SELECT  m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
WHERE mb.return_date IS NULL;

--Q13: Find members who borrowed books from the Science Fiction category. 
SELECT m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
JOIN books b ON mb.book_id = b.book_id
JOIN categories c ON b.category_id = c.category_id
WHERE c.category_name = 'Science Fiction';

--OR:

SELECT  m.*
FROM members m
JOIN member_book mb ON m.member_id = mb.member_id
JOIN books b ON mb.book_id = b.book_id
WHERE b.genre = 'Sci-Fi';


--functions and stored pros.

--1. Function لحساب أيام التأخير في الارجاع

CREATE FUNCTION calculate_late_days (  
    @due_date DATE,
    @return_date DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @days INT; --إنشاء متغير اسمه days يخزن عدد ايام التاخير 

    IF @return_date IS NULL OR @return_date <= @due_date
        SET @days = 0;  -- اذا لسا ما رجعه او رجعه قبل موعد التسليم يكون عدد ايام التاخير صفر 
    ELSE
        SET @days = DATEDIFF(DAY, @due_date, @return_date); --لحساب الفرق بين التواريخ

    RETURN @days; --يعيد ايام التاخير
END;


--2. Function لحساب مبلغ الغرامة
CREATE FUNCTION calculate_fine_amount (
    @due_date DATE,
    @return_date DATE
)
RETURNS DECIMAL(10,2) -- مبلغ الغرامه
AS
BEGIN
    DECLARE @days INT; --عدد الايام 
    DECLARE @amount DECIMAL(10,2);--قيمة الغرامه

    SET @days = dbo.calculate_late_days(@due_date, @return_date);-- عدد الايام يجلبها من الفنكشن السابق

    SET @amount = @days * 0.25; -- ربع دينار لكل يوم

    RETURN @amount; -- يعيد مقدار الغرامه 
END;


--. Stored Procedure لتسجيل الغرامة
CREATE PROCEDURE apply_fine
    @member_book_id INT
AS
BEGIN
    DECLARE @member_id INT;
    DECLARE @due_date DATE;
    DECLARE @return_date DATE;
    DECLARE @amount DECIMAL(10,2);

    -- جلب البيانات
    SELECT 
        @member_id = member_id,
        @due_date = due_date,
        @return_date = return_date
    FROM member_book
    WHERE member_book_id = @member_book_id;

    -- جلب الغرامة من الفنكشن السابق
    SET @amount = dbo.calculate_fine_amount(@due_date, @return_date);

    -- إذا يوجد غرامة
    IF @amount > 0
    BEGIN
        INSERT INTO financial_fines (member_id, amount, payment_status)
        VALUES (@member_id, @amount, 'Unpaid');
    END
END;


EXEC apply_fine @member_book_id = 7;



select * from financial_fines;
select * from members;

INSERT INTO members (member_name, contact_info, membership_type, registration_date, email)
VALUES ('salem', '9976543210', 'Student', '2024-07-05', 'salem@gmail.com');


INSERT INTO member_book (member_id, book_id, borrowing_date, due_date, return_date) VALUES
(7, 2, '2026-04-01', '2026-04-10', '2026-04-14'); --تاخير ارجاع 4 ايام





--Stored Procedure : نتحقق اذا اصبح الحجز Completed تنشئ سجل في member_book


CREATE PROCEDURE sp_create_borrow_from_reservation
    @reservation_id INT
AS
BEGIN
    DECLARE @member_id INT;  
    DECLARE @book_id INT;
    DECLARE @status VARCHAR(20);

    -- جلب بيانات الحجز
    SELECT 
        @member_id = member_id,
        @book_id = book_id,
        @status = status
    FROM reservations
    WHERE reservation_id = @reservation_id;

    -- التأكد أن الحجز مكتمل
    IF @status <> 'Completed' --إذا الحجز ليس مكتمل: <>لا يساوي
    BEGIN
        RAISERROR('Reservation is not completed yet', 16, 1);--إظهار رسالة خطأ للمستخدم وإيقاف العملية أو تنبيه بوجود مشكلة
        RETURN;    
    END;   
	--درجة الخطأ
--10	رسالة عادية
--11 - 16	خطأ من المستخدم
--17+	خطأ خطير في النظام
-- 1:مجرد رقم للتصنيف أو التتبع


    -- إدخال الاستعارة
    INSERT INTO member_book (
        member_id,
        book_id,
        borrowing_date,
        due_date,
        return_date
    )
    VALUES (
        @member_id,
        @book_id,
        GETDATE(),
        DATEADD(DAY, 7, GETDATE()), -- مدة الاستعارة 7 أيام
        NULL
    );

    -- تحديث حالة الكتاب إلى Borrowed
    UPDATE books
    SET availability_status = 'Borrowed'
    WHERE book_id = @book_id;

END;

EXEC sp_create_borrow_from_reservation @reservation_id = 2; --reservation_id = 2 :completed

SELECT * FROM member_book;
SELECT * FROM books;
SELECT *FROM reservations;