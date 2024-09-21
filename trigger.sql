use Lab4
go


Update Departments 
set NoOfStudents = (SELECT count (*) from Students where Students.DeptID = Departments.DeptID)

use Lab4
go
-- Xem Bảng
select * from Students
select * from Departments
go


-- Insert trigger
CREATE TRIGGER ins_Student
ON Students
FOR INSERT
AS
BEGIN
    UPDATE Departments
    SET NoOfStudents = NoOfStudents + (SELECT COUNT(*) FROM Inserted WHERE Inserted.DeptID = Departments.DeptID)
END;
GO

-- Test insert
INSERT INTO Students
VALUES ('S009', N'Văn Mạnh', N'Bùi', 'F', NULL, N'Củ Lạc', 'SE', 0, NULL);
GO

-- Delete trigger
CREATE TRIGGER del_Student
ON Students
FOR DELETE
AS
BEGIN
    UPDATE Departments
    SET NoOfStudents = NoOfStudents - (SELECT COUNT(*) FROM Deleted WHERE Deleted.DeptID = Departments.DeptID)
END;
GO

-- Test delete
DELETE FROM Students WHERE StudentID = 'S009';
GO

-- Update trigger
CREATE TRIGGER upd_Student
ON Students
FOR UPDATE
AS
BEGIN
    UPDATE Departments 
    SET NoOfStudents = (SELECT COUNT(*) FROM Students WHERE Students.DeptID = Departments.DeptID)

END;
GO

-- Test update
UPDATE dbo.Students SET DeptID = 'CE' WHERE StudentID = 'S001';

-- Drop Trigger
drop trigger ins_Student
drop trigger del_Student
drop trigger upd_Student