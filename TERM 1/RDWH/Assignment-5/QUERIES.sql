select * from employees;

select * from Departments;

select * from orders;
EXEC sp_rename 'Orders.TotalAmount', 'Amount', 'COLUMN';

select * from customers;

--1. Write a query to find employees who earn more than the average salary of employees.
select FirstName + ' '+LastName as Emp_name,salary
		from employees 
				where salary > (select avg(salary) as avg_salary 
												from employees
								);

--2. Write a query to find employees who earn less than the maximum salary in the Employees table.
select FirstName + ' '+LastName as Emp_name,salary 
			from employees 
					where salary < (
									select max(salary) as max_salary 
												from employees
									);

--3. Write a query to display employees who work in the department named 'HR'
select FirstName + ' '+LastName as Emp_name 
			from employees where departmentid =(
												select departmentid 
															from departments 
																	where departmentname ='HR'
												);

--4. Write a query to find employees whose salary is equal to the minimum salary in the company.
select FirstName + ' '+LastName as Emp_name 
			from employees  
					where salary = (
										select min(salary) as min_salary 
															from Employees);

--5. Write a query to find customers who placed an order with Amount greater than 5000.
select CustomerName 
			from Customers 
					where CustomerID in (
										select customerid 
												from orders 
														where amount > (
																		select avg(t1.amount_by_customer) as avg_amount 
																					from (
																							select customerid,sum(amount) as amount_by_customer 
																									from orders group by customerid
																						) as t1
																		)
										); 

--6. Write a query to find employees who work in departments located in the Departments table (use IN subquery).
select * from Employees 
			where Departmentid in (
									select departmentid 
												from Departments
									);

--7. Write a query to find employees who are not managers (their EmployeeID is not used as ManagerID).
select * from Employees 
				where employeeid not in (
											select distinct(managerid) 
														from Employees 
																where managerid is not null
										);

--8. Write a query to find customers who have not placed any orders.
select * from Customers 
			where CustomerID not in (
										select distinct(customerid) 
													from orders
									);

--9. Write a query to find employees whose salary is greater than the salary of employee named John.
select FirstName from employees 
				where salary > (
								select salary 
										from Employees 
													where FirstName ='John'
								);

--10. Write a query to find orders placed by customers who live in New York.
select * from orders 
				where customerid in (
										select customerid 
													from Customers 
																where city ='New York'
									);

--11. Write a query to find employees who earn more than the average salary of their own department.
select * from employees e 
				where salary > (
								select avg(salary) 
											from employees 
													where departmentid =e.departmentid
								);

--12. Write a query to find customers who have placed at least one order.
select FirstName from customers 
				where customerid in (
										select customerid 
													from orders
									);


--13. Write a query to find employees who earn the highest salary in their department.
select * from Employees e 
				where salary = (
								select max(salary) 
											from employees 
													where departmentid =e.departmentid
								);


--14. Write a query to find employees whose salary is higher than their manager’s salary.
select * from Employees e 
					where salary > (
									select salary 
												from Employees 
														where employeeid =e.managerid
									);

--15. Write a query to find orders whose amount is greater than the average order amount of that customer.
select * from orders o 
				where amount > (
								select avg(amount) 
											from orders 
													where customerid=o.customerid
								);

--16. Write a query to find employees who work in the department that has the highest DepartmentID.
select * from Employees 
			where departmentid = (
									select max(departmentid) 
											from employees
								  );

--17. Write a query to find employees whose salary is greater than the average salary of employees working in the Sales department.
select * from Employees 
		where salary > (
						select avg(salary) 
								from Employees 
										where departmentid = (
																select departmentid 
																			from Departments 
																					where departmentname ='Sales'
															)
						);


--18. Write a query to find customers who placed orders greater than the minimum order amount placed by customers in Chicago.
select * from Customers 
		where CustomerID in (
								select customerid 
									from orders 
										where amount > (
														select min(amount) 
															from orders 
																where customerid = (
																					select customerid 
																						from Customers 
																							where city ='Chicago'
																					)
														) group by customerid
							);

--19. Write a query to find employees who earn more than the average salary of employees who work in the department named Finance.
select * from Employees 
	where salary > (
					select avg(salary) as Fin_avg_salary 
						from Employees 
							where departmentid = (
													select departmentid 
														from Departments 
															where Departmentname ='Finance'
												)
					);

--20. Write a query to find employees whose salary is greater than the average salary of employees who earn more than 30000.
select * from Employees 
	where salary > (
					select avg(salary) avg_6000_greater 
							from (
									SELECT * FROM Employees 
											where salary >60000
								) as t1 
					);

