-- Viết câu lệnh SQL lấy ra 05 dòng đầu tiên 
-- trong bảng Customers.
SELECT TOP 5 *
FROM [dbo].[Customers];


-- Viết câu lệnh SQL lấy ra 30% nhân viên 
-- của công ty hiện tại.
SELECT TOP 50 PERCENT *
FROM [dbo].[Employees];


--Viết câu lệnh SQL lấy ra các mã khách hàng trong bảng đơn hàng 
--với quy định là mã khách hàng không được trùng lặp, 
--chỉ lấy 5 dòng dữ liệu đầu tiên.
SELECT DISTINCT TOP 5 [CustomerID]
FROM [dbo].[Orders];

select * from dbo.Employees;