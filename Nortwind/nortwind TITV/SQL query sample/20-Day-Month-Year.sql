-- month  , day , year function
SELECT YEAR('1996-08-04') as YEAR
SELECT MONTH('1996-08-04') as MONTH
SELECT DAY('1996-08-04') as DAY

-- Tính số lượng đơn đặt hàng trong năm 1997 của từng khách hàng?
SELECT [CustomerID], 
	COUNT([OrderID]) as [TotalOrders],
	YEAR([OrderDate]) as [Year]
FROM [dbo].[Orders]
WHERE YEAR([OrderDate])= 1997
GROUP BY [CustomerID], YEAR([OrderDate]);

-- Hãy lọc ra các đơn hàng được đặt hàng vào tháng 5 năm 1997.
SELECT *
FROM [dbo].[Orders]
WHERE MONTH([OrderDate])=5 AND YEAR([OrderDate])=1997;

-- Lấy danh sách các đơn hàng được đặt vào ngày 4 tháng 8 năm 1997.
SELECT *
FROM [dbo].[Orders]
WHERE DAY([OrderDate])=4 AND MONTH([OrderDate])=8 AND YEAR([OrderDate])=1997;

SELECT *
FROM [dbo].[Orders]
WHERE [OrderDate]='1997-08-04';


-- Lấy danh sách khách hàng đặt hàng trong năm 1998 
-- và số đơn hàng mỗi tháng, sắp xếp tháng tăng dần.
SELECT [CustomerID], MONTH([OrderDate]) as [Month], COUNT(*) AS [TotalOrders]
FROM [dbo].[Orders]
WHERE  YEAR([OrderDate])=1998
GROUP BY [CustomerID], MONTH([OrderDate])
ORDER BY MONTH([OrderDate]) ASC;


