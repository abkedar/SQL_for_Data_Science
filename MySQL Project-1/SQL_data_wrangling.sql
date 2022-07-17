use classicmodels;

select * from payments;

SELECT * from customers;

drop table customer_payments_details;

create table customer_payments_details(customerNumber varchar(15), customerName varchar(50), phone varchar(20), city varchar(25), country varchar(15),
creditLimit float, checkNumber varchar(20), paymentdate date, amount float);

insert into customer_payments_details
SELECT c.customerNumber, c.customerName, c.phone, c.city, c.country, c.creditLimit, p.checkNumber, p.paymentDate, p.amount
from customers as c
left join payments as p
on c.customerNumber = p.customerNumber;

/* we want to know customer as indidual total amount paid for all product he has purchased*/
SELECT * FROM customer_payments_details;

SELECT distinct c.customerNumber, c.customerName, (SELECT ROUND(sum(c1.amount), 2) from customer_payments_details c1
where c1.customerName = c.customerName) AS customer_amount from customer_payments_details c;

/* how many people are paying above average amount of his as per his product avg price*/

select * from poduct_price;

CREATE view customer_product_details
AS SELECT c.customerNumber, c.customerName, c.phone, c.city, c.country, c.creditLimit, c.checkNumber, c.paymentDate, c.amount, p.productLine
from customer_payments_details c
left join poduct_price as p
on p.customerNumber = c.customerNumber;

SELECT * from customer_product_details;

/* Assume that people who buy product of 40000 for Motorcycles, 
we want to know average product price for Motor Cycles for each productLine. */

SELECT productLine, round(amount) AS product_price
from customer_product_details
where amount >= 40000
group by productLine
order by 2 DESC;

/* Which product were most buy  and their customer Name*/
SELECT * from customer_product_details;

SELECT DISTINCT customerName, productLine, amount
from customer_product_details as s
where amount = (SELECT MAX(amount) from customer_product_details as s2);

SELECT DISTINCT customerName, productLine, amount
from customer_product_details as s
where amount = (SELECT MIN(amount) from customer_product_details as s2);

SELECT DISTINCT customerName, productLine, amount
from customer_product_details as s
where customerName LIKE "Euro+ Shopping Channel";

/***** Grouping Sets *****************/
SELECT * FROM customer_product_details;

SELECT paymentDate, customerName, country, creditLimit, amount, productLine from customer_product_details
Group by productLine
order by 1;

SELECT * FROM employees;

SELECT employeeNumber, firstName, email, jobTitle from employees
group by jobTitle
order by 2;

/* FETCH first 5 rows */
SELECT employeeNumber, firstName, email, jobTitle from employees
group by jobTitle
order by 2 DESC
FETCH FIRST	5 ROWS ONLY;

