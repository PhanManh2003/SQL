-- Liet ke cac don hang co 
-- ngay dat hang gan nhat
SELECT * 
FROM [dbo].[Orders] o
WHERE o.OrderDate = (
	SELECT MAX([OrderDate])
	FROM [dbo].[Orders]
);

-- Liệt kê tất cả các sản phẩm (ProductName)
-- mà không có đơn đặt hàng nào đặt mua chúng.
SELECT *
FROM [dbo].[Products] p
WHERE p.ProductID NOT IN (
	SELECT DISTINCT [ProductID]
	FROM [dbo].[Order Details]
);

-- Lấy thông tin về các đơn hàng, và tên các sản phẩm 
-- thuộc các đơn hàng chưa được giao cho khách.
SELECT o.OrderID, p.ProductName
FROM [dbo].[Orders] o
INNER JOIN [dbo].[Order Details] od
ON o.OrderID = od.OrderID
INNER JOIN [dbo].[Products] p
ON od.ProductID = p.ProductID
WHERE o.OrderID IN (
			SELECT [OrderID]
			FROM [dbo].[Orders]
			WHERE [ShippedDate] IS NULL);

-- Lấy thông tin về các sản phẩm có số lượng tồn kho 
--- ít hơn số lượng tồn kho trung bình của tất cả các sản phẩm
SELECT *
FROM [dbo].[Products] p
WHERE p.UnitsInStock>(
	SELECT AVG([UnitsInStock])
	FROM [dbo].[Products]);


-- Lấy thông tin về khách hàng có tổng giá trị đơn hàng lớn nhất
-- 1. Lấy tổng giá trị đơn hàng lớn nhất : 
  SELECT MAX(TotalOrderValue)
        FROM (
            SELECT SUM(od2.UnitPrice * od2.Quantity) AS TotalOrderValue
            FROM [dbo].[Orders] o2
            INNER JOIN [dbo].[Order Details] od2 ON o2.OrderID = od2.OrderID
            GROUP BY o2.CustomerID
        ) AS Subquery
			-- Chú ý: Không thể viết MAX(SUM(..)) vì sql ko cho lồng aggregate function
-- 2. Hoàn thành câu truy vấn
SELECT 
    c.CustomerID, 
    SUM(od.UnitPrice * od.Quantity) AS TotalOrderValue
FROM 
    [dbo].[Customers] c
INNER JOIN 
    [dbo].[Orders] o ON c.CustomerID = o.CustomerID
INNER JOIN 
    [dbo].[Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID
HAVING 
    SUM(od.UnitPrice * od.Quantity) = (
        SELECT MAX(TotalOrderValue)
        FROM (
            SELECT SUM(od2.UnitPrice * od2.Quantity) AS TotalOrderValue
            FROM [dbo].[Orders] o2
            INNER JOIN [dbo].[Order Details] od2 ON o2.OrderID = od2.OrderID
            GROUP BY o2.CustomerID
        ) AS Subquery
    );


	-- 1 khách hàng có nhiều orderID, 1 order ID có nhiều Product với số lượng và đơn giá khác nhau
select * from dbo.[Order Details]
select * from [dbo].[Customers] 
select * from [dbo].[Orders]