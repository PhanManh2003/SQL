insert into Students(id,name,birthdate,gender,department) values(
110, 'Mary Jane', '20010512', 'Female',
(select d.Code from Departments d where d.Name ='Business Administration')
)