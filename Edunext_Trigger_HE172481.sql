

-- 1. Tạo TRIGGER cập nhật NoOfStudent của mỗi ngành học khi có sự kiện thêm/sửa/xóa sinh viên trong bảng Students.
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


-- 2. Tạo TRIGGER cập nhật điểm AverageScore của sinh viên khi các sự kiện đối với bảng Result xảy ra.
select * from dbo.Students
select * from dbo.Results
GO

-- Thêm điểm
CREATE TRIGGER ins_Result
ON Results
FOR INSERT
AS
BEGIN
    UPDATE Students
	SET AverageScore = (
		SELECT AVG(HighestMark)
		FROM (
			SELECT MAX(Mark) AS HighestMark
			FROM Results
			WHERE Results.StudentID = Students.StudentID
			GROUP BY Results.CourseID
		) AS T
)
END;
GO
-- Test thêm điểm
INSERT INTO Results values ('S001', 'AI01', 2017, 3, 9, NULL)
GO


-- Xóa điểm
CREATE TRIGGER del_Result
ON Results
FOR DELETE
AS
BEGIN
    UPDATE Students
	SET AverageScore = (
		SELECT AVG(HighestMark)
		FROM (
			SELECT MAX(Mark) AS HighestMark
			FROM Results
			WHERE Results.StudentID = Students.StudentID
			GROUP BY Results.CourseID
		) AS T
)
END;
GO
-- Test xóa điểm
DELETE FROM Results where StudentID = 'S001' AND CourseID = 'AI01' AND Semester = 3 
GO

-- Sửa điểm
CREATE TRIGGER upd_Result
ON Results
FOR UPDATE
AS
BEGIN
     UPDATE Students
		SET AverageScore = (
			SELECT AVG(HighestMark)
			FROM (
				SELECT MAX(Mark) AS HighestMark
				FROM Results
				WHERE Results.StudentID = Students.StudentID
				GROUP BY Results.CourseID
			) AS T
)
END;
GO

-- Test update
UPDATE dbo.Results SET Mark = 10 WHERE StudentID = 'S001' AND CourseID = 'AI01' AND Mark = 6;