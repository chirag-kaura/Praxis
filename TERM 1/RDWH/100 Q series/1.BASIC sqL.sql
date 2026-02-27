-- SECTION 1: SQL Basics (15 Questions)

--🔹 Basic SELECT & Filtering

--	1.(E) Write a query to select all columns from a table employees.
SELECT * FROM employees;

--	2.(E) Select only name and salary from employees.
SELECT concat(first_name,' ',last_name) AS name,salary FROM employees;

--	3.(E) Retrieve employees with salary greater than 50,000.
SELECT * FROM employees WHERE salary>50000;

--	4.(E) Fetch employees whose department is 'IT'.
SELECT * FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name  ='IT');

--	5.(E) Find employees hired after 2022-01-01.
SELECT * FROM employees WHERE hire_date > '2022-01-01';

--	6.(E) Use BETWEEN to fetch salaries between 40,000 and 80,000.
SELECT * FROM employees WHERE salary BETWEEN 40000 AND 80000;

--	7(E) Use IN to filter employees from departments IT, HR, and Sales.
SELECT * FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE department_name IN ('IT','HR','Sales'));

--	8(E) Find employees whose name starts with 'A'.
SELECT * FROM employees WHERE first_name LIKE 'a%';

--	9(E) Find employees whose name ends with 'n'.
SELECT * FROM EMPLOYEES WHERE last_name LIKE '%n';

-- 10(E) Use ORDER BY to sort employees by salary descending.
SELECT * FROM employees ORDER BY salary DESC;

--	11(E) Sort employees by department (asc) and salary (desc).
SELECT e.* from employees e join departments d
			on e.department_id =d.department_id
			order by d.department_name asc, e.salary desc;

--	12(E) Display top 5 highest paid employees.
SELECT TOP 5 * FROM employees ORDER BY salary DESC;

--	13(E) Find distinct departments in the table.
SELECT distinct(department_name) from departments;

--	14(E) Count total number of employees.
SELECT COUNT(emp_id) AS Employee_count FROM employees;

--	15(E) Find average salary of employees.
SELECT AVG(salary) AS Avg_Salary FROM employees;







