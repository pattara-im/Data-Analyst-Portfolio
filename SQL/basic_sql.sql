-- Create customer table
CREATE TABLE customer (
  customer_id INT UNIQUE,
  first_name TEXT,
  last_name TEXT,
  phone TEXT);

INSERT INTO customer VALUES 
(1, 'Trent', 'Alexander-Arnold', '8832870'),
(2, 'Dominik' , 'Szobszlai', '6695536'),
(3, 'Jarrell', 'Quansah', '4884403'),
(4, 'Andrew', 'Robertson', '4087318'),
(5, 'Ibrahima', 'Konate', '0677803'); 

-- Create menu table
CREATE TABLE menu (
  item_id INT UNIQUE,
  item_name TEXT,
  price DECIMAL
);

INSERT INTO menu VALUES 
(1, 'Hawaiian', 250),
(2, 'Pepperoni' , 250),
(3, 'Delux', 300),
(4, 'Salad', 100),
(5, 'Chicken Wings', 150); 

-- Create order table
CREATE TABLE order_item (
  order_id INT,
  item_id INT,
  item_name TEXT,
  quantity INT,
  customer_id INT
);

INSERT INTO order_item VALUES 
(1, 2, 'Pepperoni', 1, 3),
(1, 4, 'Salad' , 1, 3),
(2, 3, 'Delux', 2, 1),
(3, 1, 'Hawaiian', 1, 4),
(3, 5, 'Chicken Wings', 1, 4),
(4, 2, 'Pepperoni', 3, 5),
(5, 2, 'Pepperoni', 2, 2); 

-- Solving 3 instructions
-- 1) Calculate total price for each order
SELECT 
  order_id, 
  SUM(price*quantity) AS total_price
FROM order_item
JOIN menu
ON order_item.item_id = menu.item_id
GROUP BY 1

-- 2) Identify the most popular dish
SELECT 
  item_name,
  SUM(quantity) AS order_amount
FROM order_item
group by 1
order by 2 DESC

-- 3) Customers' name that ordered side dish
SELECT 
  first_name || " " || last_name AS customer_name,
  order_item.item_name AS dish_name
FROM order_item 
JOIN customer 
ON customer.customer_id = order_item.customer_id
WHERE dish_name = "Salad" OR dish_name = "Chicken Wings"
