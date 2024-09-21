select * from dbo.Customer
select * from dbo.Category
select * from dbo.SubCategory
select * from dbo.Orders
select * from dbo.OrderDetails
select * from dbo.Product
--Q1
USE PE_Demo_S2019
go

create table  Students
(
	StudentID int identity(1,1) primary key,
	Name nvarchar(50),
	Address nvarchar(200),
	Gender char(1)
)

create table Teachers
(
	TeacherID int identity(1,1) primary key,
	Name nvarchar(50),
	Address nvarchar(200),
	Gender char(1)
)

create table Classes
(
	ClassID int identity(1,1) primary key,
	GroupID char(6),
	courseID char(6),
	NoCredits int,
	Semester char(10),
	year int,
	TeacherID int
	foreign key (TeacherID) references Teachers(TeacherID)
)

create table Attend
(
	Date date,
	Slot int,
	Attend bit,
	StudentID int,
	ClassID int,
	primary key (Date,Slot,StudentID, ClassID),
	foreign key (StudentID) references Students(StudentID),
	foreign key (ClassID) references Classes(ClassID)

)
--Q10
insert into Category(CategoryName)
values('Sport')

insert into SubCategory(CategoryID,SubCategoryName)
values((select c.ID from Category c where c.CategoryName = 'Sport'),'Tennis')
,((select c.ID from Category c where c.CategoryName = 'Sport'),'Football')
select * from Category
select * from SubCategory
