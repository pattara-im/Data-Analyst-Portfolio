CREATE TABLE customer (
  customer_id INT UNIQUE,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  region TEXT);

  INSERT INTO customer VALUES 
  (01, "Virgil", "van Dijk", "vvd04@gmail.com", "Europe"),
  (02, "Trent", "Alexander-Arnold", "taa66@gmail.com", "Europe"),
  (03, "Diogo", "Jota", "diogoj20@gmail.com", "Europe"),
  (04, "Darwin", "Nunez", "darwin9@gmail.com", "South America"),
  (05, "Alexis", "Mac Allister", "macca10@gmail.com", "South America"),
  (06, "Alisson", "Becker", "ab1@gmail.com", "South America"),
  (07, "Endo", "Wataru", "wataru03@gmail.com", "Asia"),
  (08, "Takumi", "Minamino", "taki18@gmail.com", "Asia"),
  (09, "Mohamed", "Salah", "mosalah11@gmail.com", "Africa"),
  (10, "Sadio", "Mane", "sadio10@gmail.com", "Africa");
  
  CREATE TABLE menu (
  menu_id INT UNIQUE,
  menu_name TEXT,
  menu_price REAL,
  menu_type TEXT);

INSERT INTO menu VALUES
  (01, "Hawaiian_Pizza", 249, "Pizza"),
  (02, "Mushroom_Pizza", 249, "Pizza"),
  (03, "Carbonara_Pizza", 279, "Pizza"),
  (04, "Seafood_Pizza", 349, "Pizza"),
  (05, "French_Fries", 99, "Appetizer"),
  (06, "Garlic_Bread", 119, "Appetizer"),
  (07, "Chicken_Nuggets", 119, "Appetizer"),
  (08, "Crab_Salad", 159, "Appetizer"),
  (09, "Water", 20, "Drinks"),
  (10, "Coca_Cola", 30, "Drinks");
 
 CREATE TABLE customer_order (
   order_id INT UNIQUE,
   customer_id INT,
   menu_id INT,
   quantity REAL,
   order_date DATE);
  
  INSERT INTO customer_order VALUES
  (01, 07, 02, 1, "2023-01-05"),
  (02, 07, 09, 1, "2023-01-05"),
  (03, 01, 04, 2, "2023-01-09"),
  (04, 03, 02, 1, "2023-01-09"),
  (05, 03, 06, 1, "2023-01-15"),
  (06, 03, 10, 1, "2023-01-15"),
  (07, 04, 03, 1, "2023-01-22"),
  (08, 02, 01, 1, "2023-01-30"),
  (09, 02, 09, 1, "2023-01-30"),
  (10, 05, 07, 2, "2023-01-31"),
  (11, 08, 01, 2, "2023-02-08"),
  (12, 08, 05, 2, "2023-02-08"),
  (13, 09, 02, 1, "2023-02-17"),
  (14, 09, 09, 1, "2023-02-17"),
  (15, 10, 04, 2, "2023-02-20"),
  (16, 10, 06, 1, "2023-02-20"),
  (17, 10, 01, 1, "2023-02-20"),
  (18, 02, 03, 1, "2023-02-25"),
  (19, 06, 01, 2, "2023-02-28"),
  (20, 06, 07, 2, "2023-02-28"),
  (21, 01, 01, 1, "2023-03-02"),
  (22, 01, 04, 1, "2023-03-02"),
  (23, 01, 08, 1, "2023-03-02"),
  (24, 07, 05, 1, "2023-03-08"),
  (25, 09, 04, 1, "2023-03-08"),
  (26, 08, 07, 2, "2023-03-15"),
  (27, 03, 01, 1, "2023-03-20"),
  (28, 03, 05, 1, "2023-03-20"),
  (29, 03, 10, 1, "2023-03-20"),
  (30, 04, 04, 3, "2023-03-20");
  
-- Total sales by month --
SELECT 
date_format(customer_order.order_date,'%m') AS month_number,
date_format(customer_order.order_date,'%M') AS month_name,
SUM(menu.menu_price*customer_order.quantity) AS sales
FROM customer_order
JOIN menu ON 
  customer_order.menu_id = menu.menu_id
GROUP BY month_name
ORDER BY month_number;

-- Most ordered menu by region --
SELECT m.region AS region, m.menu_name AS menu_name, MAX(m.quantity) AS quantity
FROM
(SELECT customer.region AS region, menu.menu_name AS menu_name, SUM(customer_order.quantity) AS quantity
FROM customer
INNER JOIN customer_order
ON customer.customer_id = customer_order.customer_id
INNER JOIN menu
ON customer_order.menu_id = menu.menu_id
GROUP BY customer.region, menu.menu_name
ORDER BY customer.region) m   
GROUP BY m.region;

-- Finding regular customers --
WITH t3 AS (
SELECT customer_id AS customer_id,
	   COUNT(customer_id) AS order_count
FROM customer_order
GROUP BY customer_id
ORDER BY customer_id)   
SELECT t1.customer_id,
	   CONCAT(t1.first_name," ",t1.last_name) AS customer_name,
	   t3.order_count AS order_count
FROM customer AS t1
INNER JOIN t3
ON t1.customer_id = t3.customer_id
WHERE order_count > 3;

