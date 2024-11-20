-- Create the database
CREATE DATABASE restaurant_schema;

-- Use the created database
USE restaurant_schema;

-- Create the Menu table to store menu items
CREATE TABLE Menu (
    menuID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each menu item
    name VARCHAR(30) NOT NULL,          -- Name of the menu item
    price DECIMAL(4, 2) NOT NULL,       -- Price of the menu item
    PRIMARY KEY (menuID)                -- Set menuID as the primary key
);

-- Create the Staff table to store staff information
CREATE TABLE Staff (
    staffID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each staff member
    jobTitle VARCHAR(30) NOT NULL,       -- Job title of the staff member (e.g., Chef, Server)
    name VARCHAR(30) NOT NULL,           -- Name of the staff member
    wage DECIMAL(6, 2) NOT NULL,         -- Wage of the staff member
    hireDate DATE NOT NULL,              -- Date the staff member was hired
    PRIMARY KEY (staffID)                -- Set staffID as the primary key
);

-- Create the Admin table to store administrator information
CREATE TABLE Admin (
    adminID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each admin
    name VARCHAR(30) NOT NULL,           -- Name of the admin
    password VARCHAR(255) NOT NULL,      -- Password for the admin (hashed)
    email VARCHAR(255) NOT NULL,         -- Email of the admin
    role VARCHAR(30) NOT NULL,           -- Role of the admin (e.g., Manager)
    PRIMARY KEY (adminID)                -- Set adminID as the primary key
);

-- Create the Customer table to store customer information
CREATE TABLE Customer (
    customerID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each customer
    name VARCHAR(30) NOT NULL,              -- Name of the customer
    email VARCHAR(255) NOT NULL,            -- Email of the customer
    firstDateOfVisit DATE NOT NULL,         -- Date of the customer's first visit
    PRIMARY KEY (customerID)                -- Set customerID as the primary key
);

-- Create the Reservation table to store customer reservations
CREATE TABLE Reservation (
    reservationID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each reservation
    customerID INT NOT NULL,                   -- Customer who made the reservation
    headCount INT NOT NULL,                    -- Number of people for the reservation
    date DATE NOT NULL,                        -- Date of the reservation
    PRIMARY KEY (reservationID),              -- Set reservationID as the primary key
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) -- Foreign key linking to Customer table
);

-- Create the Expense table to track expenses
CREATE TABLE Expense (
    expenseID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each expense
    adminID INT NOT NULL,                  -- Admin responsible for the expense
    expenseAmount DECIMAL(7, 2) NOT NULL,  -- Amount of the expense
    date DATE NOT NULL,                    -- Date of the expense
    type VARCHAR(30) NOT NULL,             -- Type of the expense (e.g., Utilities, Supplies)
    description VARCHAR(255) NOT NULL,     -- Description of the expense
    PRIMARY KEY (expenseID),               -- Set expenseID as the primary key
    FOREIGN KEY (adminID) REFERENCES Admin(adminID) -- Foreign key linking to Admin table
);

-- Create the CustomerOrder table to store orders made by customers
CREATE TABLE CustomerOrder (
    customerOrderID INT NOT NULL AUTO_INCREMENT, -- Unique identifier for each customer order
    customerID INT NOT NULL,                     -- Customer who placed the order
    staffID INT NOT NULL,                        -- Staff member handling the order
    date DATE NOT NULL,                          -- Date of the order
    PRIMARY KEY (customerOrderID),              -- Set customerOrderID as the primary key
    FOREIGN KEY (customerID) REFERENCES Customer(customerID), -- Foreign key linking to Customer table
    FOREIGN KEY (staffID) REFERENCES Staff(staffID) -- Foreign key linking to Staff table
);

-- Create the OrderDetail table to store details of each order
CREATE TABLE OrderDetail (
    orderDetailID INT NOT NULL AUTO_INCREMENT,  -- Unique identifier for each order detail
    customerOrderID INT NOT NULL,              -- Order to which the detail belongs
    menuID INT NOT NULL,                       -- Menu item in the order
    quantity INT NOT NULL,                     -- Quantity of the menu item
    PRIMARY KEY (orderDetailID),               -- Set orderDetailID as the primary key
    FOREIGN KEY (customerOrderID) REFERENCES CustomerOrder(customerOrderID), -- Foreign key linking to CustomerOrder
    FOREIGN KEY (menuID) REFERENCES Menu(menuID), -- Foreign key linking to Menu table
    UNIQUE (customerOrderID, menuID)           -- Ensure a menu item appears only once per order
);

-- Describe the structure of each table
DESCRIBE Menu;
DESCRIBE Staff;
DESCRIBE Admin;
DESCRIBE Customer;
DESCRIBE Reservation;
DESCRIBE Expense;
DESCRIBE CustomerOrder;
DESCRIBE OrderDetail;
