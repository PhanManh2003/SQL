
create trigger InsertSubCategory
on dbo.subcategory
for insert 
as 
begin
	select * from inserted where SubCategoryName in (inserted.SubCategoryName )
end

