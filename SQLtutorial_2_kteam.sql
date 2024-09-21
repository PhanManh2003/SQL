use Lab4

select s.DeptID from dbo.Students as s
union all -- allow duplicated rows
select dep.DeptID from dbo.Departments as dep

select s.DeptID from dbo.Students as s
intersect
select dep.DeptID from dbo.Departments as dep

-- tạo một bảng mới y hệt
select * into shit from dbo.Students  -- tạo bảng shit
go



-- tạo một bảng mới y hệt nhưng không có dữ liệu
select * into nothing from dbo.Students where 1>2 -- tạo bảng nothing
go
-- tạo ra bảng tableB mới có một cột dữ liệu là DateOfBirth tương ứng bảng Students
select DateOfBirth into tableB from dbo.Students

-- Tạo một bảng mới từ nhiều bảng
SELECT StudentID,FirstName,DateOfBirth INTO STUDENT_BACKUP FROM dbo.Students, dbo.Departments
where Students.DeptID = Departments.DeptID
go

--2.INSERT INTO SELECT ( ĐỂ COPY DỮ LIỆU SANG 1 BẢNG ĐÃ TỒN TẠI thay vì chưa tồn tại như select into)
select * into cloneStudent from dbo.Students
go

insert into cloneStudent
select * from dbo.Students
go
-- check thử:
select * from dbo.cloneStudent


-- 3. TRUY VẤN LỒNG
-- truy vấn lồng trong from
select * from dbo.Students, (select * from dbo.Departments) as dp -- phải cần thêm alias


-- chọn tất cả phòng ban có nhiều hơn 1 sinh viên
select * from Departments as d
where 1 < 
(select count(*) from dbo.Students as s where s.DeptID = d.DeptID)
 -- Ví dụ: nó đếm tất cả các record từ bảng student mà có deptID = CE chẳng hạn, rồi nếu mà lớn hơn 1 thì nó sẽ
 -- in ra tất cả các trường thông tin của department mà có deptID = CE.


 select * from dbo.Students as s, dbo.Departments as d, dbo.Results as r where 
 s.DeptID = d.DeptID and s.StudentID = r.StudentID


 -- 4. GROUP BY 
 -- Cú pháp:
	-- SELECT column_name(s) 
	--FROM table_name
	--WHERE condition
	--GROUP BY column_name(s)
	--ORDER BY column_name(s);

-- !  SELECT phải là thuộc tính trong khối GROUP BY hoặc aggregate function, Ví dụ:
	--SELECT COUNT(CustomerID), Country
	--FROM Customers
	--GROUP BY Country;

-- ! When using an aggregate function like MIN() with other columns 
-- in the SELECT statement, you need to include a GROUP BY clause for the non-aggregate columns

select   dbo.Students.DeptID , count(*) as N'Số lượng sinh viên'  from Students group by dbo.Students.DeptID


 -- 5. GROUP BY , HAVING
-- SELECT column_name(s)
--FROM table_name
--WHERE condition
--GROUP BY column_name(s)
--HAVING condition (phải thuộc phạm vi thuộc tính của GROUP BY hoặc select)
--ORDER BY column_name(s);

-- 6. INCREMENT = identity(a,b)
Create table auto_increment
(
	ID int primary key identity(1,1), 
	-- tự tăng trường id này, trường này phải là số
	-- mặc định bắt đầu từ 1 và tăng 1 đơn vị
	Name nvarchar(100)
)
go

-- Không phải add giá trị cho trường id , nó tự điền  
insert into dbo.auto_increment values(N'Mạnh')
insert into dbo.auto_increment values(N'Quang')
insert into dbo.auto_increment values(N'Linh')
insert into dbo.auto_increment values(N'Dũng')
insert into dbo.auto_increment values(N'Hải')
go

select * from dbo.auto_increment
go
-- 7. VIEW

-- View là 1 bảng ảo dựa trên 1 câu lệnh SQL. Bảng view này tự thay đổi để đồng bộ khi các bảng trong câu lệnh SQL đó có sự thay đổi.
--(vì đồng bộ hóa nên nó khác câu lệnh select into chỉ thực hiện nhiệm vụ "copy dữ liệu")

create view student_observe as 
select * from Students
go


select * from  student_observe
go
-- Sửa view
--ALTER VIEW [Tên_View]
--AS
--    SELECT Cột_1, Cột_1,... Cột_n
--    FROM Tên_bảng
--GO

-- tạo view có dấu 
create view [theo dõi học sinh] as 
select * from Students
go

-- 8. INDEX
	-- CREATE INDEX index_name ON table_name (column1, column2, ...);
	--Indexes are used to retrieve data from the database more quickly than otherwise. 
	--The users cannot see the indexes, they are just used to speed up searches/queries.

 -- 9. KIỂU DỮ LIỆU TỰ ĐỊNH NGHĨA
 -- EXEC sp_addtype	'Tên kiểu dữ liệu', 'Kiểu dữ liệu thực tế', 'not null' (không bắt buộc)

 Exec sp_addtype 'KhoaChinh', 'varchar(50)', 'Not null'
 go

Create Table TB_DBType
(
	TestCode KhoaChinh Primary Key,
	TestName nvarchar(100),
	OrderID int
)

-- Cách xóa :
exec sp_droptype 'KhoaChinh'

-- 10. DECLARE VÀ SỬ DỤNG BIẾN

-- Khai báo nhiều hơn một biến có gán giá trị ban đầu:
-- DECLARE @quantrimang VARCHAR(50) = 'Hello world', @variable INT = 10;  

-- Lấy ra mã sinh viên của sinh viên có điểm trung bình cao nhất
select StudentID from dbo.Students where AverageScore = (select max(AverageScore) from dbo.Students)

-- Tạo ra một biến kiểu char lưu mã sinh viên điểm cao nhất với declare
DECLARE @maxScoreStudentID char(10)
SELECT @maxScoreStudentID = StudentID from dbo.Students where AverageScore = (select max(AverageScore) from dbo.Students)
-- Bây giờ ta sẽ tìm tuổi của sinh viên có điểm cao nhất đó
select year(getdate()) - YEAR(Dateofbirth)  from dbo.Students where StudentID = @maxScoreStudentID

-- Lưu ý: Khi chạy thì phải chạy từ dòng declare trở xuống.  

declare @i int = 0
-- Cách 1: đặt dữ liệu cho biến bằng câu SET
set @i = @i + 1
print @i

-- Cách 2 :đặt dữ liệu cho biến bằng câu SELECT (như trên)
 

-- 11. IF-ELSE TRONG T-SQL
declare @diemtrungbinh float
declare @soluongsinhvien int

select @soluongsinhvien = count(*) from dbo.Students
select @diemtrungbinh = SUM(AverageScore)/@soluongsinhvien from dbo.Students

---------------
declare @diemsinhvienS001 float
select @diemsinhvienS001 = AverageScore from dbo.Students where StudentID = 'S001'

--- if else
if ( @diemsinhvienS001 >@diemtrungbinh and @diemsinhvienS001 >1 )
	begin
		print @diemtrungbinh
		print concat (N'điểm sinh viên S001 là: ',@diemsinhvienS001)
		print N'điểm sinh viên S001 lớn hơn điểm trung bình'
	end
else
	print N'nhỏ hơn'
go

-- 12. VÒNG LẶP TRONG T-SQL

-- Ví dụ 1:
declare @i int = 0
declare @n int = 1000

while(@i <@n)
begin
	print @i
	set @i+= 1
end

-- Ví dụ 2:
create table testLoop (
	id int ,
	luong int check( luong <= 10000 and luong >= 1)
)
go



select * from dbo.testLoop
go

declare @count int = 0
declare @num int = 999
while (@count < @num)
begin
	insert into dbo.testLoop (luong) values (@count)
	set @count += 1
end

-- 13. CURSOR
-- Khi có nhu cầu duyệt từng record trong bảng. Với mỗi record có kết quả xử lí riêng thì dùng cursor
-- Cấu trúc chương trình :

	--1) declare GiaovienCursor cursor for <câu select> 
	-- vd: select magv, year(getdate())- year(ngsinh) from dbo.giaovien	
	--2) open GiaovienCursor

	--3) declare @magv char(10)
	-- declare @tuoi int

	--4) fetch next from <tên con trỏ> into <danh sách các biến tương ứng kết quả truy vấn>
	-- FETCH NEXT FROM GiaovienCursor into @magv,@tuoi => Đọc dòng đầu tiên 
	 
	--5) WHILE @@FETCH_ STATUS = 0
	-- BEGIN
	--		6) CÂU LỆNH THỰC HIỆN, vd:
			--if @tuoi >40
			--begin
			--	UPDATE dbo.GIAOVIEN set luong = 2000
			--end
			--else if @tuoi >30
			--begin
			--	UPDATE DBO.GIAOVIEN set luong = 3000
			--end
			--else
			--begin
			--	UPDATE dbo.GIAOVIEN set luong = 4000
			--end
	--		7) Đọc dòng tiếp theo: fetch next from <tên con trỏ> into <@magv,@tuoi>
	-- END

	--8) CLOSE <TÊN CON TRỎ>
	--9) DEALLOCATE <TÊN CON TRỎ>

-- 14. STORED PROCEDURE
-- A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.
-- So if you have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.
-- You can also pass parameters to a stored procedure, so that the stored procedure can act based on the parameter value(s) that is passed.

-- Chú ý: stored procedure không chứa trong tên và không được sử dụng trực tiếp trong biểu thức
-- ví dụ: select * from <procedure_name>
-- syntax:
CREATE PROCEDURE SelectAllCustomers @City nvarchar(30), @PostalCode nvarchar(10)
AS
begin
SELECT * FROM Customers WHERE City = @City AND PostalCode = @PostalCode
end
GO
-- Execute a Stored Procedure
EXEC SelectAllCustomers @City = 'London', @PostalCode = 'WA1 1DP';
go

-- 15. FUNCTION
--syntax:
--CREATE FUNCTION schema_name.function_name (parameter_list: @para_name datatype)
--RETURNS data_type AS  
--BEGIN  
--    statements  
--    RETURN value  
--END   

-- execute: SELECT dbo.function_name([parameter1, parameter2, ...]);

-- sửa function: thay create thành alter

CREATE FUNCTION selectAllStudent(@studentID char(5))
returns date as 
begin
	declare @ngaysinh date
	select @ngaysinh = DateOfBirth from dbo.Students where StudentID = @studentID
	return @ngaysinh
end
go


select dbo.selectAllStudent('S001')
go 

-- 16. TRIGGER (xem file trigger.sql, edunext_trigger.sql)
-- inserted: chứa hàng đã insert| update vào bảng
-- deleted: chứa  hàng đã  delete khỏi bảng

-- Hiểu đơn giản thì Trigger là một stored procedure không có tham số. 
-- Trigger thực thi một cách tự động khi một trong ba câu lệnh Insert, Update, Delete 
-- làm thay đổi dữ liệu trên bảng có chứa trigger.

-- Ví dụ: Không có xóa sinh viên có điểm tb < 3 


----------------------------------------------
create trigger StopDelScoreSmallerThan3
on dbo.Students
for delete 
as
begin
	declare @count_3 int
	select @count_3 = count(*) from deleted where AverageScore < 3
	if (@count_3 > 0)
	begin
		print N'Không được xóa sinh viên có điểm tb nhỏ hơn 3'
		rollback tran
	end
end
GO

delete from dbo.Students where StudentID = 'S222' -- Xóa thằng điểm <3
GO

insert into dbo.Students values
('S222', N'Phan', N'Tiến Mạnh', 'M', '20030322', N'Hà Nội', 'SE', 15000, 2)
GO

select * from dbo.Students
GO

-- 17. TRANSACTION	

-----------rollback------------
begin transaction 
delete from dbo.Students where StudentID = 'S222'
rollback transaction -- hủy bỏ transaction

-----------commit------------
begin transaction
delete from dbo.Students where StudentID = 'S222'
commit transaction -- chấp nhận transaction

--------Đặt tên cho transaction-----------
begin transaction tran1
delete from dbo.Students where StudentID = 'S222'
commit transaction tran1-- chấp nhận transaction


------------savepoint----------
-- syntax: SAVE { TRAN | TRANSACTION } { savepoint_name | @savepoint_variable }  
select * from dbo.Students

Begin transaction -- phải có begin transaction khi sử dụng transaction
save transaction sp1
delete from dbo.Students where StudentID = 'S011'
save transaction sp2
delete from dbo.Students where StudentID = 'S010'
save transaction sp3
delete from dbo.Students where StudentID = 'S009'


------- Quay lại chỗ chưa muốn xóa-------
rollback transaction sp1
rollback transaction sp2
 

insert into dbo.Students values
('S009', N'Phan', N'Tiến Mạnh', 'M', '20030322', N'Hà Nội', 'SE', 12300, 2)
GO

insert into dbo.Students values
('S010', N'Phan', N'Tiến Dũng', 'F', '20030315', N'Hà Nam', 'IS', 13222, 2)
GO

insert into dbo.Students values
('S011', N'Phan', N'Tiến Linh', 'M', '20030322', N'Hà Nội', 'CE', 15000, 2)
GO

-- 18. mệnh đề "top" và "with ties" để lấy những bản ghi đầu tiên của câu lệnh select
-- Lưu ý: top with ties phải có order by
-- SELECT TOP(n) WITH TIES [columns] FROM [tables] [WHERE Điều_kiện] ORDER BY Cột1, Cột2, ...;

-- Vd: Tìm 2 sinh viên có điểm trung bình cao nhất
select top(2) with ties * from dbo.Students order by AverageScore desc

 SELECT   d.DeptID, d.Name, d.NoOfStudents, s.StudentID, s.LastName, s.FirstName, s.Sex, s.DateOfBirth, s.PlaceOfBirth, s.DeptID AS Expr1, s.Scholarship, s.AverageScore
FROM         Departments AS d INNER JOIN
                         Students AS s ON d.DeptID = s.DeptID