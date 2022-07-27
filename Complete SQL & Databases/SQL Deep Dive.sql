/* *********** 2) Simple Exercises *********/

/* List all employees */
SELECT * FROM employees LIMIT 10;

/* Homw many employees */
SELECT COUNT(*) FROM employees;

/* Homw many times has Employees 10001 has a raise? */
SELECT COUNT(*) AS Number_of_raises FROM employees
WHERE employeeNumber = 1002;

/* What title has 10006 has? */
SELECT jobTitle FROM employees
WHERE employeeNumber = 1002;

/***************** 5) Column Concat *****************/
SELECT CONCAT(employeeNumber, 'is a ', jobTitle) AS 'EmpTitle' FROM employees LIMIT 10;

SELECT employeeNumber, CONCAT(firstname, ' ', lastName) AS "FULL NAME" FROM employees LIMIT 10;

/************** 6) Types of Functions in SQL *************/
/*
Aggerate - operate on MANY records to produce ONE value, example: SUM of salaries
Scalar - operate on EACH record Independently, example: CONCAT , it doesn't return result of concat values as one value.
*/

/*********** 7) Aggregate Functions ************/

/*
AVG()
COUNT()
MIN()
MAX()
SUM()
*/

SELECT * FROM customers;

SELECT COUNT(*) FROM customers;

SELECT MIN(creditLimit) FROM customers;

/* Get the highest creditLimit avaliable */
SELECT MAX(creditLimit) AS Max_Salary FROM customers;

/* Get the total amount of salaries paid */
SELECT * FROM payments;

/********** 9) Commenting your queries *******/
SELECT * FROM employees
WHERE firstname='Diane' AND lastname='Murphy';

SELECT SUM(amount) AS TOTAL_AMOUNT FROM payments;

/*********** 11) Filtering Data ***********/
/* Get the list of all 1 office code employees */
SELECT * FROM employees
WHERE officeCode = 1
LIMIT 10;

SELECT * FROM products;

/********** 12) AND OR *************/
SELECT * 
FROM products
WHERE productCode = 'S10_1678' and productLine = 'Motorcycles';

use sales;

SELECT * FROM transactions;

SELECT product_code, SUM(sales_amount) as total_Sales_amount, SUM(sales_qty)
FROM transactions
WHERE product_code = 'Prod003'; 

/* Show total amount for product code prod001, customer_code Cus005 */
SELECT product_code, customer_code, market_code from transactions
WHERE product_code = 'Prod003' AND ( customer_code LIKE 'Cus005' OR customer_code LIKE 'Cus006');

/* Count customer having product code as Prod003*/
SELECT COUNT(*) FROM transactions
WHERE product_code = 'Prod003';

SELECT * FROM transactions;
/***** 16) Comparison Operators *******/
/* 17) Exercises */
/* Count customer count having Sales quantity more then 60 product */
SELECT COUNT(*) FROM transactions
WHERE sales_qty >= 30 and currency = 'INR';

/* Who customer having the sales amount greater then 5000 */
SELECT COUNT(*) FROM transactions
WHERE sales_qty BETWEEN 50 and 250;

/* What is average sales amount happen in trasaction. */
SELECT AVG(sales_amount) FROM transactions
WHERE sales_qty;

/***** 19) Operator Precedence ******/
/* 
(most importance to least importance)
Parentheses
Multiplication / Division
Subtraction / Addition
NOT
AND
OR
If operators have equal precedence, then the operators are evaluated directionally.
From Left to Right or Right to Left.
check Operators Precedence.png
*/

SELECT * FROM transactions;

SELECT product_code, customer_code, market_code, order_date FROM transactions
WHERE sales_qty > 100 and (product_code='Prod003' OR product_code = 'Prod005' OR product_code = 'Prod006');

/****** 20) Operator Precedence 2 ********/
SELECT *
FROM transactions
WHERE (
	sales_qty > 80 OR (market_code = 'Mark004' AND product_code = 'Prod005')
);

USE classicmodels;

SELECT * from customers;

/* SELECT customer NUMNER either 5 or 10 creditLimit 20000 that are either from country FRANCE or Norway */
SELECT COUNT(DISTINCT(customerNumber))
FROM customers
WHERE country = 'France' and country = 'France' OR creditLimit > 20000;

/***** 22) Checking for NULL Values ****/

/* Null = Null (output: NULL)
   Null = Null (output : NULL)

No Matter what you do with NULL, it will always be NULL (substract, add, equal, etc)
*/
SELECT NULL = NULL;
SELECT NULL <> NULL;

-- return true
SELECT 1=1;

/******** 23) IS Keyword *********/
SELECT * FROM departments
WHERE dept_name = '' is FALSE; -- meeting FALSE, but not a good way to write it.

SELECT * FROM departments
WHERE dept_name = '' is NOT FALSE; 

SELECT * FROM Salaries
WHERE dept_name < 150000 IS FALSE;  -- basically saying > 150000

/******* 24) NULL Value Substituion NULL Coalesce *****/
/*
	SELECT coalesce(<column>, 'Empty') AS column_alias
	FROM <table>
	
	
	SELECT coalesce(
		<column1>,
		<column2>,
		<column3>,
		'Empty') AS combined_columns
	FROM <table>
	
Coalsece returns first NON NULL value.
*/

-- default age at 20, if there is no age available
SELECT SUM(COALESCE(age, 15)) AS avg_age
FROM students;

/*Assuming a student's minimum age for the class is 15, what is average age of a student?*/

SELECT AVG(COALESCE(first_name, 'DEFAULT')) AS first_name,
COALESCE(last_name, 'DEFAULT') AS last_name
FROM students;

SELECT SUM(COALESCE(CreditLimit, 10000)) AS avg_creditLimit
FROM customers;

/******* 28) BETWEEN AND ********/
/*
	SELECT <column>
	FROM <table>
	WHERE <column> BETWEEN X AND Y
*/


/******* 29) IN Keyword *******/
/*
	SELECT *
	FROM <table>
	WHERE <column> IN (value1, vlaue2, ...)
*/

SELECT *
FROM employees
WHERE employeeNumber IN (1002, 1056, 1102);

/******* 31) LIKE ***********/

SELECT firstName
FROM employees
WHERE firstName LIKE 'M%';

/*
	PATTERN MATCHING
	
	LIKE '%2'				: Fields that end with 2
	LIKE '%2%'				: Fields that have 2 anywhere in the value
	LIKE '_00%'				: Fields that have 2 zero's as the second and third character and anything after
	LIKE '%200%'			: Fields that have 200 anywhere in the value
	LIKE '2_%_%'			: Fields any values that start with 2 and are at least 3 characters in length
	LIKE '2___3'			: Find any values in a five-digit number that start with 2 and end with 3
*/

/****** CAST *******/
/* Postgres LIKE ONLY does text comparison so we must CAST whatever we use to TEXT */
/* Convert a value to a DATE datatype:*/
SELECT CAST("2017-08-29" AS DATE);

/* Convert a value to a CHAR datatype: */
SELECT CAST(150 AS CHAR);

/******** Case Insensitive Matching ILIKE ********
name ILIKE 'BR%'; -- matching for br, BR, Br, bR */

SELECT * FROM employees
WHERE lastName LIKE 'M%';

SELECT * FROM employees
WHERE firstName LIKE 'G%'; -- returns nothing because casesensitive

/*********** 33) Dates and Timezones **********/

/* Set current MySQL's session to UTC 
SHOW TIMEZONE;*/

SET GLOBAL time_zone = '+8:00';
SET GLOBAL time_zone = 'Europe/Helsinki';
SET @@global.time_zone = '+00:00';

/******* 36) Timestamps ***********/
/* A timestamp is a date with time and timezone info */

CREATE TABLE t1 (
  ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  dt DATETIME DEFAULT CURRENT_TIMESTAMP
);

SELECT NOW(); -- 2022-07-27 10:49:06

CREATE TABLE timezone_tmp(
ts TIMESTAMP DEFAULT 0,
tz TIMESTAMP DEFAULT 0
);

insert into timezone_tmp(ts) values('2000-01-01 10:00:00');

insert into timezone_tmp(tz) values('2000-01-01 10:00:00');

SELECT * FROM timezones_tmp;

/********* 37) Date Functions **********/

SELECT NOW(); 									/* 2021-05-04 11:17:30.418998+08 */

SELECT MONTH(NOW()); 							/* 2021-05-04 */
SELECT TIME(NOW()); 							/* 11:18:22.483492 */

SELECT CURRENT_DATE; 							/* 2021-05-04 */
SELECT CURRENT_TIME; 							/* 11:19:11.726931+08:00 */

/********* Format Modifier *********/
/*
	D		: Day
	M		: Month
	Y 		: Year
	Check MySQL doc for full details.
*/

SELECT CHAR(CURRENT_DATE);   	/* 04/05/2021 */
SELECT CHAR(CURRENT_DATE, 'ddd'); 			/* 124 */

/*********** 38) Date Difference and Casting ***********/

SELECT DATEDIFF('2008-05-17 11:31:31','1800/01/01');               	
SELECT DATE '1800/01/01';  					/* 1800-01-01 */

SELECT TIMESTAMPDIFF(YEAR, '1800/01/01', NOW());				/* 221 years 4 mons 3 days */
SELECT TIMESTAMPDIFF(MONTH, '1800/01/01', NOW());

SELECT DATEDIFF(CURDATE(), '2014-02-14');

/* difference between two dates */
SELECT DATEDIFF(CURDATE(),'1800/01/01');               	/* 80842 days 10:11:08.965674 */

/*********** 40) Extracting Information ************/

SELECT EXTRACT(MONTH FROM "2017-06-15") AS WEEK;
SELECT EXTRACT(YEAR FROM "2017-06-15") AS YEAR;
SELECT EXTRACT(WEEK FROM '1992/11/13') AS WEEK;

/********* 41) Intervals *********/
/* It can store and manipulate a period of time in years, months, days, hours, minutes, seconds, etc */

SELECT '2018-10-31' + INTERVAL 1 DAY;

SELECT '2018-10-18' - INTERVAL 30 DAY;

/********** 43) DISTINCT *************/
/* 
	remove duplicates 
	SELECT
		DISTINCT <col1>, <col2>
	FROM <table>
*/
/*product_code, customer_code, market_code, order_date*/

use sales;
SELECT DISTINCT(market_code) FROM transactions;

/********* 45) Sorting Data ********/
/*
	SELECT * FROM Customers
	ORDER BY <column> [ASC/DESC]
*/
use classicmodels;

SELECT firstName, lastName
FROM employees
ORDER BY firstName, lastName DESC
LIMIT 10;

/******** Using Expressions *******/
SELECT DISTINCT lastName, LENGTH(lastName)
FROM employees
ORDER BY LENGTH(lastName) DESC;

/********* 46) Multi Tables SELECT *********/
SELECT e.salesRepEmployeeNumber, 
	CONCAT(e.contactFirstName, e.contactLastName) AS full_name,
	s.orderNumber,
	s.shippedDate, s.status
FROM customers as e, orders as s
WHERE e.customerNumber = s.customerNumber
ORDER BY e.customerNumber;

/******** 47) Inner JOIN ************/

SELECT e.emp_no, 
	CONCAT(e.first_name, e.last_name) AS full_name,
	s.salary,
	s.from_date, s.to_date
FROM employees as e
JOIN salaries as s ON s.emp_no = e.emp_no
ORDER BY e.emp_no;

/* 
we want to know the latest salary after title change of the employee
salary raise happen only after 2 days of title change
*/
SELECT e.emp_no,
		CONCAT(e.first_name, e.last_name) AS "Name",
		s.salary,
		t.title,
		t.from_date AS "Promoted on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
AND t.from_date = (SELECT s.from_date + INTERVAL 2 day)
ORDER BY e.emp_no ASC, s.from_date ASC;

/* we want to know the original salary and also the salary at a promotion */
SELECT e.emp_no,
		CONCAT(e.first_name, e.last_name) AS "Name",
		s.salary,
		COALESCE(t.title, 'no title change'),
		COALESCE(astext(t.from_date), '-') AS "title take on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN titles t ON e.emp_no = t.emp_no
AND (
	s.from_date = t.from_date								-- original salary
	OR t.from_date = (SELECT s.from_date + INTERVAL 2 day)		-- promoted salary
)
ORDER BY e.emp_no ASC, s.from_date ASC;

/********* 48) Self Join *********/
/*
	This usually can be done when a table has a foreign key referencing to its primary key
| id | name	| startDate | supervisorId|
| 1	 | David| 1990/01/01| 2 |
| 2  | Ric  | 1980/06/03|   |
*/

/* we want to see employee info with supervisor name */
SELECT a.id, a.name AS employee_name, a.startDate, 
		b.name AS supervisor_name
FROM employees a
JOIN employees b ON a.supervisorId = b.id;

/* Which employees are manager ? */
SELECT emp.emp_no, dept.emp_no
FROM employees emp
LEFT JOIN dept_manager dept ON emp.emp_no = dept.emp_no
WHERE dept.emp_no IS NOT NULL;

/* How many employees are NOT manager? */
SELECT COUNT(emp.emp_no)
FROM employees emp
LEFT JOIN dept_manager dept ON emp.emp_no = dept.emp_no
WHERE dept.emp_no IS NULL;

/* We want to know every salary raise and also know which ones were a promotion */
SELECT e.emp_no, s.salary, 
	COALESCE(t.title, 'No Title Change'),
	COALESCE(astext(t.from_date), '-') AS "Title taken on"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
LEFT JOIN titles t ON e.emp_no = t.emp_no
	AND (
			t.from_date = s.from_date 
			OR t.from_date = s.from_date + INTERVAL 2 day
		)
ORDER BY e.emp_no, s.from_date;

/******** 50) Less Common Joins ************/

/***** Cross Join ******/
/*
	Create a combination of every row
*/
CREATE TABLE cartesianA (id INT);
CREATE TABLE cartesianB (id INT);

INSERT INTO cartesianA VALUES (1);
INSERT INTO cartesianA VALUES (2);
INSERT INTO cartesianA VALUES (3);

INSERT INTO cartesianB VALUES (1);
INSERT INTO cartesianB VALUES (2);
INSERT INTO cartesianB VALUES (4);
INSERT INTO cartesianB VALUES (5);
INSERT INTO cartesianB VALUES (20);
INSERT INTO cartesianB VALUES (30);

SELECT *
FROM cartesianA
CROSS JOIN cartesianB;

/******** Full Outer Join ********/
/*
	Return results from Both whether they match or not
*/

SELECT *
FROM cartesianA a
JOIN cartesianB b ON a.id = b.id; 

SELECT emp.emp_no, emp.first_name, emp.last_name, d.dept_name
FROM employees emp
JOIN dept_emp dept USING(emp_no)								-- same as ON emp.emp_no = dept.emp_no
JOIN departments d USING(dept_no)





