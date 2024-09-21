select t.ID, t.ProductName, t.UnitPrice,t.SubCategoryID
from (
	select t.*, rank()over(order by UnitPrice desc)r_low,
	rank() over(order by Unitprice asc) r_high from product t)t
	where r_high <= 5 or r_low<= 5
	order by r_high desc, r_low desc