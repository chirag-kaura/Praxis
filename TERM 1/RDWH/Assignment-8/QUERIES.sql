select * from Employees

select * from orders

select * from Students

select * from sales

ALTER TABLE Sales
ADD sale_date DATE;

UPDATE Sales SET sale_date = '2024-01-01' WHERE sale_id = 1;
UPDATE Sales SET sale_date = '2024-01-05' WHERE sale_id = 2;
UPDATE Sales SET sale_date = '2024-02-01' WHERE sale_id = 3;
UPDATE Sales SET sale_date = '2024-02-10' WHERE sale_id = 4;
UPDATE Sales SET sale_date = '2024-03-01' WHERE sale_id = 5;
UPDATE Sales SET sale_date = '2024-03-05' WHERE sale_id = 6;
UPDATE Sales SET sale_date = '2024-04-01' WHERE sale_id = 7;
UPDATE Sales SET sale_date = '2024-04-10' WHERE sale_id = 8;

--1.	List each employee with their rank within the department based on salary (highest salary = rank 1).
select * ,rank () over (Partition by departmentid order by salary desc) as Salary_Rank from Employees 

--2.	Show each employee with the average salary of their department.
select * ,avg(salary) over(partition by departmentid ) as dept_avg_salary from Employees;

--3.	Display each order with a running total of order amounts by customer.
select *,sum(amount) over(partition by customerid order by orderDate) as Running_Total from orders

--4.	List students with the cumulative marks in their class ordered by student_id.
select *,sum(marks) over(partition by class order by studentID) as cumulativeMarks from Students

--5.	For each employee, show the difference between their salary and the department’s average salary.
select *,salary-avg(salary) over(partition by departmentid) as salary_from_dept_avg  from Employees

--6.	List each employee along with the highest salary in their department.
select *,max(salary) over(partition by departmentid) from Employees

--7.	Show orders with row numbers partitioned by customer_id and ordered by order_date.
select *,Row_number() over(partition by customerid order by orderdate) as Row_no from orders

--8.	For each student, display the class average marks alongside their own marks.
select *,avg(marks) over(partition by class) as class_avg_marks from students

--9.	Show sales records with rank per region based on quantity sold.
select *,rank() over(partition by region order by quantity) as Rank_per_region from Sales

--10.	List employees with a lag of salary (previous employee’s salary) ordered by hire_date.
select *,lag(salary) over(order by hiredate) as prev_emp_salary from Employees

--11.	Find the top 2 highest paid employees in each department.
select * from (select *,rank() over(partition by departmentid order by salary) as Rank_per_dept from Employees) as t where Rank_per_dept<2

--12.	List each order with the difference between the order amount and the previous order amount for the same customer.
select *,(amount- lag(amount) over(partition by customerid order by orderdate))as differnce_prev from orders 

--13.	Show cumulative sales amount per region and product over time.
select *,Sum(price*quantity) over(partition by region,product_id order by Sale_date) as cumulative_sales from Sales

--14.	For each student, find their rank in class based on marks and tie ranks properly.
select *,DENSE_RANK() over(partition by class order by marks) as Tie_Ranks from students

--15.	Show each employee with salary percent rank within their department.
select *,percent_rank() over(partition by departmentid order by salary) as percentrank from Employees

--16.	Find the moving average of the last 3 orders per customer (based on order_date).
select *,avg(Amount) over(partition by customerid order by orderdate rows between 2 preceding and current row) from orders

--17.	For each product, show the running total quantity sold and running average price per region.
select *,sum(quantity) over(partition by region,product_id order by sale_date) as Running_qty,avg(price) over(partition by region,product_id order by sale_date) as Running_price from Sales

--18.	Identify employees who have a salary greater than the average salary of their department using window functions.
select * from( select *,avg(Salary) over(partition by departmentid) as avg_salary_by_dept from Employees) as t where salary >avg_salary_by_dept

--19.	List students with their rank and dense rank within their class.
select *, rank() over(partition by class order by marks) as Rank_only,Dense_rank() over(partition by class order by marks) as Denserank from Students

--20.	For each sale, display the next sale’s date for the same product using LEAD.
select *,lead(sale_date) over(partition by product_id order by sale_date) as next_sale_date from sales
