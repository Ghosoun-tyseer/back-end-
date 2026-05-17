CREATE DATABASE food_delivery_system ;

USE  food_delivery_system ;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
     customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY IDENTITY(1,1),
    restaurant_name VARCHAR(100) NOT NULL,
    restaurant_address VARCHAR(255),
    rating DECIMAL(2, 1) 
	);

	CREATE TABLE menu_items (
    item_id INT PRIMARY KEY IDENTITY(1,1),
    restaurant_id INT,
   item_name VARCHAR(100),
    price DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
   customer_id INT,
   restaurant_id INT,
    order_date DATETIME ,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY ( customer_id) REFERENCES customers( customer_id),
    FOREIGN KEY ( restaurant_id) REFERENCES restaurants( restaurant_id)
);

CREATE TABLE order_items (
      order_id INT,
    Item_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY ( order_id, Item_id), 
    FOREIGN KEY ( order_id) REFERENCES orders( order_id),
    FOREIGN KEY (Item_id) REFERENCES menu_items(Item_id)
);

INSERT INTO customers (customer_name, email, phone) VALUES 
('Ghosoun Tyseer', 'ghosountyseer@gmail.com', '0795551234'),
('Lina Haddad', 'linah@outlook.com', '0778885678'),
('Omar Mohammed', 'omar88@yahoo.com', '0781112233'),
('Noor Salem', 'noor.s@gmail.com', '0790009988'),
('Rakan freihat', 'rakanfreihat@gmail.com', '0776664422');

INSERT INTO restaurants (restaurant_name, restaurant_address, rating) VALUES 
('Hashem Restaurant', 'Downtown, Amman', 4.9),
('Reem Al-Bawadi', 'Tla Al-Ali, Amman', 4.6),
('Shawerma Zarb', 'Seventh Circle, Amman', 4.7),
('Fakhreldin', 'Jabal Amman', 4.8),
('Abu Jbara', 'Madina Street, Amman', 4.9);


INSERT INTO menu_items (restaurant_id, item_name, price) VALUES 
(1, 'Hummus & Falafel Plate', 3.50),
(2, 'Mansaf Tray', 15.00),
(3, 'Large Beef Shawerma Meal', 4.25),
(4, 'Mixed Grill Platter', 12.00),
(5, 'Crunchy Falafel Sandwich', 1.20);


INSERT INTO orders (customer_id, restaurant_id, order_date, total_amount) VALUES 
(1, 1, '2026-04-01 09:00:00', 7.00),  
(2, 2, '2026-04-01 13:30:00', 30.00),
(3, 3, '2026-04-02 19:00:00', 12.75), 
(4, 4, '2026-04-02 20:15:00', 24.00), 
(5, 5, '2026-04-02 08:30:00', 6.00); 
SELECT * FROM orders ;

INSERT INTO order_items (order_id, Item_id, Quantity) VALUES 
-- Order #1 
(1, 1, 2), 
(1, 5, 3), 

-- Order #2 
(2, 2, 1), 
(2, 4, 1), 

-- Order #3 
(3, 3, 3);


--SELECT statments 

-- EX1 :Show restaurants rated higher than 4.7:
SELECT * FROM restaurants 
WHERE rating > 4.7;

--EX2 :Displaying food items priced between 3 and 10 dinars:
SELECT item_name, price FROM menu_items 
WHERE price BETWEEN 3.00 AND 10.00;

--EX3 :To display the menu from cheapest to most expensive
SELECT item_name, price 
FROM menu_items 
ORDER BY price ASC; 

--EX4 :Show restaurants from highest rated to lowest rated
SELECT DISTINCT restaurant_name, rating  -- DISTINCT:To avoid duplication, without it the same restaurant would appear duplicated with every rating number
FROM restaurants 
ORDER BY rating DESC; 

--EX5: Displaying "Best Restaurant" in the app based on ratings
SELECT TOP 1 restaurant_name, rating 
FROM restaurants 
ORDER BY rating DESC;


--EX6:Knowing the number of restaurants registered in the system
SELECT COUNT(restaurant_id) AS total_restaurants 
FROM Restaurants;

--EX7:Find how many orders customer number 1 has placed
SELECT COUNT(order_id) AS total_orders 
FROM Orders 
WHERE customer_id = 1;

--EX8:Display the name and price of the most expensive dish on the entire menu.
SELECT TOP 1 item_name, price 
FROM menu_items 
ORDER BY price DESC;

--EX9:Total sales from all orders
SELECT SUM(total_amount) AS total_revenue 
FROM Orders;

--EX10:Average meal prices in the system
SELECT AVG(price) AS average_price 
FROM menu_items;

--EX11:displaying all orders with customer names

SELECT 
    Orders.order_id, 
    customers.customer_name, 
    Orders.order_date, 
    Orders.total_amount
FROM Orders
INNER JOIN customers ON Orders.customer_id = customers.customer_id;

--EX12:listing the items in each order and calculating the total price for each order.
SELECT 
    Orders.order_id, 
    menu_items.item_name, 
    order_items.Quantity, 
    menu_items.price AS unit_price,
    (order_items.Quantity * menu_items.price) AS sub_total
FROM Orders
JOIN order_items ON Orders.order_id = order_items.order_id
JOIN menu_items ON order_items.Item_id = menu_items.item_id
ORDER BY Orders.order_id;


--EX13:Add a new restaurant
INSERT INTO Restaurants (restaurant_name, restaurant_address, rating) 
VALUES ('Rainbow Falafel', 'Rainbow Street, Amman', 4.5);

--Add a meal to this restaurant
INSERT INTO menu_items (restaurant_id, item_name, price) 
VALUES (6, 'Special Zatar Wrap', 2.25);

--EX14:Change of customer phone number
UPDATE customers 
SET phone = '0791234567' 
WHERE customer_name = 'Ghosoun Tyseer';

SELECT customer_name ,phone
FROM customers
WHERE customer_name = 'Ghosoun Tyseer';

--EX15:The rating for "Hashem Restaurant" has been updated to 5.0
UPDATE restaurants 
SET rating = 5.0 
WHERE restaurant_name = 'Hashem Restaurant';

SELECT restaurant_name ,rating
FROM restaurants 

--Hashim Restaurant has updated its prices (by 10%).
--"Its rating increase, so the prices increase, hahaha."
UPDATE menu_items 
SET price = price * 1.1 
WHERE restaurant_id = 1;


SELECT item_name, price 
FROM menu_items 
WHERE restaurant_id = 1;