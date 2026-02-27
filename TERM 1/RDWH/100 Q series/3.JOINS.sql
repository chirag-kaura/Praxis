use company_analytics;
--🔵 SECTION 3: JOINS (15 Questions)

--	Assume tables: employees, departments, orders, customers

--	26(E) Get employee names along with department names.
SELECT concat(e.first_name,' ',e.last_name) as Employee_name,d.department_name
			from employees e join departments d
			on e.department_id =d.department_id;

--	27(E) Show all employees even if department is missing.
Select concat(e.first_name,' ',e.last_name) as Employee_name,d.department_name
			from employees e left join departments d
			on e.department_id =d.department_id;

--	28(E) Show all departments even if no employees exist.
Select concat(e.first_name,' ',e.last_name) as Employee_name,d.department_name
			from employees e right join departments d
			on e.department_id =d.department_id;

--	29(M) Get customers and their orders.
SELECT c.*,o.* 
from customers c join orders o
on c.customer_id = o.customer_id;

--	30(M) Get customers who have not placed any orders.
------------------STILL NEED TO ALTER TABLE FOR THAT------------
================================================================
================================================================

--	31(M) Find employees working in 'Sales'.
SELECT e.*, d.department_name 
		from employees e join departments d
		on e.department_id = d.department_id
		where d.department_name ='Sales';

--	32(M) Count number of employees per department using JOIN.
SELECT count(e.emp_id) as Employee_count,d.department_name 
from employees e join departments d
on e.department_id = d.department_id
group by d.department_name;

--	33(M) Find highest paid employee in each department.
SELECT e.first_name, e.salary,e.job_role, d.department_name
		from employees e join departments d
		on e.department_id =d.department_id
		where e.salary = (select max(e2.salary) 
				from employees e2 where e2.department_id=e.department_id);

--	34(M) Get total order amount per customer.
select c.customer_name,c.customer_id,sum(o.amount) as Total_order_amount
from customers c join orders o
on c.customer_id =o.customer_id
group by c.customer_id,c.customer_name; 

--	35(M) Get customers with total purchase > 10,000.
select c.customer_name ,sum(o.amount) as Total_purchase 
		from customers c join orders o
		on c.customer_id = o.customer_id
		group by c.customer_id,customer_name having sum(o.amount) >10000;

--	36(H) Self join: Find employees where their manager earns 10000 more than their employee.
Select e.emp_id,e.first_name as employee_name,
e.salary as employee_salary,m.first_name as Manager_name,
m.salary as Manager_salary
		from employees e join employees m
		on e.manager_id = m.emp_id
			where m.salary -e.salary >10000;

--	37(H) Find second highest salary using JOIN.
select salary
	from (select salary,
		DENSE_RANK() over (order by salary desc) as rnk
		from employees) as ranked_employees
		where rnk =2;


--	38(H) Get department-wise highest salary employee details.
select e.*,d.department_name 
from employees e join departments d
on e.department_id = d.department_id
where e.salary = (select max(e2.salary) from employees e2 where e2.department_id =e.department_id);

--	39(H) Get customers who placed orders in 2024 but not 2025.
----------------------------Need to alter table for this question-----------------
======================================================================================
================================================================================

--	40(H) Multi-table join: employees → departments → locations.
--Show employee details along with their department and location details.
select e.emp_id,e.first_name,d.department_name,l.location_name 
		from employees e
			join departments d
					on e.department_id = d.department_id
			join locations l
					on	d.location_id =l.location_id;


SELECT * FROM customers;
SELECT * FROM orders;


Select * from departments;
Select * from employees;
Select * from locations;
