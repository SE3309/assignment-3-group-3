-- Use the selected database
USE restaurant_schema;

-- View 1 for question 7: Create a view to summarize customer reservations
CREATE VIEW CustomerReservations AS
SELECT 
    Customer.name AS CustomerName,  -- Retrieve the customer's name
    Reservation.headCount,         -- Retrieve the headcount for the reservation
    Reservation.date AS ReservationDate  -- Retrieve the date of the reservation
FROM Customer
JOIN Reservation ON Customer.customerID = Reservation.customerID;
-- This view provides a consolidated summary of customer reservations, combining the Customer and Reservation tables.

-- View 2 for question 7: Create a view to summarize order details
CREATE VIEW OrderDetailsSummary AS
SELECT 
    Menu.name AS MenuItem,               -- Retrieve the name of the menu item
    SUM(OrderDetail.quantity) AS TotalQuantity  -- Calculate the total quantity ordered for each menu item
FROM OrderDetail
JOIN Menu ON OrderDetail.menuID = Menu.menuID
GROUP BY Menu.name;
-- This view provides a summary of order details, showing the total quantity ordered for each menu item.

-- Query the CustomerReservations view to retrieve the first 5 rows
SELECT * FROM CustomerReservations LIMIT 5;
-- This query retrieves a sample of the data from the CustomerReservations view, limiting it to 5 rows for demonstration purposes.

-- Query the OrderDetailsSummary view to retrieve the first 5 rows
SELECT * FROM OrderDetailsSummary LIMIT 5;
-- This query retrieves a sample of the data from the OrderDetailsSummary view, limiting it to 5 rows for demonstration purposes.

-- Attempt to insert a record into the CustomerReservations view
INSERT INTO CustomerReservations (CustomerName, HeadCount, ReservationDate)
VALUES ('New Customer', 3, '2024-01-20');
-- This operation will fail because `CustomerReservations` is a view, and views are not inherently updatable.
-- Any attempt to insert, update, or delete data directly in the view will result in an error unless the view is explicitly designed to allow such operations (e.g., using `WITH CHECK OPTION`).

-- Attempt to insert a record into the OrderDetailsSummary view
INSERT INTO OrderDetailsSummary (MenuItem, TotalQuantity)
VALUES ('New Dish', 15);
-- This operation will fail because `OrderDetailsSummary` is a view.
-- Views are derived from underlying tables and are not meant for direct data manipulation unless they are specifically designed for it.
