--A wildcard character is used to substitute one or more characters in a string.
/*
Symbol			Description
%		Represents zero or more characters
_		Represents a single character
[]		Represents any single character within the brackets *
^		Represents any character not in the brackets *
-		Represents any single character within the specified range *
*/

-- Hãy lọc ra tất cả các khách hàng có tên liên hệ bắt đầu bằng chữ ‘A’
SELECT *
FROM [dbo].[Customers]
WHERE [ContactName] LIKE 'A%';

-- Hãy lọc ra tất cả các khách hàng có tên liên hệ bắt đầu bằng chữ ‘H’
-- , và có chữ thứ 2 là bất kỳ ký tự nào.
SELECT *
FROM [dbo].[Customers]
WHERE [ContactName] LIKE 'H_%';

-- Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố 
-- có chữ cái bắt đầu là L, chữ cái thứ hai là u hoặc o.
SELECT [OrderID], [ShipCity]
FROM [dbo].[Orders]
WHERE [ShipCity] LIKE 'L[uo]%';

-- Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố 
-- có chữ cái bắt đầu là L, chữ cái thứ hai khong là u hoặc o.
SELECT [OrderID], [ShipCity]
FROM [dbo].[Orders]
WHERE [ShipCity] LIKE 'L[^uo]%';

-- Hãy lọc ra tất cả các đơn hang được gửi đến thành phố có 
-- chữ cái bắt đầu là L, chữ cái thứ hai là các ký tự từ a đến e.
SELECT [OrderID], [ShipCity]
FROM [dbo].[Orders]
WHERE [ShipCity] LIKE 'L[a-e]%';

-- Lấy ra tất cả các nhà cung cấp hàng có tên công ty bắt đầu bằng
-- chữ A và không chứa kí tự b
SELECT *
FROM [dbo].[Suppliers]
WHERE [CompanyName] LIKE 'A%[^b]%';
