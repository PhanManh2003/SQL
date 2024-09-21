
select C.ID, C.CustomerName,C.City, C.State from dbo.Customer  as C
inner join dbo.Orders as O on C.ID = O.CustomerID 
where O.ShipDate <= '20171210' and O.ShipDate >= '20171205'
order by C.State ASC, C.City DESC



