use classicmodels;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM customers;

SELECT * FROM orderdetails;

SELECT orderNumber FROM orderdetails limit 5;

/* GET CUSTOMER COUNT */
SELECT COUNT(customerName) FROM customers;

/* GET COUNTRY COUNT*/
SELECT country, COUNT(*) as count FROM customers
GROUP BY country
order by count DESC;

/* GET DISTINCT JOBTITLE  */
select distinct jobTitle from employees;

/* GET MAX order Purchase */
select MAX(priceEach) FROM orderdetails;

/* GET MIN, MAX, AVG PRODUCT MARKET PRICE COUNT */
SELECT productLine, MAX(MSRP) as Max_MRP, MIN(MSRP) as Min_MRP, AVG(MSRP) as Average_MRP from products;


/* want to know distribution of min, max, average order by product line ? */
SELECT productLine, MAX(MSRP) as Max_MRP, MIN(MSRP) as Min_MRP, AVG(MSRP) as Average_MRP from products
GROUP BY productLine
order by productLine;

/* Which product has highest product price spread out */
SELECT productLine, MAX(buyPrice) as Max_MRP, MIN(buyPrice) as Min_MRP, ROUND(AVG(buyPrice), 2) as AVG_Price, ROUND(var_pop(buyPrice), 2) as Variance_Price, 
ROUND(STDDEV_POP(buyPrice), 2) as Standard_Price from products
group by productLine
order by 6 DESC;

/* Let's see Motorcycles Price */
SELECT productLine, buyPrice from products
WHERE productLine like 'Motorcycles'
order by 2 DESC;

select * from customers;
select * from orderdetails;
select * from orders;
select * from products;

/* we will make 3 buckets to see the creditLimit status for MotorCycles */
/* FIRST WE NEED TO JOIN "CUSTOMERS", "ORDERDETAILS", "ORDERS", "PRODUCTS" 
BASE ON COMMON COLUMN IN EACH TABLE*/

CREATE TABLE poduct_price(customerNumber varchar(15), creditLimit float, orderNumber varchar(15), productLine varchar(25));

insert into poduct_price
select c.customerNumber, c.creditLimit, d.orderNumber, p.productLine  
from customers as c
INNER join orders as o on c.customerNumber = o.customerNumber
INNER join orderdetails as d on o.orderNumber = d.orderNumber
INNER join products as p on p.productCode = d.productCode
order by customerNumber;

SELECT * FROM poduct_price;

SELECT creditLimit, avg(creditLimit), min(creditLimit), max(creditLimit) from poduct_price;

create view product_price_range
as
	select 
		case
			when creditLimit <= 21000 THEN `Lower`
            when creditLimit > 21000 and creditLimit <= 149999 Then `Middle`
            when creditLimit > 150000 then `Higher`
		End as credit_status
	from poduct_price
    where productCode LIKe `Motorcycles`;



select o.orderNumber