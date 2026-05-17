USE  food_delivery_system ;

SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM menu_items;
SELECT * FROM orders;
SELECT * FROM order_items;

--Q1:Show all customers and their orders
--All customers will be displayed (even if they have no orders).
--Which JOIN will you use? LEFT JOIN
--What happens to customers with no orders? Customers without orders will appear and OrderID = NULL

SELECT customers.customer_name, orders.order_id
FROM customers 
LEFT JOIN orders 
ON customers.customer_id = orders.customer_id;

--All customers have orders, so no NULL will appear. If we add a new customer without an order, a NULL will appear.

INSERT INTO customers (customer_name, email, phone)
VALUES ('mais', 'mais22@gmail.com', '0700000000');


--Q2: Show only customers who made orders
-- Why is this different from Q1? any customer without orders will not be displayed.
--Which JOIN will you use? INNER JOIN

SELECT c.customer_name, o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

--Q3: Show all menu items, that never has been ordered
--Display items not found in order_items , that have not been ordered 
--  What JOIN type is required? LEFT JOIN + WHERE IS NULL

SELECT m.item_name
FROM menu_items m
LEFT JOIN order_items oi
ON m.item_id = oi.item_id
WHERE oi.item_id IS NULL;

--Q4: Rewrite Q2  to include ALL customers:

SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o     --I replaced INNER with Left
ON c.customer_id = o.customer_id;


--Q5: Show:
--Customer Name 
--Order ID 
--Item Name 
--Quantity 
--Total Price per item (Price × Quantity) 
--Conditions:
--Include orders with multiple items 
--Do NOT lose any data due to wrong joins 

--The customer's name will appear more than once because they can place multiple orders and order items.
--The order ID will appear more than once because it contains more than one item.
SELECT 
    c.customer_name,
    o.order_id,
    m.item_name,
    oi.quantity,
    (oi.quantity * m.price) AS total_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN menu_items m ON oi.item_id = m.item_id;


 --Q6:find the most popular menu item
 --SUM(quantity) → عدد مرات الطلب
SELECT TOP 1 
    m.item_name,
    SUM(oi.quantity) AS total_orders -- اذا وجبه انوجدت ب اكثر من اوردر بجمعهم عشان اعرف عدد مرات الطلب لهذه الوجبه 
FROM order_items oi  --يحتوي: item_id ،quantity
JOIN menu_items m ON oi.item_id = m.item_id
GROUP BY m.item_name  -- نجمع البيانات حسب اسم الوجبة, 
ORDER BY total_orders DESC; --يرتب النتائج من الأكبر للأصغر



--Q7:Find customers who ordered from more than one restaurant
--Requires:
--Multiple joins 
--GROUP BY 

SELECT 
    c.customer_name,
    COUNT(DISTINCT o.restaurant_id) AS restaurant_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT o.restaurant_id) > 1;-- HAVING : تستخدم مع ال Aggregate Function بدل where
-- لن تظهر نتائج لان كل عميل لدي طلب من مطعم واحد 
-- الحل إضافة Orders لنفس العميل من مطاعم مختلفة

INSERT INTO orders (customer_id, restaurant_id, order_date, total_amount)
VALUES (1, 2, '8/4/2026 09:00:00' , 20.00);

--اضافة Items  داخل الاوردر 
SELECT * FROM orders ; -- لمعرفة ال order_ids الموجوده 
-- عندي 5 اوردرات بضيف ال6 

INSERT INTO order_items (order_id, item_id, quantity)
VALUES (6, 2, 1);

INSERT INTO orders (customer_id, restaurant_id, order_date, total_amount)
VALUES (2, 3, '7/4/2026 09:00:00', 15.00);

INSERT INTO order_items (order_id, item_id, quantity)
VALUES (7, 3, 2);

SELECT 
    c.customer_name,
    COUNT(DISTINCT o.restaurant_id) AS restaurant_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT o.restaurant_id) > 1;







--delete for re execute 

DELETE FROM order_items
WHERE order_id IN (6, 7);


DELETE FROM orders
WHERE order_id IN (6, 7);


DELETE FROM customers
WHERE customer_name = 'mais';

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_items;