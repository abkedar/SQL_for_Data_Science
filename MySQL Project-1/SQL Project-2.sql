/* ********************** Data Wrangling / Data Munging ********************* */
Show databases;

USE sales;

SELECT * FROM customers;

SELECT DISTINCT(product_type), COUNT(DISTINCT(product_type))as count_product_type from products;

select * from transactions;

select distinct(product_code) from transactions;

/********* Reformatting Characters Data *********/

select * from markets;

SELECT DISTINCT(UPPER(markets_name))
FROM markets
ORDER BY 1;

SELECT DISTINCT(LOWER(markets_name))
FROM markets
ORDER BY 1;

/*** Concatetation ***/

use classicmodels;

SELECT * from customers;

SELECT contactLastName, country || '-' || salesRepEmployeeNumber as country_and_Employe_code FROM customers;

/*** Trim ***/

SELECT 
		TRIM('	 data science rocks !	');
        
-- with trim is 19 characters
SELECT
		LENGTH(TRIM('	data science rocks !	'));
        
SELECT
		LENGTH('	data science rocks!	');
        
/* How many employees with Sales Representative roles */

SELECT * FROM employees;

SELECT COUNT(*) as employees_with_Sales_Rep
from employees
where jobTitle LIKE '%`Sales Rep`%';

/* What are those Sales roles? */

SELECT DISTINCT(jobTitle), jobTitle LIKE '%Sales Rep%' is_Sales_Representative from employees
order by 1;

/* -------------------------------------------------------------------------------------------- */


/********* Extracting Strings from Characters *********/
/* -- SUBSTRING('string' FROM position FOR how_many) */

/* ---------------------- SubString words ---------------------------------------------------- */

SELECT 'abcdefghijkl' as test_string;

SELECT substring('abcdefghijkl' from 5 for 7) as sub_string;

SELECT substring('abcdefghijkl' from 5) as sub_string;

SELECT jobTitle from employees;

SELECT jobTitle from employees where jobTitle LIKE '%Sales Rep%';

/* We want to extract job category from the Sales position which starts with word Sales. */

SELECT 
		SUBSTRING(jobTitle FROM LENGTH('Sales')+1) AS job_category, jobTitle
FROM employees
WHERE jobTitle LIKE 'Sales%';

/* As there are several duplicate ones, we want to know only uniques ones */

SELECT 
		DISTINCT(SUBSTRING(jobTitle FROM LENGTH('Sales')+1)) AS job_category, jobTitle
FROM employees
WHERE jobTitle LIKE 'Sales%';

/* **************************************** Replacing words ************************** */

/* We want to replace word Sales with Sal. */

SELECT
		OVERLAY(jobTitle PLACING 'Sal.' FROM 1 FOR LENGTH('Sales')) as shorten_job_title 
        from employees
        WHERE jobTitle LIKE 'Sales';
        
/* now we want to know title with sales, started with roman numerical I, followed by 1 character it
can be M etc.... as long it starts with character 

underscore _ : for one character */

SELECT * from employees;

SELECT
		DISTINCT(jobTitle) from employees
        WHERE jobTitle LIKE 'Sales R_';
        
SELECT 
	country, 
	AVG(creditLimit) AS avg_creditLimit, 
	/*TRUNC(AVG(creditLimit)) AS truncated_creditLimit,
	TRUNC(AVG(creditLimit), 2) AS truncated_creditLimit_2_decimal,*/
	ROUND(AVG(creditLimit), 2) AS rounded_creditLimit,
	CEIL(AVG(creditLimit)) AS ceiling_creditLimit,
	FLOOR(AVG(creditLimit)) AS floor_creditLimit
FROM customers
GROUP BY country;