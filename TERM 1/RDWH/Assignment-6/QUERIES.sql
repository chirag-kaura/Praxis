select * from Employees

select * from Departments

select * from Locations

CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    City VARCHAR(50)
);

INSERT INTO Locations VALUES
(1,'New York'),
(2,'Los Angeles'),
(3,'Chicago'),
(4,'Houston'),
(5,'Boston');

ALTER TABLE Departments
ADD LocationID INT;

UPDATE Departments SET LocationID = 1 WHERE DepartmentID = 1;
UPDATE Departments SET LocationID = 2 WHERE DepartmentID = 2;
UPDATE Departments SET LocationID = 3 WHERE DepartmentID = 3;
UPDATE Departments SET LocationID = 4 WHERE DepartmentID = 4;
UPDATE Departments SET LocationID = 5 WHERE DepartmentID = 5;


CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    DepartmentID INT,
    StartDate DATE
);

INSERT INTO Project VALUES
(1,'AI Platform',4,'2024-01-10'),
(2,'Sales Dashboard',2,'2024-02-15'),
(3,'HR System',1,'2023-11-20'),
(4,'Finance Tracker',3,'2024-03-05');


select * from Project

CREATE TABLE Employee_Project (
    emp_proj_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    role VARCHAR(50)
);


INSERT INTO Employee_Project VALUES
(1,1,1,'Developer'),
(2,2,2,'Analyst'),
(3,3,3,'HR Specialist'),
(4,4,1,'Project Manager'),
(5,5,2,'Sales Lead'),
(6,6,4,'Accountant'),
(7,7,4,'Financial Analyst'),
(8,8,1,'Engineer');

select * from Employee_Project


--1. List employee name and their manager name.
select e.FirstName as Employee_Name,
m.FirstName as Manager_Name 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID

--2. Display employee name, manager name, and employee salary.
select e.FirstName,
m.FirstName,e.Salary 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID

--3. List all employees along with their department name and manager name.
select e.FirstName as Employee_name,
d.DepartmentName as Dept_name,
m.FirstName as Manager_name 
from Employees e 
left join Employees m 
on e.ManagerID=m.EmployeeID
join Departments d 
on e.DepartmentID=d.DepartmentID 

--4. Display employee name, project name, and manager name for employees assigned to projects.
select e.FirstName as Emp_name,
p.ProjectName,m.FirstName as Mgr_name
from Employees e 
join Project p 
on e.DepartmentID=p.DepartmentID 
join Employees m 
on e.ManagerID=m.EmployeeID 

--5.	Show employee name, manager name, and manager salary.
select e.FirstName as Emp_name,
m.FirstName as mgr_name,
m.Salary 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID

--6.	Display employee name, department name, and manager name.
select e.FirstName,
d.DepartmentName,
m.FirstName 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
join Departments d 
on d.DepartmentID=e.DepartmentID

--7.	Find employees who work in the same department as their manager.Show employee name and manager name.
select e.FirstName,
m.FirstName 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
where e.DepartmentID=m.DepartmentID

--8.	List employees and their coworkers who belong to the same department (self join on Employees).
select e.FirstName as Emp_name,
c.FirstName as Cowork_name,
e.DepartmentID 
from Employees e 
join Employees c 
on e.DepartmentID=c.DepartmentID 
and e.FirstName !=c.FirstName

--9.	Display employee name, project name, and manager name for each project assignment.
select e.FirstName as Emp_name,
p.ProjectName,
m.FirstName as Mgr_name 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
join Project p 
on p.DepartmentID =e.DepartmentID

--10.	Show employee name and their manager's manager name (two levels of hierarchy).
select e.FirstName,
m.FirstName,
mm.FirstName 
from Employees e 
left join Employees m 
on e.ManagerID=m.EmployeeID 
left join Employees mm 
on m.ManagerID=mm.EmployeeID

--11.	Find the number of employees working under each manager. 
select m.EmployeeID as Mgr_id ,
count(e.EmployeeID) as Employee_count 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
group by m.EmployeeID

--12.	Display manager name and employee count.
select m.FirstName as Mgr_name ,
count(e.EmployeeID) as Employee_count 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
group by m.FirstName

--13.	List managers who manage more than 3 employees.
select m.FirstName as Mgr_name ,
count(e.EmployeeID) as Employee_count 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
group by m.FirstName 
having count(e.EmployeeID)>3

--14.	Find the average salary of employees under each manager.
select m.firstname,
avg(e.Salary) Avg_salary_per_mgr 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
group by m.FirstName

--15.	Display employees who earn more than their manager.
select e.firstname as Emp_name ,
e.Salary as Emp_salary,
m.Salary as Mgr_salary 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
where e.Salary>m.Salary

--16.	Find the highest paid employee under each manager.
select m.firstname ,e.FirstName,e.Salary from Employees e join Employees m on e.ManagerID=m.EmployeeID where e.Salary in (
select max(e.salary) as max_salary_by_mgr 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
group by m.FirstName)

--17.	List departments where employees report to managers from the same department. Display department name and employee count.
select d.DepartmentName,
count(e.EmployeeID) as Employee_count 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
join Departments d 
on d.DepartmentID=e.DepartmentID 
where e.departmentid=m.departmentid 
group by d.DepartmentName

--18.	Find projects where employees and their managers both work on the same project.
select p.projectname, 
e.FirstName,
m.FirstName 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
join Employee_Project ep 
on ep.employee_id=e.EmployeeID 
join Employee_Project as mp 
on mp.employee_id=m.EmployeeID
and ep.project_id = mp.project_id
join Project p
on p.ProjectID=ep.project_id

--19.	Display managers whose total team salary exceeds 200000. 
select m.FirstName as Mgr_name,
sum(e.Salary) as Team_salary 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
group by m.FirstName 
having sum(e.Salary) >200000

--20.	Find employees who have the same manager and are assigned to the same project. 
select e1.EmployeeID,
e2.EmployeeID, 
ep1.project_id 
from Employees e1 
join Employees e2 
on e1.ManagerID=e2.ManagerID
and e1.EmployeeID<>e2.EmployeeID
join Employee_Project ep1 
on ep1.employee_id=e1.EmployeeID
join Employee_Project ep2
on ep2.employee_id=e2.EmployeeID
and ep1.project_id=ep2.project_id

--21.	List managers who manage employees in more than one project.
select m.EmployeeID,
m.firstname,
count(distinct ep.project_id) as projectCount 
from Employees e 
join Employees m 
on e.ManagerID=m.EmployeeID 
join Employee_Project ep 
on e.EmployeeID=ep.employee_id 
group by m.EmployeeID,m.FirstName 
having count(distinct ep.project_id) >1;


select * from Employee_Project
select * from Employees
select * from Project
select * from Departments
