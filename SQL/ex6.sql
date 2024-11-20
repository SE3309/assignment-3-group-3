-- Use the selected database
USE restaurant_schema;

-- QUESTION 6 query 1: Insert calculated expenses for reservations with headcount greater than 5
INSERT INTO Expense (adminID, expenseAmount, date, type, description)
SELECT 
    1,  -- Assign the expense to adminID 1
    headCount * 10.00 AS expenseAmount,  -- Calculate expense as $10.00 per person for the reservation
    date,  -- Use the reservation date as the expense date
    'Reservation Expense',  -- Set the type of expense
    CONCAT('Headcount: ', headCount)  -- Add a description with the headcount
FROM Reservation
WHERE headCount > 5;
-- This query calculates and logs expenses in the Expense table for reservations where the headcount exceeds 5.
-- It uses a SELECT statement within the INSERT to dynamically calculate the expense amount and description.

-- QUESTION 6 query 2: Update wages for staff members with the job title 'Server'
UPDATE Staff
SET wage = wage * 1.10  -- Increase wage by 10%
WHERE jobTitle = 'Server';
-- This query updates the wage for all staff members whose job title is 'Server'.
-- It applies a 10% wage increase by multiplying the current wage by 1.10.

-- QUESTION 6 query 3: Delete old reservations for customers without orders
DELETE FROM Reservation
WHERE date < '2024-01-01'  -- Only consider reservations made before January 1, 2024
  AND customerID NOT IN (  -- Ensure the reservation belongs to a customer without any orders
      SELECT DISTINCT customerID
      FROM CustomerOrder
  );
-- This query removes old reservations (before 2024-01-01) where the customer has not placed any orders.
-- The `NOT IN` subquery checks for customers who do not appear in the CustomerOrder table.
