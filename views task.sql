CREATE DATABASE restaurant_db;
USE restaurant_db;

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories VALUES
(1, 'South Indian'),
(2, 'North Indian'),
(3, 'Chinese'),
(4, 'Desserts'),
(5, 'Beverages');

CREATE TABLE food_items (
    food_id INT PRIMARY KEY,
    food_name VARCHAR(100),
    category_id INT,
    price DECIMAL(8,2),
    quantity INT,
    rating DECIMAL(2,1),
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

INSERT INTO food_items VALUES
(1, 'Idli', 1, 40, 50, 4.5),
(2, 'Dosa', 1, 80, 35, 4.7),
(3, 'Pongal', 1, 70, 25, 4.3),
(4, 'Vada', 1, 30, 60, 4.4),
(5, 'Upma', 1, 50, 20, 4.1),

(6, 'Butter Naan', 2, 45, 40, 4.6),
(7, 'Paneer Butter Masala', 2, 220, 18, 4.8),
(8, 'Veg Biryani', 2, 180, 22, 4.5),
(9, 'Dal Tadka', 2, 150, 15, 4.2),
(10, 'Jeera Rice', 2, 120, 17, 4.0),

(11, 'Fried Rice', 3, 160, 28, 4.3),
(12, 'Noodles', 3, 140, 26, 4.2),
(13, 'Manchurian', 3, 170, 19, 4.4),
(14, 'Spring Roll', 3, 130, 24, 4.1),
(15, 'Schezwan Rice', 3, 190, 16, 4.5),

(16, 'Ice Cream', 4, 90, 45, 4.7),
(17, 'Gulab Jamun', 4, 60, 50, 4.6),
(18, 'Brownie', 4, 110, 21, 4.8),
(19, 'Rasgulla', 4, 70, 30, 4.4),
(20, 'Cheese Cake', 4, 150, 14, 4.9),

(21, 'Coffee', 5, 60, 55, 4.5),
(22, 'Tea', 5, 30, 70, 4.3),
(23, 'Mango Juice', 5, 90, 25, 4.6),
(24, 'Lassi', 5, 80, 27, 4.5),
(25, 'Milkshake', 5, 120, 20, 4.7),

(26, 'Pizza', 2, 300, 12, 4.9),
(27, 'Burger', 2, 150, 29, 4.4),
(28, 'Sandwich', 2, 100, 33, 4.2),
(29, 'Momos', 3, 130, 31, 4.5),
(30, 'Falooda', 4, 140, 18, 4.8);

-- Create a view to display all food items with price greater than 100
create view abc as
select * from  food_items
where price>100;
select * from abc;

-- Create a view to display only beverages items
CREATE VIEW beveragestable AS
SELECT
    f.food_id,
    f.food_name,
    c.category_name,
    f.price,
    f.quantity,
    f.rating
FROM categories c
INNER JOIN food_items f
ON c.category_id = f.category_id
WHERE c.category_name = 'Beverages';
select * from beveragestable;

-- 3. Create a view to show food items with rating above 4.5
create view rating as
select * 
from food_items
where rating>4.5;
select * from rating;

-- 4. Create a view using JOIN to display food name and category name
CREATE VIEW display AS
SELECT food_name, category_name
FROM food_items f
INNER JOIN categories c
ON f.category_id = c.category_id;
select * from display;

-- 5. Create a view to display category-wise average price
-- 5. Create a view to display category-wise average price
create view averagee as
select avg(f.price) as avgprice,c.category_name
from food_items f
inner join categories c
on f.category_id = c.category_id
group by c.category_name;
select * from averagee;

-- 6. Create a view to show total quantity available in each category
create view quantityy as
select sum(f.quantity),c.category_name
from food_items f
inner join categories c
on f.category_id = c.category_id
group by c.category_name;
select * from quantityy;


-- 7. Create a view to display highest priced food item in each category
create view highest as
select max(f.price) as pricee,c.category_name
from food_items f
inner join categories c
on f.category_id = c.category_id
group by c.category_name;
select * from highest;

-- 8. Create a view using subquery to show foods priced above average price
create view showfood as
select *
from food_items
where price>(
select avg(price)
from food_items
);
select * from showfood;

-- 9. Create a view to display category names having more than 5 food items
CREATE VIEW catnam AS
SELECT
    c.category_name,
    COUNT(f.food_id) AS foodcount
FROM food_items f
INNER JOIN categories c
ON f.category_id = c.category_id
GROUP BY c.category_name
HAVING COUNT(f.food_id) > 5;
select * from catnam;

-- 10. Create a view to display top rated item from each category
CREATE VIEW toprated AS
SELECT
    c.category_name,
    max(f.rating) AS ratingtop
FROM food_items f
INNER JOIN categories c
ON f.category_id = c.category_id
GROUP BY c.category_name;
select * from toprated;