--	SECTION 2: GROUP BY & Aggregation (10 Questions)
use company_analytics

select * from employees;
--	16(E) Find total salary per department.
SELECT SUM(salary) AS TOTAL_SALARY FROM employees;

--	17(E) Count employees per department.
SELECT d.department_name,count(e.emp_id) as Employee_count 
		from employees e join departments d
			on e.department_id=d.department_id 
			group by d.department_name;

--	18(M) Find departments having more than 1 employees.
select d.department_name,count(e.emp_id) as Employee_count 
			from employees e join departments d
			on e.department_id =d.department_id group by d.department_name having count(e.emp_id)>1;

--	19(M) Find average salary per department.
select d.department_name,avg(e.salary) as Avg_salary 
			from employees e join departments d
			on e.department_id=d.department_id group by department_name;

--	20(M) Find maximum salary in each department.
SELECT MAX(e.salary) as Max_Salary,d.department_name 
			from employees e join departments d
			on e.department_id = d.department_id group by department_name;

--	21(M) Find departments where average salary > 90,000.
SELECT d.department_name,avg(e.salary) as Avg_salary
			from employees e join departments d
			on e.department_id=d.department_id group by d.department_name having avg(e.salary) >90000;

--	22(M) Find employee count grouped by hire year.
SELECT count(e.emp_id) as Employee_count,year(e.hire_date) as hire_year 
			from employees e join departments d
			on e.department_id = d.department_id group by year(e.hire_date);

--	23(M) Find minimum salary in each job role.
SELECT job_role, MIN(Salary) as Min_salary from employees group by job_role;

--	24(M) Get department with highest total salary.
select Top 1 d.department_name, sum(e.salary) as Total_salary
			from employees e join departments d
			on e.department_id = d.department_id group by d.department_name order by sum(e.salary) desc; 

--	25(H) Find top 3 departments by total salary.
select Top 3 d.department_name, sum(e.salary) as Total_salary
			from employees e join departments d
			on e.department_id = d.department_id group by d.department_name order by sum(e.salary) desc; 
