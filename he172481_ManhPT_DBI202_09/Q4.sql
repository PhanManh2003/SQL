SELECT        s.id, s.name, s.department, se.code, se.year, c.title
FROM            Courses AS c INNER JOIN
                         enroll AS e ON c.id = e.courseId INNER JOIN
                         semesters AS se ON e.semesterId = se.id INNER JOIN
                         Students AS s ON e.studentId = s.id
						 where c.title = 'Operating Systems'
						 order by se.year asc, se.code asc, s.id asc