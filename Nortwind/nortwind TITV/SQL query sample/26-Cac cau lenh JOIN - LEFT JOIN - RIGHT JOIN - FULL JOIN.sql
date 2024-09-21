--To understand this easily, think of a Cartesian product table D between two tables A and 
--B. With an inner join, we select only the rows that have matching values in both A and 
--B in D. With a left join, we start with the rows from the inner join and then add 
--any additional rows from A to include all values of the primary key in A.


--1.Sử dụng INNER JOIN
--Từ bảng Products và Categories, hãy in ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Mã sản phẩm
--Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;


--2.Sử dụng INNER JOIN
--Từ bảng Products và Categories, hãy đưa ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Số lượng sản phẩm
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) as [TotalProduct]
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

--3.Sử dụng INNER JOIN, hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên công ty khách hàng
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

--4.Sử dụng INNER JOIN, LEFT JOIN
--Từ bảng Products và Categories, hãy đưa ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS [TotalProduct]
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;

SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS [TotalProduct]
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName;


--5. Sử dụng RIGHT JOIN, hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên công ty khách hàng
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID;

SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID 

-- RIGHT JOIN trên giống hệt với  LEFT JOIN này
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Customers] c
LEFT JOIN  [dbo].[Orders] o
ON o.CustomerID = c.CustomerID 

-- check difference record between inner join and right join
SELECT o.OrderID, c.CompanyName
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID 
WHERE o.OrderID is null
-----------------------------------------------------

SELECT  c.CompanyName, COUNT(o.OrderID)
FROM [dbo].[Orders] o
RIGHT JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

SELECT  c.CompanyName, COUNT(o.OrderID)
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Customers] c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

--6. Sử dụng FULL OUTER JOIN
--Từ bảng Products và Categories, hãy in ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Mã sản phẩm
--Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
FULL JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo].[Products] p
ON c.CategoryID = p.CategoryID;

--7. TÍCH DESCARTES VỚI CROSS JOIN
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
CROSS JOIN [dbo].[Products] p; -- 780 rows

-- KIỂM TRA TÍCH DESCARTES
SELECT * FROM [dbo].[Categories] ; -- 10 rows
SELECT * FROM [dbo].[Products];  -- 78 rows

--8. SELF JOIN: A self join is a regular join, but the table is joined with itself.

-- Ví dụ: ghép cặp các khách hàng ở cùng 1 thành phố để gặp mặt.
SELECT A.ContactName AS CustomerName1, B.ContactName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;

-- Cách 2
SELECT A.ContactName AS CustomerName1, B.ContactName AS CustomerName2, A.City
FROM Customers A CROSS JOIN Customers B 
WHERE A.CustomerID <> B.CustomerID AND A.City = B.City 
ORDER BY A.City;