											-- JOIN OPERATIONS
SELECT * FROM Customers
SELECT * FROM Orders

--  The INNER JOIN keyword selects all rows from both tables as long as there is a match between the columns. 
SELECT * FROM Customers INNER JOIN Orders ON Customers.CustomerID = ORDERS.CustomerID

-- The LEFT JOIN keyword returns all records from the left table (Customers), even if there are no matches in the right table (Orders).
SELECT * FROM Customers FULL JOIN ORDERS ON Customers.CustomerID = ORDERS.CustomerID