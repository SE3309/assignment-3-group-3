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

-- Inserts a new Reservation for a customer who has the highest total spending, using aggregated data from multiple tables. 
INSERT INTO Reservation (customerID, headCount, date) 
SELECT  
    customerID,  
    4,  -- Assumes a default headcount of 4 
    CURDATE()  -- Uses the current date for the reservation 
FROM ( 
    SELECT Customer.customerID, SUM(OrderDetail.quantity * Menu.price) AS TotalSpending 
    FROM Customer 
    JOIN CustomerOrder ON Customer.customerID = CustomerOrder.customerID 
    JOIN OrderDetail ON CustomerOrder.customerOrderID = OrderDetail.customerOrderID 
    JOIN Menu ON OrderDetail.menuID = Menu.menuID 
    GROUP BY Customer.customerID 
    ORDER BY TotalSpending DESC 
    LIMIT 1 
) AS TopSpender; 

-- Insert reservations for customers who have made more than three previous reservations: 
INSERT INTO Reservation (customerID, headCount, date) 
SELECT  
    customerID, 
    2,  -- Default headcount for new reservations 
    CURDATE() + INTERVAL 7 DAY  -- Reservation date is 7 days from today 
FROM ( 
    SELECT customerID, COUNT(*) AS ReservationCount 
    FROM Reservation 
    GROUP BY customerID 
    HAVING ReservationCount > 3 
) AS FrequentCustomers;  

-- Insert Expenses Based on Large Orders 
INSERT INTO Expense (adminID, expenseAmount, date, type, description) 
SELECT  
    1,  -- Assign expense to adminID 1 
    SUM(OrderDetail.quantity * Menu.price) AS TotalOrderCost, 
    CustomerOrder.date, 
    'Large Order Expense', 
    CONCAT('Order ID: ', CustomerOrder.customerOrderID) 
FROM CustomerOrder 
JOIN OrderDetail ON CustomerOrder.customerOrderID = OrderDetail.customerOrderID 
JOIN Menu ON OrderDetail.menuID = Menu.menuID 
GROUP BY CustomerOrder.customerOrderID, CustomerOrder.date 
HAVING TotalOrderCost > 100; 

-- Insert Menu Items for Each Admin's Top Expense Category 
INSERT INTO Menu (name, price) 
SELECT  
    CONCAT(type, ' Special'), 
    AVG(expenseAmount) * 0.8  -- Promotional price based on average expense amount 
FROM Expense 
WHERE adminID IN (SELECT adminID FROM Admin) 
GROUP BY adminID, type 
HAVING AVG(expenseAmount) = ( 
    SELECT MAX(avgExpense) 
    FROM ( 
        SELECT adminID, type, AVG(expenseAmount) AS avgExpense 
        FROM Expense 
        GROUP BY adminID, type 
    ) AS AdminExpense 
    WHERE AdminExpense.adminID = Expense.adminID 
); 

-- Insert Customer Orders for Reservations Without Existing Orders 
INSERT INTO CustomerOrder (customerID, staffID, date) 
SELECT  
    Reservation.customerID, 
    (SELECT staffID FROM Staff WHERE jobTitle = 'Server' ORDER BY RAND() LIMIT 1),  -- Randomly assigns a server 
    Reservation.date 
FROM Reservation 
WHERE NOT EXISTS ( 
    SELECT 1 
    FROM CustomerOrder 
    WHERE CustomerOrder.customerID = Reservation.customerID 
      AND CustomerOrder.date = Reservation.date 
); 

-- Insert Order Details for Menu Items Based on Popularity 
INSERT INTO OrderDetail (customerOrderID, menuID, quantity) 
SELECT  
    (SELECT customerOrderID FROM CustomerOrder ORDER BY RAND() LIMIT 1),  -- Randomly selects an existing customer order 
    Menu.menuID, 
    5  -- Default quantity for popular items 
FROM ( 
    SELECT menuID, SUM(quantity) AS TotalOrdered 
    FROM OrderDetail 
    GROUP BY menuID 
    ORDER BY TotalOrdered DESC 
    LIMIT 3 
) AS PopularItems 
JOIN Menu ON Menu.menuID = PopularItems.menuID; 

-- Insert Staff Bonuses Based on Customer Spending 
INSERT INTO Expense (adminID, expenseAmount, date, type, description) 
SELECT  
    1,  -- Assign expense to adminID 1 
    50.00,  -- Fixed bonus amount 
    CURDATE(), 
    'Staff Bonus', 
    CONCAT('Bonus for ', Staff.name) 
FROM Staff 
WHERE staffID IN ( 
    SELECT CustomerOrder.staffID 
    FROM CustomerOrder 
    JOIN OrderDetail ON CustomerOrder.customerOrderID = OrderDetail.customerOrderID 
    JOIN Menu ON OrderDetail.menuID = Menu.menuID 
    GROUP BY CustomerOrder.staffID 
    HAVING SUM(OrderDetail.quantity * Menu.price) > 500 
); 

 

