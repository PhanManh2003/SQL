use PE_DBI202_SU2023_ass
go


--1  Retrieves all students who do not have a specified department. 
SELECT * FROM Students AS S
LEFT JOIN Departments AS D ON S.department = D.Code
WHERE D.Code IS NULL;

--2   Deletes all assessments of type 'Quiz' from the Assessments table
DELETE FROM Assessments
WHERE type = 'Quiz' AND courseId IN (SELECT id FROM Courses WHERE credits < 3);


--3  Retrieves the top 5 rows from the Courses table
SELECT TOP 5 * FROM Courses
ORDER BY credits DESC;

--4  Calculates the minimum number of credits for each department 
SELECT code, MIN(credits) AS MinCredits
FROM Courses
GROUP BY code;

--5  Retrieves the maximum mark obtained by each student 
SELECT s.name, MAX(marks.mark) AS MaxMark
FROM Students s
JOIN enroll e ON s.id = e.studentId
JOIN marks ON e.enrollId = marks.enrollId
GROUP BY s.name;


--6 Counts the number of distinct departments that are present in the Students table.
SELECT COUNT(DISTINCT department) AS DepartmentCount
FROM Students;

--7 Calculates the total credits of courses that a specific student (with id 5) has enrolled in. 
SELECT SUM(C.credits) AS TotalCredits
FROM Courses C
INNER JOIN enroll E ON C.id = E.courseId
WHERE E.studentId = 5;

--8 Counts the number of students who have a department assigned to them.
SELECT COUNT(*)  AS StudentCount
FROM Students
WHERE department IS NOT NULL;
go

--9 This stored procedure takes a department code as input and retrieves the count of students in that department.
CREATE PROCEDURE GetStudentCountByDepartment
@departmentCode VARCHAR(10)
AS
BEGIN
SELECT COUNT(*) FROM Students WHERE department = @departmentCode;
END
go

exec GetStudentCountByDepartment @departmentCode  = 'SE'
go

--10 Cannot change name of male student :) 
create trigger StopChangeMale
on dbo.Students
for update 
as
begin
	declare @count_male int
	select @count_male = count(*) from inserted where gender = 'Male'
	if (@count_male > 0)
	begin
		print N'Không được sửa tên sinh viên nam'
		rollback tran
	end
end
GO

update dbo.Students set name = 'pikachu' where name ='Stacey payne' 
go
--11 This procedure allows you to insert a new student into the Students table 
-- by specifying the required parameters: name, birthdate, gender, address, city, country, and department.
CREATE PROCEDURE InsertStudent
@name VARCHAR(50),
@birthdate DATE,
@gender VARCHAR(10),
@address VARCHAR(100),
@city VARCHAR(100),
@country VARCHAR(100),
@department VARCHAR(10)
AS
BEGIN
INSERT INTO Students (name, birthdate, gender, address, city, country, department)
VALUES (@name, @birthdate, @gender, @address, @city, @country, @department);
END;
go



--12  This procedure retrieves the details of a student based on the given student ID. 
-- It selects all columns from the Students table for the specified student ID
CREATE PROCEDURE [GetStudentByID]
@studentID INT
AS
BEGIN
	SELECT * FROM Students
	WHERE id = @studentID;
END;

select * from dbo.marks


--13. Find the student who have the highest avgerage score 
SELECT TOP 1 S.id, S.name, AVG(M.mark) AS AverageScore
FROM Students S
JOIN enroll E ON S.id = E.studentId
JOIN marks M ON E.enrollId = M.enrollId
GROUP BY S.id, S.name
ORDER BY AverageScore DESC;
go
--14 Create a trigger that can't delete student who have avg score higher than 8

CREATE TRIGGER [PreventStudentDeletion]
ON dbo.students
for DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted AS D
        JOIN (
            SELECT S.id, AVG(M.mark) AS AverageScore
            FROM Students S
            JOIN enroll E ON S.id = E.studentId
            JOIN marks M ON E.enrollId = M.enrollId
            GROUP BY S.id
        ) AS A ON D.id = A.id
        WHERE A.AverageScore > 8
    )
    BEGIN
        RAISERROR ('Deletion is not allowed for students with an average score higher than 8.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE S
        FROM dbo.Students AS S
        JOIN deleted AS D ON S.id = D.id;
    END
END;

ALTER TABLE dbo.enroll
NOCHECK CONSTRAINT FK__enroll__studentI__44FF419A;
go

delete from dbo.Students where name = 'helen washington'
select * from dbo.Students where name = 'helen washington'

