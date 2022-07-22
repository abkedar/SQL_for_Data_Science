/******** Commonly Used Functions for Time Series ***********/

/* we will assume last digit of server_id is department id */
CREATE VIEW time_series.vm_utilization AS(
	SELECT *, server_id % 10 as dept_id
    from time_series.utilization
    );
    
SELECT * FROM time_series.vm_utlization
LIMIT 5;

-- ------------------- LEAD() function ---------------------------

-- LEAD() looks forwards aand allow us to compare condition with the next nth row of current row.
-- use can also put offset of how many next rows we want to get.

-- next 1 row
SELECT depth_id, server_id, cpu_utilization,
	LEAD(cpu_utilization) OVER (PARTITION BY depth_id ORDER BY cpu_utilization DESC) 
FROM time_series.vm_utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';

-- next 3 row 
SELECT depth_id, server_id, cpu_utilization,
	LEAD(cpu_utilization, 3) OVER (PARTITION BY depth_id order by cpu_utilization DESC)
FROM time_series.vm_utilization
where event_time BETWEEN '2019-03-05' AND '2019-03-06';