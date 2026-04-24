create database SQL_Task;
use SQL_Task;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers (customer_id, name, city) VALUES
(1, 'Amit', 'Hyderabad'),
(2, 'Neha', 'Delhi'),
(3, 'Rahul', 'Mumbai'),
(4, 'Priya', 'Chennai'),
(5, 'Kiran', 'Bangalore'),
(6, 'Sneha', 'Pune'),
(7, 'Arjun', 'Kolkata'),
(8, 'Divya', 'Jaipur'),
(9, 'Vikram', 'Lucknow'),
(10, 'Anjali', 'Ahmedabad'),
(11, 'Ravi', 'Surat'),
(12, 'Pooja', 'Nagpur'),
(13, 'Suresh', 'Indore'),
(14, 'Meena', 'Bhopal'),
(15, 'Rohit', 'Patna'),
(16, 'Kavya', 'Vizag'),
(17, 'Nikhil', 'Chandigarh'),
(18, 'Swathi', 'Mysore'),
(19, 'Manoj', 'Coimbatore'),
(20, 'Lakshmi', 'Madurai');
INSERT INTO orders (order_id, customer_id, product_name, amount, order_date) VALUES
(101, 1, 'Laptop', 55000.00, '2025-01-10'),
(102, 2, 'Mobile', 20000.00, '2025-01-12'),
(103, 3, 'Tablet', 15000.00, '2025-01-15'),
(104, 4, 'Headphones', 3000.00, '2025-01-18'),
(105, 5, 'Keyboard', 1200.00, '2025-01-20'),
(106, 6, 'Mouse', 800.00, '2025-01-22'),
(107, 7, 'Monitor', 12000.00, '2025-01-25'),
(108, 8, 'Printer', 7000.00, '2025-01-28'),
(109, 9, 'Camera', 25000.00, '2025-02-01'),
(110, 10, 'Smartwatch', 8000.00, '2025-02-03'),
(111, 11, 'Speaker', 4000.00, '2025-02-05'),
(112, 12, 'Charger', 500.00, '2025-02-07'),
(113, 13, 'Power Bank', 1500.00, '2025-02-10'),
(114, 14, 'Router', 2500.00, '2025-02-12'),
(115, 15, 'SSD', 6000.00, '2025-02-15'),
(116, 16, 'Hard Disk', 5000.00, '2025-02-18'),
(117, 17, 'Webcam', 2200.00, '2025-02-20'),
(118, 18, 'Microphone', 3500.00, '2025-02-22'),
(119, 19, 'Graphics Card', 45000.00, '2025-02-25'),
(120, 20, 'RAM', 7000.00, '2025-02-28');

-- Get customer names and product names for all orders
select c.name,o.product_name
from customers c
join orders o;

-- Find customers who placed orders with amount greater than 20000
select c.name, o.product_name, o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.amount>20000;

-- Get customer name, city, and product name where city is 'Hyderabad'
select c.name, o.product_name, c.city
from customers c
join orders o
ON c.customer_id = o.customer_id
where c.city="Hyderabad";

-- Find all orders where product name starts with 'S' and amount is greater than 10000
select c.name, o.product_name,o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.product_name="S%" and o.amount>10000;

-- Get customers who ordered products between amount 10000 and 50000
select c.name, o.product_name,o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.amount between 10000 and 50000;

-- Find customer names who ordered either 'Laptop' or 'Mobile'
select c.name, o.product_name
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.product_name="Laptop" or o.product_name="Mobile";

-- Get top 5 highest order amounts with customer names
select c.name, o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
order by o.amount desc
limit 5;

-- Skip first 5 highest orders and get next 5 records with customer name and amount
select c.name, o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
order by o.amount desc
limit 5 offset 5;

-- Find customers whose name starts with 'A' and who placed orders greater than 30000
select c.name, o.product_name,o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.product_name="A%" and o.amount>30000;

-- Get customer name, city, product name where city is 'Delhi' OR 'Mumbai'
select c.name, o.product_name,c.city
from customers c
join orders o
ON c.customer_id = o.customer_id
where c.city="Delhi" or c.city="Mumbai";

-- amount > 20000
select c.name, o.product_name,c.city,o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.amount>20000;

-- product name contains 'Pro'
select c.name, o.product_name,c.city,o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
where o.product_name like "%Pro%";

-- show only 3 records after skipping first 2 records
select c.name, o.amount
from customers c
join orders o
ON c.customer_id = o.customer_id
limit 3 offset 2;






















