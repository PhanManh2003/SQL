SELECT        s.id, s.name, s.birthdate, s.gender, d.Name   AS DepartmentName
FROM            Departments AS d INNER JOIN
                         Students AS s ON d.Code = s.department
						 where d.Name = 'Multimedia Communications'