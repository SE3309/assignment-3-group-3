-- Select the database to use
USE restaurant_schema;

-- Insert records into the Admin table
-- These represent administrative users with roles and credentials
INSERT INTO Admin (name, password, email, role)
VALUES 
('Alice Admin', 'securepass1', 'alice.admin@example.com', 'Manager'), -- Manager admin
('Bob Admin', 'securepass2', 'bob.admin@example.com', 'Staff');      -- Staff admin

-- Insert records into the Expense table
-- This tracks various expenses incurred by the admins
INSERT INTO Expense (adminID, expenseAmount, date, type, description)
VALUES
(1, 200.50, '2024-01-10', 'Supplies', 'Purchased kitchen supplies'),    -- Supplies expense by admin ID 1
(2, 500.00, '2024-01-15', 'Maintenance', 'HVAC system repair');         -- Maintenance expense by admin ID 2

-- Insert records into the CustomerOrder table
-- These are customer orders, each handled by a staff member
INSERT INTO CustomerOrder (customerID, staffID, date)
VALUES
(1, 1, '2024-01-20'),    -- Order placed by customer ID 1, handled by staff ID 1
(2, 2, '2024-01-21'),    -- Order placed by customer ID 2, handled by staff ID 2
(15, 2, '2024-01-21'),   -- Order placed by customer ID 15, handled by staff ID 2
(25, 3, '2024-01-22'),   -- Order placed by customer ID 25, handled by staff ID 3
(4, 2, '2024-01-24'),    -- Order placed by customer ID 4, handled by staff ID 2
(6, 4, '2024-01-21'),    -- Order placed by customer ID 6, handled by staff ID 4
(100, 4, '2024-02-05'),  -- Order placed by customer ID 100, handled by staff ID 4
(15, 2, '2024-02-09'),   -- Another order by customer ID 15, handled by staff ID 2
(14, 1, '2024-02-09'),   -- Order placed by customer ID 14, handled by staff ID 1
(200, 5, '2024-02-09');  -- Order placed by customer ID 200, handled by staff ID 5

-- Insert records into the OrderDetail table
-- This represents the items ordered within each customer order
INSERT INTO OrderDetail (customerOrderID, menuID, quantity)
VALUES
(1, 1, 2),  -- Order ID 1 includes 2 units of menu item 1 (e.g., "Dish 1")
(1, 2, 1),  -- Order ID 1 includes 1 unit of menu item 2 (e.g., "Dish 2")
(2, 1, 3);  -- Order ID 2 includes 3 units of menu item 1 (e.g., "Dish 1")

-- Insert additional orders into the OrderDetail table for menuID 1
-- This adds more data points for analytics or testing
INSERT INTO OrderDetail (customerOrderID, menuID, quantity)
VALUES
(5, 1, 1),  -- Order ID 5 includes 1 unit of menu item 1
(6, 1, 2),  -- Order ID 6 includes 2 units of menu item 1
(7, 1, 2),  -- Order ID 7 includes 2 units of menu item 1
(8, 1, 2),  -- Order ID 8 includes 2 units of menu item 1
(9, 1, 2),  -- Order ID 9 includes 2 units of menu item 1
(10, 1, 2), -- Order ID 10 includes 2 units of menu item 1
(11, 1, 2); -- Order ID 11 includes 2 units of menu item 1
