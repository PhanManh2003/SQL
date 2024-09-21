SELECT       s.id StudentID, s.name StudentName,
d.Name as DepartmentName, count(distinct e.semesterId) AS NumberOfEnrolledCourses
FROM            Departments AS d left JOIN
                         Students AS s ON d.Code = s.department left JOIN
                         enroll AS e ON s.id = e.studentId 
						 where d.Name = 'Business Administration'
						 group by s.id,s.name,d.Name

 