
insert into dbo.Category(CategoryName) values ('Sports')
declare @x int
select @x = dbo.Category.ID from dbo.Category where CategoryName = 'Sports'
insert into dbo.SubCategory(SubCategoryName,CategoryID)
values 
('Tennis',@x),
('Football',@x)