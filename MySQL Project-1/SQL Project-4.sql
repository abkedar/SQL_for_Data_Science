USE classicmodels;

/* customer creditLimit vs average creditLimit of customer*/
SELECT customerNumber, country, customerName, creditLimit, AVG(creditLimit) OVER (PARTITION BY country)
FROM customers;

/* customer creditLimit vs max creditLimit of customer*/
SELECT 
	customerNumber, country, customerName, creditLimit, MAX(creditLimit) OVER (PARTITION BY country)
FROM customers;

/* employee salary vs min salary of his/her Company Region */
SELECT
	customerNumber, country, customerName, creditLimit, MIN(creditLimit) OVER (PARTITION BY country)
from customers;

-- -------------------  FIRST_VALUE()  ---------------------------

SELECT customerNumber, country, customerName, first_value(creditLimit) OVER (PARTITION BY customerName ORDER BY creditLimit DESC)
FROM customers;

SELECT * FROM customers;

/* this is same as above one, but above query is much cleaner and shorter */
SELECT country, contactLastName, creditLimit, MAX(creditLimit) OVER (PARTITION BY country)
FROM customers
ORDER BY country ASC, creditLimit DESC; 

-- -------------------  RANK ()  ---------------------------

/* compare with the creditLimit of customerName whose last name is in ascenidng in that country */
SELECT customerName, contactLastName, contactFirstName, country, creditLimit, RANK() OVER (PARTITION BY country ORDER BY creditLimit DESC)
FROM customers;

-- -------------------  ROW_NUBMER ()  ---------------------------
-- same as above
SELECT customerName, contactLastName, contactFirstName, country, creditLimit, ROW_NUMBER() OVER (PARTITION BY country ORDER BY creditLimit DESC)
from customers

--------------------- LAG() function ---------------------------
-- to reference rows relative to the currently processed rows.
-- LAG() allows us to compare condition with the previous row of current row.

/* we want to know person's salary and next lower salary in that department */
/* that is an additional column LAG. First row has no value because there is no previous value to compare.
So it continues to next row and lag value of that second row will be the value of previous row, etc.
It will restart again when we reache to another department.
*/
SELECT 
	department,
	last_name,
	salary,
	LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;



--------------------- LEAD() function ---------------------------
-- opposite of LAG()
-- LEAD() allows us to compare condition with the next row of current row.
-- now the last line of that department's LEAD value is empty because there is no next row value to compare.
SELECT 
	department,
	last_name,
	salary,
	LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;


--------------------- NTILE(bins number) function ---------------------------
-- allows to create bins/ bucket

/* there are bins (1-10) assigned each employees based on the decending salary of specific department
and bin number restart for another department agian */
SELECT 
	department,
	last_name,
	salary,
	NTILE(10) OVER(PARTITION BY department ORDER BY salary DESC)
FROM staff;

	

