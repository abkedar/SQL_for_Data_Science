/***************** Tuning Joins *******************/

-- force query plan builder to use nested loop first, just for testing purpose

use classicmodels;

select * from orders;
SELECT * FROM customers;

EXPLAIN SELECT s.status, s.orderDate, s.orderDate
FROM orders s
JOIN customers c
ON c.customerNumber = s.customerNumber;

/*
We can see that builder use Nested Lop then Index Scan using primary key (region_id).
As MsqlSQL automatically created index on primary key, we will delete this key (for testing purpose)
and see how Nest Loop will full table scan will look like in performance wise.
*/

EXPLAIN SELECT s.status, s.orderDate, s.orderDate
FROM orders s
JOIN customers c
ON c.customerNumber = s.customerNumber;

/* we can see that Cost got increased.
So main take away is when we are using any kind of joins (especially, Nested Loop), it helps to ensure foreign keys
columns and the columns you are trying to matching on are indexed properly.
*/

EXPLAIN SELECT s.id,s.last_name,s.job_title,cr.country
FROM staff s
JOIN company_regions cr
ON cr.region_id = s.region_id;