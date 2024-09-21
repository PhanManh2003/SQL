
CREATE TABLE TestPrimaryKey4(
	ID INT not null,
	Name nvarchar(100) default N'kteam'
)
Go

ALTER TABLE TestPrimaryKey4 Add primary key(ID) -- nếu có constraint thì phải đặt tên cho constraint 

-- bài 7:Khóa ngoại

-- Xóa foreign key: ALTER TABLE ... DROP CONSTRAINT constraint_name