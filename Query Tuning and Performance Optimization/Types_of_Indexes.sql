/***************** Types of Indexes ************************/
/*
B-tree indexes
Bitmap indexes
Hash indexes
PostgreSQL specific indexes
*/



/************** B-tree Indexing (Binary Tree Indexing) ******************/

-- check on full table scan
EXPLAIN SELECT * FROM staff
WHERE email = 'kedarbhande@gmail.com';

-- create index 
CREATE INDEX idx_email ON staff(mail);

EXPLAIN SELECT * FROM staff
WHERE email = 'kedarbhande@gmail.com';

/******************** Bit Map Indexing *********************/

SELECT * FROM employees;
-- get all unique job titles

SELECT DISTINCT(jobTitle)
FROM employees
ORDER BY jobTitle;

EXPLAIN SELECT *
FROM employees WHERE jobTitle = 'VP Sales';

-- create index
CREATE INDEX idx_staff_job_title on employees(jobTitle);

EXPLAIN SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM
    employees
WHERE
    jobTitle = 'Sales Rep';
    
/* 
now we can see query plan is used Bitmap Heap Scan using Bitmap index 
In MySQL, we don't need to explicty create bitmap index. 
MySQL will create on the fly if it finds situation if bitmap index is needed.
*/
EXPLAIN SELECT *
FROM employees
WHERE jobTitle = 'Sales Rep';

/************** Hash Index ******************/

-- create index
CREATE INDEX idx_staff_email ON employees USING HASH(email);

EXPLAIN SELECT * FROM employees
WHERE email = 'dmurphy@classicmodelcars.com';


