-- Q7
SELECT  e.enrollId, c.id AS CourseId, c.title, s.id AS StudentId, s.name as StudentName,
	se.id as semesterId, se.code as semesterCode,
		sum(m.mark * a.[percent]) AS AverageMark
FROM		Assessments AS a JOIN
                    Courses AS c ON a.courseId = c.id JOIN
                    enroll AS e ON c.id = e.courseId JOIN
                    marks AS m ON a.id = m.assessmentId AND e.enrollId = m.enrollId JOIN
                    semesters AS se ON e.semesterId = se.id JOIN
					Students AS s ON e.studentId = s.id
					where c.title = 'introduction to databases'
					group by  e.enrollId, c.id, c.title,s.id,s.name,se.id,se.code
					order by s.id asc, se.id desc

-- đặt tên mà trùng với keyword SQL thì phải đưa vào ngoặc vuông
 select a.[percent] from Assessments a