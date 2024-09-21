select c.Id, c.CustomerName, count(o.id) as number from Customer C join orders O on c.id = o.CustomerID
group by c.id, c.CustomerName,o.CustomerID
having count(o.id) =(
	select max(total)as total1 from (select count(id) total from Orders group by CustomerID)
	as rs
)