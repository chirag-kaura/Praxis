use Assignments;

sp_help 'dbo.Customers';

ALTER TABLE dbo.Customers
ADD CustomerName VARCHAR(100),
    SignupDate DATE;

UPDATE dbo.Customers
SET CustomerName = FirstName + ' ' + LastName;

select * from dbo.Customers;

UPDATE dbo.Customers
SET SignupDate = DATEADD(DAY, -CustomerID * 50, GETDATE());

sp_help 'dbo.orders';

EXEC sp_rename 'dbo.orders.TotalAmount', 'OrderAmount', 'COLUMN';

ALTER TABLE dbo.orders
ALTER COLUMN OrderDate DATE;

select * from orders;

CREATE TABLE dbo.OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES dbo.orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID)
);

INSERT INTO dbo.OrderDetails VALUES
(1, 70001, 1, 2, 1200),
(2, 70002, 5, 5, 25),
(3, 70003, 9, 3, 200),
(4, 70004, 3, 1, 950),
(5, 70005, 2, 4, 800),
(6, 70007, 8, 3, 150),
(7, 70008, 6, 6, 45),
(8, 70009, 10, 10, 15),
(9, 70010, 11, 2, 250),
(10,70011, 4, 1, 500),
(11,70012, 7, 2, 40),
(12,70013, 12, 3, 300);

select * from OrderDetails;

SELECT OrderID
FROM dbo.orders;

INSERT INTO dbo.orders
(OrderID, CustomerID, OrderDate, TotalAmount, Status)
VALUES
(70006, 3001, '2012-09-15', 500, 'Processing');

ALTER TABLE dbo.orders
ALTER COLUMN salesman_id INT NULL;

SELECT DISTINCT OrderID
FROM dbo.OrderDetails
WHERE OrderID NOT IN (SELECT OrderID FROM dbo.orders);

SELECT OrderID 
FROM dbo.orders
ORDER BY OrderID;

INSERT INTO dbo.orders
(OrderID, CustomerID, OrderDate, TotalAmount, Status, salesman_id)
VALUES
(70004, 3009, '2012-08-17', 110.5, 'Processing', 5003);

INSERT INTO dbo.orders
(OrderID, CustomerID, OrderDate, TotalAmount, Status, salesman_id)
VALUES
(70009, 3001, '2012-09-10', 270.65, 'Pending', 5005);


--------------------------------------------------------------------------------------------------------------------------------------
--1. Total Orders per Customer | Write a query to display each customer’s name and the total number of orders they have placed.
select c.CustomerName, count(o.OrderID) as Total_orders
        from Customers c left join orders o
        on c.CustomerID = o.CustomerID 
        group by c.CustomerName;

select * from Customers;

select * from orders;

UPDATE dbo.orders SET CustomerID = 1 WHERE CustomerID = 3001;
UPDATE dbo.orders SET CustomerID = 2 WHERE CustomerID = 3002;
UPDATE dbo.orders SET CustomerID = 3 WHERE CustomerID = 3003;
UPDATE dbo.orders SET CustomerID = 4 WHERE CustomerID = 3004;
UPDATE dbo.orders SET CustomerID = 5 WHERE CustomerID = 3005;
UPDATE dbo.orders SET CustomerID = 6 WHERE CustomerID = 3007;
UPDATE dbo.orders SET CustomerID = 7 WHERE CustomerID = 3008;
UPDATE dbo.orders SET CustomerID = 8 WHERE CustomerID = 3009;

--2. Total Revenue per Customer | Show customer name and the total order amount they have generated.
select c.CustomerName, sum(o.TotalAmount) as Total_order_number
from Customers c join orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName;


--3. Customers with More Than 5 Orders | List customers who have placed more than 5 orders.
select c.CustomerName , count( o.orderID) as Order_count
from Customers c join orders o 
on c.CustomerID = o.CustomerID
group by c.CustomerName
having count( o.orderID) > 5;

--4. Total Sales per City | Display total revenue generated from customers in each city.
select c.CustomerName, c.City,sum(o.totalamount) as Total_revenue_generated
from Customers c join orders o
on c.CustomerID = o.CustomerID
group by c.CustomerName,c.City;

--5. Average Order Amount per Customer | Show each customer and their average order value.
select c.CustomerName, avg(o.totalamount) as Avg_order_value
from Customers c join orders o
on c.CustomerID =o.CustomerID
group by c.CustomerName;

--6. Monthly Sales Report | Write a query to show total sales grouped by year and month.
select 
year(orderDate) as Order_Year,
month(orderDate) as Order_month,
sum(TotalAmount) as Total_sales
from orders
group by year(orderDate), month(orderDate);

--7. Daily Order Count | Display the number of orders placed on each day.
select OrderDate,count(orderId) as no_of_orders
from orders group by OrderDate

--8. Yearly or monthly Revenue | Show total revenue grouped by year/month.
select month(orderdate) as month_no,year(orderdate) as year, sum(TotalAmount) as Monthly_revenue 
    from orders group by month(orderdate),year(OrderDate)

--9. Customers Registered per Year | Display how many customers signed up each year.
select year(SignupDate) as signup_year, count(customerid) as customer_count from Customers group by year(signupDate);

--10. Highest Sales Month | Find the month with the highest total sales.
select top 1 month(orderdate) as month_no,year(orderdate) as year, sum(TotalAmount) as Monthly_revenue 
    from orders group by month(orderdate),year(OrderDate) order by  sum(TotalAmount) desc

--11. Total Quantity Sold per Product | Show each product and total quantity sold.
select p.ProductName,od.Quantity as Quantity_sold
from OrderDetails as od left join Products as p
on od.ProductID = p.ProductID;

--12. Revenue per Product Category | Display total revenue generated per category.
select p.Category, sum((od.quantity *p.price)) as revenue_by_category
from OrderDetails od join Products p
on od.ProductID =p.ProductID
group by p.Category;

--13. Top 3 Best-Selling Products | List top 3 products based on total quantity sold.
select top 3 p.productname, od.quantity as Quantity_sold
from OrderDetails od join Products p
on od.ProductID = p.ProductID
order by od.Quantity desc;

--14. Average Product Price per Category | Show average price of products in each category.
select category, avg(price) as Product_avg_price from Products group by Category

--15. Products Never Ordered | List products that have never been sold.
select p.productname , od.Quantity
from Products p left join orderDetails as od
on p.ProductID =od.ProductID
where od.ProductID is null;

--16. Customers with Total Purchase Above $10,000 | Show customers whose total purchase amount exceeds $10,000.
select c.CustomerName, sum(o.TotalAmount) as purch_by_customer
from Customers c join orders o
on c.CustomerID =o.CustomerID
group by c.CustomerName
having sum(o.TotalAmount) >5000;

--17. Order Status Summary | Display number of orders grouped by order status.
select status,count(orderid) as order_count from orders group by Status;

--18. City-wise Customer Count and Total Revenue | Show city, number of customers, and total revenue from each city.
select c.city, count(c.CustomerID) as no_of_customers,sum(o.TotalAmount) as revenue_by_city
from Customers c join orders o
on c.CustomerID=o.CustomerID
group by c.City;

--19. Customer with Highest Total Purchase | Find the customer who has generated the highest total revenue.
select top 1 c.CustomerName, sum(o.TotalAmount) as Revenue_generated
from Customers c join orders o
on c.CustomerID=o.CustomerID
group by c.customername
order by  sum(o.TotalAmount) desc;

--20. Average Order Value per Country (Only Countries with More Than 10 Customers) | Show country and average order value, but only include countries with more than 10 customers.
select c.Country, sum(o.TotalAmount),count(c.country)
from Customers c join orders o
on c.CustomerID = o.CustomerID
group by c.Country
having count(c.country) >2;

select * from Customers;
select * from orders;
select * from OrderDetails;
select * from Products;