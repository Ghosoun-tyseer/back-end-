-- task6
 use food_delivery_system ;

 -- Q1: Show: customer_name, COUNT(*) of orders grouped by customer Order by number of orders descending.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- Q2: Only for customers who placed more than 3 orders
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 3; -- لا يوجد عميل له اكثر من 3 طلبات

-- Q3: Show: customer_name, total spent (Only for those who spent > 50 JD)
-- ملاحظة: الحساب يتم عبر ربط الجداول ببعضها للوصول للسعر والكمية
SELECT c.customer_name, SUM(mi.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN menu_items mi ON oi.Item_id = mi.item_id
GROUP BY c.customer_name
HAVING SUM(mi.price * oi.quantity) > 50.00; --لا يوجد عملاء طلبو ب اكثر من 50 دينار 

-- Q4: Show: menu_item_name, total quantity sold (Only for units > 10)
SELECT mi.item_name, SUM(oi.quantity) AS total_sold
FROM menu_items mi
JOIN order_items oi ON mi.item_id = oi.Item_id
GROUP BY mi.item_name
HAVING SUM(oi.quantity) > 10; --لا يوجد 


-- PART3

-- Create the denormalized reporting table
CREATE TABLE orders_monthly_report (
    report_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    customer_name VARCHAR(100), -- Redundant
    restaurant_name VARCHAR(100), -- Redundant
    month_year VARCHAR(7), -- Format: 'MM-YYYY'
    total_orders INT,
    total_amount DECIMAL(10, 2),
     FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--Explain in comments:
--Why is this table denormalized?
--Because it stores data that already exists in other tables.

--Which columns here are redundant with other tables?
--customer_name,restaurant_name , customer_id

--What is the main advantage of this table for reports?
--Speed: Instead of performing JOIN for multiple tables and SUM and GROUP BY operations, it reads the result directly from a single line in that table.

--What is the main disadvantage and how should it be kept up‑to‑date (e.g., batch job, trigger, etc.)?
--The drawback: the risk of data inconsistency if the original data changes and the report does not reflect it.
-- 1. الـ Database Triggers (التحديث الفوري)
/*
    نستخدمها عندما نحتاج تحديث لحظي.
    يتم برمجتها لتعمل فور وقوع حدث معين مثل إضافة طلب جديد أو تعديل قيمة.
    بمجرد حدوث هذا التغيير، يقوم الـ Trigger تلقائياً بتنفيذ كود التحديث 
     في جدول التقارير في نفس اللحظة.
    يضمن دقة بيانات التقرير بالثانية (Live Data) دون أي تدخل بشري.
    من عيوبها: بطء العملية أثناء عملية الحفظ.
   تُكتب بصيغة: AFTER INSERT ON Orders.
    لا يحتاج المبرمج لاستدعائها؛ هي تعمل من تلقاء نفسها بمجرد حدوث أي تغيير.
*/

-- 2. الـ Batch Job (التحديث المجدول)
/*
    هي عملية برمجية يتم جدولتها لتعمل في أوقات محددة.
    يقوم النظام بجمع كل التغييرات التي حدثت ومعالجتها دفعة واحدة لتحديث جدول التقارير.
    من عيوبها: أن البيانات تظل غير محدثة حتى يأتي وقت التحديث.
    المبرمج يحدد الوقت فقط، والسيرفر يتولى المهمة في الخلفية دون تدخل بشري.
*/

-- 3. الـ Stored Procedures (الأمر البرمجي)
/*
    هو عبارة عن كود جاهز مخزن في قاعدة البيانات.
   لا يعمل من تلقاء نفسه، بل ينتظر أن يقوم المبرمج أو النظام باستدعائه (Call) 
     ليقوم بعملية التحديث.
    يمكن جعل الكود يعمل عند الضغط على زر "طلب تقرير".
*/