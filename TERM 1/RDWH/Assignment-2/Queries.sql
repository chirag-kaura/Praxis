sp_help 'dbo.Employees';

sp_help 'dbo.Departments';

sp_help 'dbo.Customers';

sp_help 'dbo.orders';

select * from orders;

EXEC sp_rename 'dbo.orders.ord_no', 'OrderID','COLUMN';

EXEC sp_rename 'dbo.orders.purch_amt', 'TotalAmount', 'COLUMN';

EXEC sp_rename 'dbo.orders.ord_date', 'OrderDate', 'COLUMN';

EXEC sp_rename 'dbo.orders.customer_id', 'CustomerID', 'COLUMN';

ALTER TABLE dbo.orders
ADD Status VARCHAR(20);

UPDATE dbo.orders
SET Status = 
    CASE 
        WHEN TotalAmount < 200 THEN 'Pending'
        WHEN TotalAmount BETWEEN 200 AND 1000 THEN 'Processing'
        ELSE 'Shipped'
    END;

CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
);

INSERT INTO dbo.Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES
(1, 'Pro Laptop',        'Electronics', 1200.00, 30),
(2, 'Basic Laptop',      'Electronics', 800.00, 75),
(3, 'Smartphone Pro',    'Electronics', 950.00, 45),
(4, 'Smartphone Lite',   'Electronics', 500.00, 120),
(5, 'Wireless Mouse',    'Accessories', 25.00, 300),
(6, 'Gaming Mouse',      'Accessories', 45.00, 150),
(7, 'Test Speaker',      'Audio',       40.00, 200),
(8, 'Super Speaker',     'Audio',       150.00, 20),
(9, 'Pro Headphones',    'Audio',       200.00, 40),
(10,'Standard Charger',  'Accessories', 15.00, 500),
(11,'Smart Watch',       'Wearables',   250.00, 60),
(12,'Basic Tablet',      'Electronics', 300.00, 80),
(13,'Premium Tablet',    'Electronics', 600.00, 35),
(14,'Test Cable',        'Accessories', 10.00, 400),
(15,'Speaker Lite',      'Audio',       100.00, 55);

select * from Products;

INSERT INTO dbo.Employees 
(EmployeeID, FirstName, LastName, Salary, DepartmentID, HireDate, City, ManagerID)
VALUES
(1, 'John', 'Smith', 75000, 2, '2019-05-10', 'New York', NULL),
(2, 'Anna', 'Johnson', 48000, 1, '2018-03-15', 'Los Angeles', 1),
(3, 'Mark', 'Anderson', 62000, 3, '2021-07-20', 'Chicago', 1),
(4, 'James', 'Brown', 85000, 2, '2023-01-05', 'New Jersey', 1),
(5, 'Sara', 'Mason', 40000, 5, '2020-09-12', 'Boston', 2),
(6, 'Jake', 'Wilson', 72000, 4, '2022-06-01', 'Los Angeles', 1),
(7, 'Jill', 'Martin', 68000, 3, '2021-11-11', 'New York', 3),
(8, 'Adam', 'Robertson', 55000, 1, '2017-04-18', 'Seattle', 2);

select * from Employees;

INSERT INTO dbo.Departments (DepartmentID, DepartmentName, Location)
VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'Los Angeles'),
(3, 'Finance', 'Chicago'),
(4, 'Marketing', 'Houston'),
(5, 'Sales', 'Boston');

select * from Departments;
select * from orders;

INSERT INTO dbo.Customers
(CustomerID, FirstName, LastName, City, Country, Email)
VALUES
(1, 'Alice', 'Brown', 'New York', 'USA', 'alice@gmail.com'),
(2, 'Brian', 'Smith', 'Toronto', 'Canada', 'brian@yahoo.com'),
(3, 'Andrew', 'Clark', 'London', 'UK', NULL),
(4, 'Amanda', 'Davis', 'Chicago', 'USA', 'amanda@gmail.com'),
(5, 'Daniel', 'White', 'Los Angeles', 'USA', 'daniel@hotmail.com'),
(6, 'Anita', 'Baker', 'Houston', 'USA', 'anita@gmail.com'),
(7, 'Ben', 'Wilson', 'Vancouver', 'Canada', NULL),
(8, 'Aaron', 'Morris', 'New York', 'USA', 'aaron@gmail.com');

select * from Customers;

-------------------------------------------------------------------------------------
--1. Employees who earn more than 50,000
select * from dbo.Employees where Salary > 50000;

--2. Employees hired before January 1, 2020
select * from Employees where HireDate < '2020-01-01';

--3. Products that cost exactly 100
select * from Products where Price = 100

--4. Customers not from 'USA'
select * from Customers where Country != 'USA';

--5. Orders with total amount ≥ 500
select * from orders where purch_amt >=500;

--6. Employees salary between 40,000 and 80,000
select * from Employees where Salary between 40000 and 80000;

--7. Products priced between 10 and 50
select * from Products where price between 10 and 50

--8. Orders placed between 2023-01-01 and 2023-12-31
select * from orders where ord_date between '2023-01-01' and '2023-12-31'

--9. Employees in DepartmentID 1, 3, or 5
select * from Employees where DepartmentID in (1,3,5);

--10. Customers from USA, Canada, or UK
select * from Customers where Country in ('USA','Canada','UK');

--11. Orders with status Pending, Processing, or Shipped
select * from orders where status in ('Pending', 'Processing', 'Shipped');

--12. Customers whose first name starts with 'A'
select * from Customers where FirstName like 'a%';

--13. Products whose name contains 'Pro'
select * from Products where ProductName like '%pro%';

--14. Employees whose last name ends with 'son'
select * from Employees where LastName like '%son';

--15. Employees who do not have a manager assigned
select * from Employees where ManagerID IS NULL;

--16. Customers who have an email address.
select * from Customers where Email is not null;

--17. Employees earning more than 60,000 AND in Department 2
select * from Employees where Salary >60000 and DepartmentID =2;

--18. Customers from USA AND live in New York
select * from Customers where Country ='USA' and City ='New York';

--19. Products costing more than 100 AND stock < 50
select * from Products where Price >100 and StockQuantity < 50;

--20. Employees hired after 2020 AND NOT in Department 4
select * from Employees where HireDate > '2020-12-31' and DepartmentID != 4;

--21. Customers whose email ends with '@gmail.com'
select * from Customers where Email like '%@gmail.com';

--22. Employees whose first name starts with 'J' and has exactly 4 letters
select * from Employees where FirstName like 'J___';

--23. Products whose name starts with 'S' and ends with 'e'
select * from Products where ProductName like 'S%e';

--24. Employees whose last name starts with 'M' AND salary > 70,000
select * from Employees where LastName like 'M%' and Salary >70000;

--25. Customers whose first name contains 'an' AND from USA
select * from Customers where FirstName like '%an%' and Country = 'USA';

--26. Products containing 'Pro' AND price between 100 and 500
select * from Products where ProductName like 'Pro' and price between 100 and 500;

--27. Customers whose first name starts with 'A' OR last name starts with 'B'
select * from Customers where FirstName like 'a%' or LastName like 'b%';

--28. Employees whose city starts with 'New' OR 'Los'
select * from Employees where city like 'New%' or city like 'Los%';

--29. Products whose name does NOT start with 'Test' AND price < 50
select * from Products where ProductName not like 'Test%' and Price <50;

--30. Employees hired after 2022-01-01 and email does NOT contain 'temp'
select * from Employees where HireDate >'2022-01-01' and email not like '%temp%';