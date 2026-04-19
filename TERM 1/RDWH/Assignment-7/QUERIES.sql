use Assignments

select * from Employees

select * from orders

select * from Students

ALTER TABLE Students
ADD class VARCHAR(10),
    marks INT;

UPDATE Students SET class = 'A' WHERE StudentID IN (1,2,3);
UPDATE Students SET class = 'B' WHERE StudentID IN (4,5);
UPDATE Students SET class = 'C' WHERE StudentID IN (6,7,8);

UPDATE Students SET marks = 85 WHERE StudentID = 1;
UPDATE Students SET marks = 78 WHERE StudentID = 2;
UPDATE Students SET marks = 92 WHERE StudentID = 3;
UPDATE Students SET marks = 65 WHERE StudentID = 4;
UPDATE Students SET marks = 88 WHERE StudentID = 5;
UPDATE Students SET marks = 90 WHERE StudentID = 6;
UPDATE Students SET marks = 72 WHERE StudentID = 7;
UPDATE Students SET marks = 80 WHERE StudentID = 8;


CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    region VARCHAR(50)
);

INSERT INTO Sales VALUES
(1,101,20,500,'North'),
(2,101,30,500,'North'),
(3,102,10,800,'South'),
(4,102,25,800,'South'),
(5,103,50,200,'East'),
(6,103,60,200,'East'),
(7,104,40,700,'West'),
(8,104,35,700,'West');

--1. Find departments where the average salary is greater than 60,000.
select DepartmentID, 
avg(salary) as AvgSalary 
from Employees 
group by DepartmentID 
having avg(Salary) > 60000;

--2. List customer IDs who have made more than 5 orders
select CustomerID,
count(*) as order_count 
from orders 
group by CustomerID 
having count(*)>5;

--3. Find products where the total quantity sold is greater than 100.
select product_id,
sum(quantity) Quantitysold 
from Sales 
group by product_id 
having sum(quantity) > 100;

--4. Show departments where the maximum salary exceeds 90,000.
select DepartmentID,
max(Salary) 
from Employees 
group by DepartmentID 
having max(Salary) >90000

--5. Find students whose average marks are greater than 75 (group by class if applicable).
select StudentName,
marks 
from students 
where marks>(
                select avg(marks) 
                from Students
            )

select class,
avg(marks) as avg_marks 
from Students 
group by class 
having avg(marks) >75

--6. Display products where the total sales amount is greater than 50,000.
select product_id,
sum(price*quantity) as Total_sales 
from sales 
group by product_id 
having sum(price*quantity)>50000

--7. Find departments with more than 3 employees.
select departmentid,
count(EmployeeID) Employee_by_dept 
from Employees 
group by DepartmentID 
having count(EmployeeID)>1

--8. List customers whose total purchase amount exceeds 10,000.
select customerid,
sum(amount) as Total_amt 
from orders 
group by CustomerID 
having sum(amount) > 5000;

--9. Find products where the average quantity sold per sale is greater than 10.
select product_id,
avg(quantity) as avg_quantity 
from Sales 
group by product_id 
having avg(quantity)>10;

--10. Show departments where the minimum salary is greater than 40,000.
select DepartmentID,
min(salary) Min_salary_by_department 
from Employees 
group by DepartmentID 
having min(salary) > 40000

--11. Find departments where the average salary is higher than the company’s overall average salary.
select departmentid,
avg(salary) Avg_by_dept 
from Employees 
group by DepartmentID 
having avg(salary) > (
                        select avg(salary) 
                        from employees
                     )

--12. List customers who placed more than 3 orders and whose total order amount exceeds 5000.
select CustomerID,
count(orderid) as Total_orders,
sum(amount) Total_spent 
from orders 
group by CustomerID 
having count(orderid) >2 
and sum(amount)>5000

--13. Find regions where total sales revenue exceeds 100,000.
select region,
sum(quantity*price) as sales_by_region 
from Sales 
group by region 
having sum(quantity*price) >50000;

--14. Show products that were sold more than 20 times and whose total quantity sold exceeds 200.
select product_id,
count(product_id) as Total_sales,
sum(quantity) as Total_quantity 
from Sales 
group by product_id 
having sum(quantity) >200 
and count(product_id) >20;

--15. Find classes where the average marks are above 70 and the number of students is more than 10
select class,
avg(marks) as Avg_marks,
count(studentId) as No_of_students 
from Students 
group by class 
having avg(marks)>75 
and count(studentid)>10

--16. Display customers whose average order value is greater than 200
select CustomerID,
avg(amount) as Avg_order_value 
from orders 
group by CustomerID 
having avg(amount) >200;

--17. Find departments where the salary difference (max − min) is greater than 30,000
select departmentid,
(max(salary)-min(salary)) as salary_difference 
from Employees 
group by departmentid 
having (max(salary)-min(salary))>3000;

--18. List products where the total sales value (quantity × price) is greater than 20,000.
select product_id,
sum(quantity*price) as Total_sales_value 
from sales 
group by product_id 
having sum(quantity*price)>20000 

--19. Find customers who have placed at least 2 orders but their total order value is less than 1000.
select CustomerID,
count(orderid) as Total_Order,
sum(amount) as Total_sales 
from orders 
group by CustomerID 
having count(orderid)>1 
and sum(amount)<1000;

--20. Show regions where the average product price sold is greater than 500.
select region,
avg(price) avg_price_by_region 
from sales 
group by region 
having avg(price)>500;

select * from Students
select * from Sales
select * from orders
select * from Employees