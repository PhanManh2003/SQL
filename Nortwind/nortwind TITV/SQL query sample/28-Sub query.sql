--***Subquery (truy vấn con ) là 1 truy vấn SELECT  dc viết bên trong 1 truy vấn
--SELECT, INSERT, UPDATE hoặc DELETE khác. 
-- Subquery có thể xuất hiện sau SELECT , FROM hoặc WHERE

--***Tác dụng :Subquery hoạt động như 1 bảng ảo tạm thời để cung cấp dữ liệu cho 
--câu truy vấn hiện tại

--1. Liet ke ra toan bo san pham
SELECT  [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products];

-- Tim gia trung binh cua cac san pham
SELECT AVG([UnitPrice])
FROM [dbo].[Products];

-- Loc nhung san pham co gia > gia trung binh
SELECT  [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products]
WHERE [UnitPrice] > 28.4962;

-- Sub query
SELECT  [ProductID], [ProductName], [UnitPrice]
FROM [dbo].[Products]
WHERE [UnitPrice] > (
	SELECT AVG([UnitPrice])
	FROM [dbo].[Products]
);

--2. Lọc ra những khách hàng có số đơn hàng > 10
SELECT c.CustomerID, c.CompanyName, count(o.OrderId) as [TotalOrders]
FROM [dbo].[Customers] c
LEFT JOIN [dbo].[Orders] o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING count(o.OrderId) > 10;

-- Sub query ( ko cần join 2 bảng )
SELECT *
FROM [dbo].[Customers]
WHERE [CustomerID] IN (
		SELECT o.CustomerID
		FROM [dbo].[Orders] o
		GROUP BY CustomerID
		HAVING COUNT(OrderId) > 10 -- ko cần select COUNT mà HAVING vẫn hoạt động dc
);

--3. Tính tổng tiền cho từng đơn hàng
SELECT o.*, (
		SELECT SUM(od.Quantity*od.UnitPrice)
		FROM [dbo].[Order Details] od
		WHERE od.OrderID = o.OrderID
	) AS [Total]
FROM [dbo].[Orders] o;

select * from dbo.[Order Details]

-- LỌC RA TÊN SP VÀ TỔNG SỐ ĐƠN HÀNG CỦA TỪNG SẢN PHẨM 
--( subquery sau FROM thì thường là bảng ảo đã có kết quả cuối cùng)
SELECT ProductName, TotalOrders
FROM	
			(SELECT p.ProductID, p.ProductName, (
				SELECT COUNT(*)
				FROM [dbo].[Order Details] od
				WHERE od.ProductID = p.ProductID
			) as [TotalOrders] FROM [dbo].[Products] p) AS TempTable;


-- Bài tập: In ra mã đơn hàng và số lượng sản phẩm khác nhau của đơn hàng
SELECT o.OrderID, 
	( SELECT  COUNT(od.ProductID) 
	FROM [dbo].[Order Details] od 
	WHERE od.OrderID = o.OrderID	) AS TotalProduct
FROM [dbo].[Orders] o


	-- Cách 2: 
SELECT od.OrderID , COUNT(p.ProductID) AS TotalProduct 
FROM [Order Details] AS od , Products AS p
WHERE od.ProductID = p.ProductID
GROUP BY od.OrderID 