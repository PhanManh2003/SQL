select * from dbo.employees
select * from dbo.dependents
--2.Write query to find employee_id, first_name, last_name of employees whose employee_id is less than 105
SELECT employee_id,first_name,last_name
from employees
where employee_id < 105

--3. Write a query to find location_id, street_address,department_name,city of all locations where department-name is(IT or Marketing)
SELECT l.location_id,street_address,p.department_name,city
from locations l join departments p on l.location_id = p.location_id
where p.department_name IN ('IT','Marketing')
order by l.location_id ASC

--4.Write a query to get full_name, job_tittle, department_name,salary of employees whose is greater than 7000 and job_id is 16
SELECT e.first_name+', ' + e.last_name as full_name,job_title,d.department_name,salary
from employees e join jobs j on e.job_id = j.job_id
join departments d on d.department_id = e.department_id
where e.salary > 7000 and j.job_id = 16
ORDER BY Salary ASC

--5.Write a query to get the highest salaries of employees in each department and sorts the result set based on the highest salaries
SELECT d.department_id , d.department_name, MAX(salary) as "MAX(salary)"
from employees e join departments d on e.department_id = d.department_id
GROUP BY department_name,d.department_id
ORDER BY "MAX(salary)" DESC

--6.Write a query get first_name, last_name of employees who are managers. Result sorted by first _name and show only the first 5 records
SELECT TOP 5 e.first_name, e.last_name
FROM employees e
WHERE e.employee_id IN (
SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL
)
ORDER BY e.first_name

--7. Write a query to get countries with the number employees greater than 2
SELECT c.country_id, c.country_name, COUNT(*) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
GROUP BY c.country_id, c.country_name
HAVING COUNT(*) > 2
ORDER BY employee_count DESC;

--9 : CREATE PROCEDURE Get_ManagerID

create proc Get_ManagerID @employeeID INT,
@managerID INT OUTPUT
AS
BEGIN
SELECT @managerID = manager_ID
FROM employees
WHERE employee_ID = @employeeID
END

DECLARE @x INT;
DECLARE @in INT = 101;
EXECUTE Get_ManagerID @in, @x OUTPUT
SELECT @x AS ManagerID

-- 10. delete dependents of employees whose first_name is Karen
begin transaction 
save transaction t1
DELETE FROM dependents
WHERE employee_id in (
SELECT employee_id
FROM employees
WHERE first_name = 'Karen'
);

rollback transaction t1