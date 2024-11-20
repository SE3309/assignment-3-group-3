-- CREATE DATABASE restaurant_schema;

-- USE restaurant_schema;

-- CREATE TABLE Menu
--  ( menuID INT NOT NULL AUTO_INCREMENT,
--  name VARCHAR(30) NOT NULL,
--  price DECIMAL(4, 2) NOT NULL,
--  PRIMARY KEY (menuID) );

-- CREATE TABLE Staff
--  ( staffID INT NOT NULL AUTO_INCREMENT,
--  jobTitle VARCHAR(30) NOT NULL,
--  name VARCHAR(30) NOT NULL,
--  wage DECIMAL(4, 2) NOT NULL,
--  hireDate DATE NOT NULL,
--  PRIMARY KEY (staffID) );

-- CREATE TABLE Admin
--  ( adminID INT NOT NULL AUTO_INCREMENT,
--  name VARCHAR(30) NOT NULL,
--  password VARCHAR(255) NOT NULL,
--  email VARCHAR(255) NOT NULL,
--  role VARCHAR(30) NOT NULL,
--  PRIMARY KEY (adminID) );

-- CREATE TABLE Customer
--  ( customerID INT NOT NULL AUTO_INCREMENT,
--  name VARCHAR(30) NOT NULL,
--  email VARCHAR(255) NOT NULL,
--  firstDateOfVisit DATE NOT NULL,
--  PRIMARY KEY (customerID) );

-- CREATE TABLE Reservation
--  ( reservationID INT NOT NULL AUTO_INCREMENT,
--  customerID INT NOT NULL,
--  headCount INT NOT NULL,
--  date DATE NOT NULL,
--  PRIMARY KEY (reservationID),
--  FOREIGN KEY (customerID) REFERENCES Customer(customerID) );

-- CREATE TABLE Expense
--  ( expenseID INT NOT NULL AUTO_INCREMENT,
--  adminID INT NOT NULL,
--  expenseAmount DECIMAL(4, 2) NOT NULL,
--  date DATE NOT NULL,
--  type VARCHAR(30) NOT NULL,
--  description VARCHAR(255) NOT NULL,
--  PRIMARY KEY (expenseID),
--  FOREIGN KEY (adminID) REFERENCES Admin(adminID) );

-- CREATE TABLE CustomerOrder
--  ( customerOrderID INT NOT NULL AUTO_INCREMENT,
--  customerID INT NOT NULL,
--  staffID INT NOT NULL,
--  date DATE NOT NULL,
--  PRIMARY KEY (customerOrderID),
--  FOREIGN KEY (customerID) REFERENCES Customer(customerID),
--  FOREIGN KEY (staffID) REFERENCES Staff(staffID)
--  );

-- CREATE TABLE OrderDetail (
--     orderDetailID INT NOT NULL AUTO_INCREMENT,
--     customerOrderID INT NOT NULL,
--     menuID INT NOT NULL,
--     quantity INT NOT NULL,
--     PRIMARY KEY (orderDetailID),
--     FOREIGN KEY (customerOrderID) REFERENCES CustomerOrder(customerOrderID),
--     FOREIGN KEY (menuID) REFERENCES Menu(menuID),
--     UNIQUE (customerOrderID, menuID)
-- );


-- DESCRIBE Menu;
-- DESCRIBE Staff;
-- DESCRIBE Admin;
-- DESCRIBE Customer;
-- DESCRIBE Reservation;
-- DESCRIBE Expense;
-- DESCRIBE CustomerOrder;
-- DESCRIBE OrderDetail;



-- using basic insert Statement
-- INSERT INTO Menu (name, price) 
-- VALUES ('Classic Burger', 8.99);



-- Use INSERT with Subquery
-- INSERT INTO Menu (name, price)
-- SELECT CONCAT(name, ' Combo'), price + 3
-- FROM Menu
-- WHERE name = 'Classic Burger';





-- INSERT with Computed or Generated Values 
-- INSERT INTO Menu (name, price) 
-- VALUES (CONCAT('Special ', 'Pasta'), ROUND(14.257, 2));


-- SELECT Customer.name AS CustomerName, Reservation.date AS ReservationDate
-- FROM Customer
-- JOIN Reservation ON Customer.customerID = Reservation.customerID
-- ORDER BY Reservation.date DESC;


-- Temporarily disable foreign key checks
-- SET FOREIGN_KEY_CHECKS = 0;





-- INSERT INTO Admin (name, password, email, role)
-- VALUES 
-- ('Alice Admin', 'securepass1', 'alice.admin@example.com', 'Manager'),
-- ('Bob Admin', 'securepass2', 'bob.admin@example.com', 'Staff');


-- INSERT INTO Expense (adminID, expenseAmount, date, type, description)
-- VALUES
-- (1, 200.50, '2024-01-10', 'Supplies', 'Purchased kitchen supplies'),
-- (2, 500.00, '2024-01-15', 'Maintenance', 'HVAC system repair');

-- INSERT INTO CustomerOrder (customerID, staffID, date)
-- VALUES
-- (1, 1, '2024-01-20'),
-- (2, 2, '2024-01-21'),
-- (15, 2, '2024-01-21'),
-- (25, 3, '2024-01-22'),
-- (4, 2, '2024-01-24'),
-- (6, 4, '2024-01-21'),x
-- (100, 4, '2024-02-05'),
-- (15, 2, '2024-02-09'),
-- (14, 1, '2024-02-09'),
-- (200, 5, '2024-02-09');


-- INSERT INTO OrderDetail (customerOrderID, menuID, quantity)
-- VALUES
-- (1, 1, 2),  -- Order for 2 units of "Dish 1"
-- (1, 2, 1),  -- Order for 1 unit of "Dish 2"
-- (2, 1, 3);  -- Order for 3 units of "Dish 1"


-- Add more orders for menuID 1
-- INSERT INTO OrderDetail (customerOrderID, menuID, quantity)
-- VALUES
-- (5,1,1),
-- (6,1,2),
-- (7,1,2),
-- (8,1,2),
-- (9,1,2),
-- (10,1,2),
-- (11,1,2);





-- QUESTION 5 query 1
-- SELECT Customer.name AS CustomerName, Reservation.date AS ReservationDate
-- FROM Customer
-- JOIN Reservation ON Customer.customerID = Reservation.customerID
-- LIMIT 5;



-- QUESTION 5 Query 2
-- SELECT name AS MenuItem, price
-- FROM Menu
-- WHERE menuID IN (
--     SELECT DISTINCT menuID
--     FROM OrderDetail
-- )



-- QUESTION 5 query 3
-- SELECT Menu.name AS MenuItem, SUM(OrderDetail.quantity * Menu.price) AS TotalRevenue
-- FROM OrderDetail
-- JOIN Menu ON OrderDetail.menuID = Menu.menuID
-- GROUP BY Menu.name
-- ORDER BY TotalRevenue DESC


-- question 5 query 4
-- SELECT Staff.name AS StaffName, Staff.jobTitle
-- FROM Staff
-- WHERE EXISTS (
--     SELECT 1
--     FROM CustomerOrder
--     WHERE CustomerOrder.staffID = Staff.staffID
-- )
--  


-- question 5 query 5
-- SELECT C1.name AS Customer1, C2.name AS Customer2, C1.firstDateOfVisit
-- FROM Customer C1
-- JOIN Customer C2 ON C1.firstDateOfVisit = C2.firstDateOfVisit AND C1.customerID < C2.customerID
-- LIMIT 5;


-- question 5 query 6
-- SELECT Menu.name AS MenuItem, SUM(OrderDetail.quantity) AS TotalQuantity
-- FROM OrderDetail
-- JOIN Menu ON OrderDetail.menuID = Menu.menuID
-- GROUP BY Menu.name
-- HAVING TotalQuantity > 10
-- ORDER BY TotalQuantity DESC


-- question 5 query 7

-- SELECT 
--     Customer.name AS CustomerName,
--     Staff.name AS StaffName,
--     SUM(OrderDetail.quantity * Menu.price) AS TotalSpent
-- FROM CustomerOrder
-- JOIN Customer ON CustomerOrder.customerID = Customer.customerID
-- JOIN Staff ON CustomerOrder.staffID = Staff.staffID
-- JOIN OrderDetail ON CustomerOrder.customerOrderID = OrderDetail.customerOrderID
-- JOIN Menu ON OrderDetail.menuID = Menu.menuID
-- GROUP BY Customer.name, Staff.name
-- ORDER BY TotalSpent DESC

-- alterting table so expense amount can be larger than 99.99
-- ALTER TABLE Expense
-- MODIFY COLUMN expenseAmount DECIMAL(7,2);



-- question 6 query 1
-- INSERT INTO Expense (adminID, expenseAmount, date, type, description)
-- SELECT 
--     1,  -- adminID
--     headCount * 10.00 AS expenseAmount,  -- Calculate expense per reservation
--     date, 
--     'Reservation Expense', 
--     CONCAT('Headcount: ', headCount)
-- FROM Reservation
-- WHERE headCount > 5;


-- altering table so staff wages can be larger than 99.99
-- ALTER TABLE Staff
-- MODIFY COLUMN wage DECIMAL(6,2);

-- question 6 query 2
-- UPDATE Staff
-- SET wage = wage * 1.10
-- WHERE jobTitle = 'Server';


-- DELETE FROM Reservation
-- WHERE date < '2024-01-01'
--   AND customerID NOT IN (
--       SELECT DISTINCT customerID
--       FROM CustomerOrder
--   );



-- View 1 for question 7
-- CREATE VIEW CustomerReservations AS
-- SELECT 
--     Customer.name AS CustomerName,
--     Reservation.headCount,
--     Reservation.date AS ReservationDate
-- FROM Customer
-- JOIN Reservation ON Customer.customerID = Reservation.customerID;

 


-- View 2 for question 7
-- CREATE VIEW OrderDetailsSummary AS
-- SELECT 
--     Menu.name AS MenuItem,
--     SUM(OrderDetail.quantity) AS TotalQuantity
-- FROM OrderDetail
-- JOIN Menu ON OrderDetail.menuID = Menu.menuID
-- GROUP BY Menu.name;



-- querying CustomerReservations
-- SELECT * FROM CustomerReservations LIMIT 5;

-- querying OrderDetailsSumary
-- SELECT * FROM OrderDetailsSummary LIMIT 5;



-- Attempt ot insert a tuple into customerReservation
-- INSERT INTO CustomerReservations (CustomerName, HeadCount, ReservationDate)
-- VALUES ('New Customer', 3, '2024-01-20');


-- attempt to inserting a tuple into OrderDetailsSummary
-- INSERT INTO OrderDetailsSummary (MenuItem, TotalQuantity)
-- VALUES ('New Dish', 15);





SELECT * FROM CUSTOMER;









