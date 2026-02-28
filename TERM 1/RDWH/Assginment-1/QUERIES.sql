create database Assignment1;

use Assignment1;
 
SELECT * FROM dbo.Bank_Account_Details;

SELECT * FROM dbo.BANK_ACCOUNT_TRANSACTION;

SELECT * FROM dbo.Bank_customer;

select count(Customer_id) as Row_count  from Bank_Account_Details;

select count(DISTINCT(CUSTOMER_ID)) as Row_count_unique_customer from Bank_Account_Details;

select Account_status,count(CUSTOMER_ID) as Count_based_on_Account_status from Bank_Account_Details group by Account_status;

select c.customer_name,d.Balance_amount
from dbo.Bank_Account_Details as d join dbo.Bank_customer as c
on c.customer_id =d.customer_id where d.Balance_amount > (select avg(d.Balance_amount) from dbo.Bank_Account_Details as d); ; 

create table Customer(
custemor_id	int,
cust_name varchar(50),	
city varchar(50),
grade int,	
salesman int,
);


bulk insert Customer 
from 'E:\Praxis\DBMS\Assginment-1\Customer.csv'
with (
fieldterminator =',',
rowterminator ='\n',
firstrow =2
);

EXEC sp_rename 'Customer.custemor_id', 'customer_id', 'COLUMN';


select * from Customer;

CREATE TABLE orders_staging (
    ord_no        VARCHAR(20),
    purch_amt     VARCHAR(20),
    ord_date      VARCHAR(30),
    customer_id   VARCHAR(20),
    salesman_id   VARCHAR(20)
);



BULK INSERT orders_staging
FROM 'E:\Praxis\DBMS\Assginment-1\Orders.csv'
WITH (
    FIRSTROW = 2,                                   -- need to remove speaial characters whike haveing trim function before inserting this into new orders table 
    FIELDTERMINATOR = ',',                          -- or else write a code with case function where special characters have to removed
    ROWTERMINATOR = '\n'
);

select * from orders_staging;
select * from orders;           --7004,7009 was dropped rows

CREATE TABLE orders (
    ord_no        INT PRIMARY KEY,
    purch_amt     DECIMAL(12,2) NOT NULL,
    ord_date      DATE NOT NULL,
    customer_id   INT NOT NULL,
    salesman_id   INT NOT NULL
);


select * from orders_staging;

insert into orders
select 
CAST (TRIM(ord_no) as int),
cast (TRIM(purch_amt) as decimal(12,2)),

    CASE
    WHEN TRY_CONVERT(DATE,trim(ord_date) ,120) is not null
            THEN TRY_CONVERT(DATE,trim(ord_date),120)        --yyyy-mm-dd         ____-__-__
    when TRY_CONVERT(DATE,trim(ord_date),105) is not null
            THEN TRY_CONVERT(DATE,trim(ord_date),105)          --dd-mm-yyyy        __-__-____
    END,

    CAST(LTRIM(RTRIM(customer_id)) as int),
    cast(LTRIM(RTRIM(salesman_id)) as int)
        from orders_staging
        WHERE 
    COALESCE(
        TRY_CONVERT(DATE, TRIM(ord_date), 120),
        TRY_CONVERT(DATE, TRIM(ord_date), 105)
    ) IS NOT NULL;

select * from orders;

select c.cust_name, sum(o.purch_amt) as Purchase_per_customer,c.customer_id from Customer c join orders o on c.customer_id=o.customer_id group by c.customer_id,c.cust_name ;

select count(ord_no) as Order_count from orders;

select * from customer c left join orders o on c.customer_id =o.customer_id

select c.*,o.ord_date from Customer c join orders o
on c.customer_id = o.customer_id where ord_date between '2012-10-04' AND '2012-10-31';

select * from Salesman;

select * from Customer;
select * from orders;

