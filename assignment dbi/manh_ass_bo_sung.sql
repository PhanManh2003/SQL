-- insert into table students Students(id,name,birthdate,gender,department)
-- values (110, 'Mary Jane', '20010512', 'Female') and department is the code of the department
-- named 'Business Administratio'
insert into Students(id,name,birthdate,gender,department) values(
110, 'Mary Jane', '20010512', 'Female',
(select d.Code from Departments d where d.Name ='Business Administration')
)

-- the country of students who are enrolled in a department related to "Computer"
--and have enrolled in at least one semester in the year 2022 will be updated to "VietNam"
--because they have to study "Computer" in VietNam
UPDATE dbo.Students
SET country = 'VietNam'
WHERE department IN (
    SELECT Code
    FROM dbo.Departments
    WHERE Name LIKE '%Computer%'
)
AND id IN (
    SELECT studentId
    FROM dbo.enroll
    WHERE semesterId IN (
        SELECT id
        FROM dbo.semesters
        WHERE year = 2022
    ))

select * from dbo.Departments

-- deletes students who are enrolled 
--less than 2 courses and belong to the "Computer Science" department. 
DELETE FROM dbo.Students
WHERE id IN (
    SELECT studentId
    FROM dbo.enroll
    WHERE semesterId IN (
        SELECT id
        FROM dbo.semesters
        WHERE year = 2022
    )
    GROUP BY studentId
    HAVING COUNT(DISTINCT courseId) < 2
)
AND department = 'CS'
 
alter table enroll 
drop constraint FK__enroll__studentI__44FF419A