USE food_delivery_system ;

--Q1: Find orders where total price is greater than the average order price

SELECT *
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * m.price) AS total_price  --السعر لكل طلب , نجمع الاسعار لكل طلب 
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN menu_items m ON oi.item_id = m.item_id      -- جمع 3 جداول للحصول على المعلومات
    GROUP BY o.order_id
) AS order_totals  --يحتوي (order_id + total_price)
WHERE total_price > (--  يختار الطلبات الأعلى من المتوسط
    SELECT AVG(total_price)  --متوسط أسعار الطلبات
    FROM (
        SELECT 
            SUM(oi.quantity * m.price) AS total_price  --الهدف من الاعاده هنا استخدامه لحساب المتوسط 
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        JOIN menu_items m ON oi.item_id = m.item_id
        GROUP BY o.order_id
    ) AS avg_table 
	);

	SELECT *
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * m.price) AS total_price  --السعر لكل طلب , نجمع الاسعار لكل طلب 
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN menu_items m ON oi.item_id = m.item_id      -- جمع 3 جداول للحصول على المعلومات
    GROUP BY o.order_id
) AS order_totals  --يحتوي (order_id + total_price)
WHERE total_price > (--  يختار الطلبات الأعلى من المتوسط
    SELECT AVG(total_price)  --متوسط أسعار الطلبات
    FROM (
        SELECT 
            SUM(oi.quantity * m.price) AS total_price  --الهدف من الاعاده هنا استخدامه لحساب المتوسط 
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        JOIN menu_items m ON oi.item_id = m.item_id
        GROUP BY o.order_id
    ) AS avg_table 
	);


	select * from orders;

--Q2:Find the most expensive menu item
SELECT TOP 1 * -- اختيار اول عنصر لانه  الاغلى 
FROM menu_items 
ORDER BY price DESC; -- ترتيب تنازلي حسب السعر


--Q3:Find customers who made the latest order
SELECT c.customer_name, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date = (
    SELECT MAX(order_date)   --احدث او اقرب تاريخ 
    FROM orders
);

--Q4:Show all restaurants that have at least one order
SELECT DISTINCT  r.restaurant_name  --استخدام DISTINCT: هناك مطاعم تتكرر لان لها اكثر من اوردر 
FROM restaurants r
JOIN orders o ON r.restaurant_id = o.restaurant_id;


--Q5: Show all unique customer names
SELECT DISTINCT customer_name -- DISTINCT :يمنع التكرار  
FROM customers;


--Q6: Find menu items that were never ordered (Use NOT IN)
SELECT item_name
FROM menu_items
WHERE item_id NOT IN (  --لم يتم طلبه يعني id الخاص به غير موجود في الorder_items
    SELECT item_id
    FROM order_items
);