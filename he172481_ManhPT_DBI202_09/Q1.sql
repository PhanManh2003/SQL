create table Products (
ProductNo varchar(30) primary key,
Name	nvarchar(50),
Category  nvarchar(50),
Description nvarchar(255)
)

create table Colors (
ColorCode varchar(20) primary key,
Name nvarchar(100)
)

create table Sizes(
SizeCode varchar(15) primary key,
Description nvarchar(200)
)

create table Has(
quantity int,
price decimal(10,2),
ColorCode varchar(20),
ProductNo varchar(30),
SizeCode varchar(15),
primary key (ColorCode,ProductNo,SizeCode),
foreign key (ColorCode) references Colors(ColorCode),
foreign key (ProductNo) references Products(ProductNo),
foreign key (SizeCode) references Sizes(SizeCode)
)