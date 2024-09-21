SELECT        d.Code, d.Name, count(s.id) as NumberOfStudents
FROM            Departments AS d INNER JOIN
                         Students AS s ON d.Code = s.department
						 group by d.Code, d.Name
						 having count(s.id) =
						 (select max(StuCount.NumberOfStudents) from 
							(SELECT  d.code, count(s.id) as NumberOfStudents      
								FROM            Departments d INNER JOIN
							 Students s ON d.Code = s.department 
							 group by d.code 
							 ) as StuCount
						   )
union all
SELECT        d.Code, d.Name, count(s.id) as NumberOfStudents
FROM            Departments AS d INNER JOIN
                         Students AS s ON d.Code = s.department
						 group by d.Code, d.Name
						 having count(s.id) =
						 (select min(StuCount.NumberOfStudents) from 
							(SELECT  d.code, count(s.id) as NumberOfStudents      
								FROM            Departments d INNER JOIN
							 Students s ON d.Code = s.department 
							 group by d.code 
							 ) as StuCount
						   )