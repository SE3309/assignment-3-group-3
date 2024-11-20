-- Use the created database
USE restaurant_schema;

-- Using basic insert Statement
INSERT INTO Menu (name, price) 
VALUES ('Classic Burger', 8.99);

-- Use INSERT with Subquery
INSERT INTO Menu (name, price)
SELECT CONCAT(name, ' Combo'), price + 3
FROM Menu
WHERE name = 'Classic Burger';

-- INSERT with Computed or Generated Values
INSERT INTO Menu (name, price) 
VALUES (CONCAT('Special ', 'Pasta'), ROUND(14.257, 2));

