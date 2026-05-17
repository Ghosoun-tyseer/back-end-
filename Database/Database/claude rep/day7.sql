USE  food_delivery_system ;



-- 1. وظائف نصية (Scalar Functions): تحويل أسماء المطاعم لحروف كبيرة وتنسيق العناوين
-- نستخدم UPPER لتحويل النص و CONCAT لدمج النصوص
SELECT 
    UPPER(restaurant_name) AS Restaurant_Bold, 
    CONCAT(restaurant_name, ' - ', restaurant_address) AS Full_Label
FROM restaurants;


-- 2. وظائف رقمية (Math Functions): حساب ضريبة القيمة المضافة (16%) وتقريب الناتج
-- نستخدم ROUND لتقريب السعر لخاننين عشريتين فقط
SELECT 
    item_name, 
    price, 
    ROUND(price * 0.16, 2) AS Tax_Amount --المعادلة: ضربنا السعر في %16 (الضريبة).
FROM menu_items;


-- 3. وظائف التاريخ (Date Functions): استخراج تفاصيل من وقت الطلب
-- نستخدم YEAR, MONTH, DATENAME لمعرفة متى تمت الطلبات
SELECT 
    order_id, 
    order_date,
    YEAR(order_date) AS Order_Year,
    DATENAME(MONTH, order_date) AS Order_Month_Name,
    DATENAME(WEEKDAY, order_date) AS Order_Day
FROM orders;


-- 4. وظائف التجميع (Aggregate Functions): إحصائيات عامة عن النظام
--  COUNT, AVG, SUM, MIN, MAX
--لكل المطاعم 
SELECT 
    COUNT(M.item_id) AS Total_Items,             -- عد الوجبات من جدول الوجبات فقط
    AVG(M.price) AS Average_Menu_Price,          -- متوسط الأسعار الحقيقي
    MAX(M.price) AS Most_Expensive_Item,         -- أغلى وجبة فعلياً
    MIN(R.rating) AS Lowest_Rating               -- أقل تقييم بين المطاعم المرتبطة بوجبات
FROM menu_items M
JOIN restaurants R ON M.restaurant_id = R.restaurant_id;

--لكل مطعم لوحده 
SELECT 
    R.restaurant_name, 
    COUNT(M.item_id) AS Total_Menu_Items,      -- عدد الوجبات في هذا المطعم فقط
    AVG(M.price) AS Average_Price,             -- متوسط أسعار هذا المطعم
    MAX(M.price) AS Most_Expensive,            -- أغلى وجبة عنده
    R.rating                                   -- تقييم هذا المطعم
FROM restaurants R
JOIN menu_items M ON R.restaurant_id = M.restaurant_id
GROUP BY R.restaurant_name, R.rating;          -- تجميع النتائج بناءً على اسم المطعم وتقييمه



-- 5. وظائف المعالجة الشرطية (CASE Function): تصنيف المطاعم حسب التقييم
-- تشبه If-Else لتصنيف البيانات بشكل نصي
SELECT 
    restaurant_name, 
    rating,
    CASE 
        WHEN rating >= 4.8 THEN 'Excellent (Top Rated)'
        WHEN rating >= 4.6 THEN 'Very Good'
        ELSE 'Good'
    END AS Quality_Category
FROM restaurants;


-- 6. وظائف التعامل مع القيم الفارغة (COALESCE): ضمان ظهور نص بدل الفراغ
-- ا وجود زبون بلا إيميل، سيظهر 'No Email Provided'
SELECT 
    customer_name, 
    COALESCE(email, 'No Email Provided') AS Contact_Info
FROM customers;

INSERT INTO customers (customer_name, phone) 
VALUES ('Sara Ahmad', '0799991122');


-- 7. وظائف السلاسل النصية (LEN & LEFT): اختصار العناوين الطويلة
-- نستخدم LEN لمعرفة طول النص و LEFT لأخذ أول 10 حروف فقط
SELECT 
    restaurant_name, 
    LEFT(restaurant_address, 10) + '...' AS Short_Address,
    LEN(restaurant_name) AS Name_Character_Count
FROM restaurants;



-- 9.  الفرق الزمني بين طلبات الزبون الواحد
-- نستخدم LAG لجلب تاريخ "الطلب السابق" ووضعه بجانب "الطلب الحالي"
SELECT 
    customer_id,
    order_id,
    order_date AS Current_Order_Date,
    -- LAG تجلب قيمة التاريخ من السطر السابق لنفس الزبون
    LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS Previous_Order_Date,
    -- حساب الفرق بالأيام بين الطلب الحالي والسابق
    DATEDIFF(day, --تحسب الفرق بين التاريخين (بالأيام).
             LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date), --LAG:تذهب للطلب الذي قام به الزبون قبل هذا الطلب مباشرة وتجلب تاريخه.
             order_date) AS Days_Between_Orders
FROM orders;
--PARTITION BY customer_id: تضمن ان نقارن مع نفس الشخص وليس شخص اخر



-- 10. وظائف النظام (System Functions): معلومات عن الجلسة الحالية
-- مفيدة لمعرفة من قام بالاستعلام ومتى
SELECT 
    CURRENT_USER AS DB_User, 
    GETDATE() AS Execution_Time, 
    APP_NAME() AS Software_Used;


-- 11. دمج الوظائف ,تنسيق رسالة تنبيه للزبائن
-- نستخدم CONCAT مع وظائف التاريخ والنصوص معاً
SELECT 
    CONCAT('Dear ', customer_name, ', your order on ', FORMAT(order_date, 'dd/MM'), ' was successful!') AS Notification
FROM customers 
JOIN orders ON customers.customer_id = orders.customer_id;


-- بناء الفنكشن: دمج الاسم والهاتف12:
CREATE FUNCTION dbo.GetCustomerLabel (@Name NVARCHAR(100), @Phone NVARCHAR(20)) --CREATE FUNCTION dbo.FUNCTION-NAME (Parameters)
RETURNS NVARCHAR(130) --النتيجة ستكون نص طوله الإجمالي 130 حرفاً.
AS 
BEGIN    --نضع داخلها ماذا نريد
   
    RETURN @Name + ' (Phone: ' + @Phone + ')'; 
END;
GO -- نستخدم GO في SQL Server للفصل بين العمليات

-- كيفية الاستخدام في الاستعلام:
SELECT 
    customer_id, 
    dbo.GetCustomerLabel(customer_name, phone) AS Delivery_Label
FROM customers;



-- بناء الفنكشن: جلب منيو مطعم معين بناءً على اسمه
CREATE FUNCTION dbo.GetMenuByRestaurant (@RestName NVARCHAR(100)) 
RETURNS TABLE 
AS 
RETURN --نكتب جملة الـ SELECT مباشرة داخل الأقواس. لا يوجد BEGIN ,END
( 
    SELECT 
        m.item_name, 
        m.price
    FROM menu_items m
    JOIN restaurants r ON m.restaurant_id = r.restaurant_id
    WHERE r.restaurant_name = @RestName 
);
GO

SELECT * FROM dbo.GetMenuByRestaurant('Hashem Restaurant');

-- إضافة أصناف جديدة لمطعم هاشم (رقم 1)
INSERT INTO menu_items (restaurant_id, item_name, price) VALUES 
(1, 'Foul Medames Plate', 2.50),
(1, 'Labneh with Thyme', 1.80),
(1, 'Gallayet Bandora', 3.00);