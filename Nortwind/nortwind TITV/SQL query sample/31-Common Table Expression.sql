--Common Table Expression (CTE) là một tính năng trong SQL Server 
--cho phép bạn tạo ra một bảng kết quả tạm thời mà bạn có thể tham chiếu
--bên trong một câu truy vấn lớn hơn. 

-- Lợi ích:
--	+ Giúp câu truy vấn dễ hiểu, dễ đọc
--	+ Tái sử dụng dc
--	+ Tăng hiệu suất 


-- Ví dụ
WITH bangTamThoi AS (
	SELECT [EmployeeID], [LastName], [FirstName]
	FROM [dbo].[Employees]
),
bangTamThoiSo2 AS (
	SELECT [ProductID]
	FROM [dbo].[Products]
)
SELECT *
FROM bangTamThoi;

-- Lấy thông tin về các sản phẩm (Products) có cùng thể loại với một sản phẩm cụ thể
WITH ProductCategory AS(
	SELECT [ProductName],[CategoryID]
	FROM [dbo].[Products]
	WHERE [ProductName]='Chai'
)
SELECT P.[ProductName],P.[CategoryID]
FROM [dbo].[Products] as P
JOIN ProductCategory as PC 
ON P.CategoryID=PC.CategoryID;

-- Lấy thông tin về đơn hàng (Orders) cùng với tổng giá trị đơn hàng
-- và tỉ lệ giữa tổng giá trị/phí giao hàng

--	Cách 1: CTE
WITH OrderTotals AS ( 
	SELECT [OrderID], SUM([UnitPrice]*[Quantity]) AS TotalPrice
	FROM [dbo].[Order Details]
	GROUP BY [OrderID]
) 
SELECT o.[OrderID], o.[OrderDate], o.[Freight], ot.TotalPrice, 
ot.TotalPrice/o.Freight AS Ratio
FROM [dbo].[Orders] o
JOIN OrderTotals ot ON o.OrderID=ot.OrderID;

select  * from [dbo].[Orders]


-- Cách 2: Cách bình thường với JOIN + GROUP BY 
SELECT o.OrderID, o.[Freight], SUM ([UnitPrice]*[Quantity]) AS TotalPrice, 
		SUM ([UnitPrice]*[Quantity])/o.Freight AS Ratio
FROM [dbo].[Orders] o
JOIN [dbo].[Order Details] od ON o.OrderID= od.OrderID
GROUP BY  o.OrderID, o.[Freight];

-- Cách 3: Subquery
SELECT o.OrderID,
		o.Freight,
		(	SELECT SUM([UnitPrice]*[Quantity]) 
			FROM [dbo].[Order Details] od
			WHERE od.OrderID = o.OrderID
		) as TotalPrice,
		(TotalPrice/o.Freight) -- lỗi:  trying to reference the alias TotalPrice directly in the SELECT clause before it has been calculated. 
		-- nếu muốn hết lỗi thì phải dùng câu subquery 2 lần, nếu table có triệu dòng thì slowwwwww!
		-- tránh viết subquery ở SELECT vì cực kì tệ               
FROM [dbo].[Orders] o





---------------------------------- BÀI TẬP ----------------------------------
-- 1. Sử dụng CTE tính tổng doanh số bán hàng cho từng sản phẩm từ 2 bảng "Order Details" và "Product"
WITH RevenuePerProduct AS (
	SELECT od.ProductID, SUM(od.Quantity*od.UnitPrice) AS TotalPrice
	FROM [dbo].[Order Details] od
	GROUP BY od.ProductID
)
SELECT p.ProductID, p.ProductName, r.TotalPrice
FROM [dbo].[Products] p
INNER JOIN RevenuePerProduct r ON r.ProductID = p.ProductID;

-- 2. Sử dụng CTE để tính toán tổng doanh số bán hàng theo từng khách hàng và sau đó sắp xếp danh sách 
-- khách hàng theo tổng doanh số giảm dần
WITH RevenuePerCustomer AS (
	SELECT o.CustomerID, SUM(od.UnitPrice * od.Quantity) as TotalPrice
	FROM [dbo].[Orders] o
	INNER JOIN [dbo].[Order Details] od  ON o.OrderID = od.OrderID
	GROUP BY o.CustomerID
	)
SELECT c.CustomerID, c.ContactName, r.TotalPrice
FROM [dbo].[Customers] c
INNER JOIN  RevenuePerCustomer r  ON  c.CustomerID = r.CustomerID
ORDER BY r.TotalPrice

-- 3. Sử dụng CTE tính tổng doanh số bán hàng theo năm từ bảng "Orders" và "Order Details"
select * from [dbo].[Orders]
select * from [dbo].[Order Details]

WITH OrderTotals AS (
	SELECT OrderID, SUM([UnitPrice]*[Quantity]) AS TotalPrice
	FROM [dbo].[Order Details] od
	GROUP BY [OrderID] -- tính tổng doanh thu cho từng orderID
)
SELECT YEAR(OrderDate) as YEAR, SUM(ot.TotalPrice) as TOTAL
FROM [dbo].[Orders] o
INNER JOIN OrderTotals ot ON o.OrderID = ot.OrderID
GROUP BY YEAR(OrderDate)

