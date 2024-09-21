create proc P2 
@StudentID INT,
@SemesterCode varchar(20),
@TotalCourse int output
as
begin
	set @TotalCourse =( SELECT  count(*)      
FROM            enroll AS e INNER JOIN
                         semesters AS se ON e.semesterId = se.id INNER JOIN
                         Students AS s ON e.studentId = s.id
						 where  s.id = @StudentID and se.code = @SemesterCode)
end

