--🏗️ 1️ Create Database

CREATE DATABASE company_analytics;
USE company_analytics;

--🏢 2️ Master Tables (Normalized Design – 3NF)

--📍 Locations Table
CREATE TABLE LOCATIONS(
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	location_name VARCHAR(100) NOT NULL,
	city VARCHAR(100),
	country VARCHAR(100)
);

--🏬 Departments Table
CREATE TABLE departments(
	department_id INT IDENTITY(1,1) PRIMARY KEY,
	department_name VARCHAR(100) NOT NULL,
	budget DECIMAL(15,2) CHECK (budget>0),
	location_id INT,
	CONSTRAINT FK_Department_Location
		FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

--👨‍💼 Employees Table

/*
Industry standards applied:

Identity PK

Salary check constraint

Foreign keys

Self reference for manager

Default values

Indexing column ready
*/

CREATE TABLE employees (
    emp_id INT IDENTITY(1001,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE NOT NULL DEFAULT GETDATE(),
    job_role VARCHAR(100),
    salary DECIMAL(12,2) CHECK (salary > 0),
    department_id INT,
    manager_id INT NULL,
    status VARCHAR(20) DEFAULT 'Active',

    CONSTRAINT FK_Employee_Department
        FOREIGN KEY (department_id) REFERENCES departments(department_id),

    CONSTRAINT FK_Employee_Manager
        FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

--🧑 Customers
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(100),
    created_date DATETIME DEFAULT GETDATE()
);

--🛒 Orders
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT GETDATE(),
    amount DECIMAL(12,2) CHECK (amount > 0),
    status VARCHAR(50) DEFAULT 'Completed',

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--📦 Projects
CREATE TABLE projects (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(150) NOT NULL,
    start_date DATE,
    end_date DATE
);

--👷 Employee Projects (Many-to-Many)
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    assigned_date DATE DEFAULT GETDATE(),

    PRIMARY KEY (emp_id, project_id),

    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

--🔐 Salary Audit Table (For Trigger Practice)
CREATE TABLE salary_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(12,2),
    new_salary DECIMAL(12,2),
    change_date DATETIME DEFAULT GETDATE()
);

--📊 3️ Insert Realistic Sample Data

--Locations
INSERT INTO locations (location_name, city, country) VALUES
('Head Office','New York','USA'),
('Tech Park','San Francisco','USA'),
('Corporate Hub','London','UK');

--Departments
INSERT INTO departments (department_name, budget, location_id) VALUES
('IT', 5000000, 2),
('HR', 800000, 1),
('Sales', 3000000, 3),
('Finance', 1500000, 1);

--Employees (Manager First)
INSERT INTO employees 
(first_name,last_name,email,job_role,salary,department_id,manager_id)
VALUES
('John','Smith','john.smith@company.com','CTO',150000,1,NULL),
('Sarah','Connor','sarah.connor@company.com','HR Manager',90000,2,NULL),
('David','Miller','david.miller@company.com','Sales Director',120000,3,NULL);

--Now insert employees under managers:
INSERT INTO employees
(first_name,last_name,email,job_role,salary,department_id,manager_id)
VALUES
('Alice','Johnson','alice.j@company.com','Software Engineer',85000,1,1001),
('Bob','Williams','bob.w@company.com','Software Engineer',78000,1,1001),
('Emma','Brown','emma.b@company.com','HR Executive',60000,2,1002),
('James','Davis','james.d@company.com','Sales Executive',70000,3,1003),
('Olivia','Wilson','olivia.w@company.com','Accountant',75000,4,NULL);

--Customers
INSERT INTO customers (customer_name,email,city) VALUES
('Michael Scott','michael@dundermifflin.com','Scranton'),
('Jim Halpert','jim@dundermifflin.com','Scranton'),
('Dwight Schrute','dwight@dundermifflin.com','Scranton'),
('Tony Stark','tony@starkindustries.com','New York'),
('Bruce Wayne','bruce@wayneenterprises.com','Gotham');

--Orders
INSERT INTO orders (customer_id,order_date,amount) VALUES
(1,'2024-01-10',5000),
(1,'2024-03-15',8000),
(2,'2024-02-20',12000),
(3,'2025-01-05',4000),
(4,'2025-02-10',15000),
(5,'2024-12-25',20000);

--Projects
INSERT INTO projects (project_name,start_date,end_date) VALUES
('ERP Implementation','2024-01-01','2024-12-31'),
('AI Automation','2024-03-01',NULL),
('Website Revamp','2025-01-01',NULL);

--Employee Projects
INSERT INTO employee_projects VALUES
(1004,1,GETDATE()),
(1005,1,GETDATE()),
(1004,2,GETDATE()),
(1007,3,GETDATE());

--🚀 4️ Add Industry-Level Indexes
CREATE INDEX idx_employee_salary ON employees(salary);
CREATE INDEX idx_employee_department ON employees(department_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);

--🎯 Why This Setup Is Industry Standard
/*
✔ Proper normalization (3NF)
✔ PK + FK constraints
✔ Check constraints
✔ Unique constraints
✔ Default values
✔ Identity columns
✔ Many-to-many relationship
✔ Self-referencing hierarchy
✔ Indexed performance columns
✔ Realistic salary & order data
*/



--🔥 Now You Can Practice:
/*
Joins (Employee ↔ Department ↔ Location)

Self joins (Manager hierarchy)

Window functions

Revenue analytics

Retention

Fraud detection

Median salary

Recursive CTE

Performance tuning

Index testing
*/
