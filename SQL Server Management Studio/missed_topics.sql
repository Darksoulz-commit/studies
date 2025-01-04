create database mt;

use mt

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    City VARCHAR(50)
);

-- Insert values into Customers table
INSERT INTO Customers (CustomerID, City) VALUES
(1, 'Chennai'),
(2, 'Delhi'),
(3, 'Mumbai'),
(4, 'Bangalore'),
(5, 'Mumbai');  -- Duplicate

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    City VARCHAR(50)
);

-- Insert values into Suppliers table
INSERT INTO Suppliers (SupplierID, City) VALUES
(1, 'Kolkata'),
(2, 'Chennai'),  -- Duplicate
(3, 'Hyderabad'),
(4, 'Pune'),
(5, 'Mumbai');  -- Duplicate

SELECT * FROM Customers;
SELECT * FROM Suppliers;


SELECT city from Customers
EXCEPT
SELECT city from Suppliers
order by city;


