USE energy_management;

select * from energy_management.`young_people_survey_columns`;

select * from energy_management.`airbnb_listings`;

select * from energy_management.`san_francisco_salaries`;

select * from energy_management.`student-alcohol-mat`;

select * from energy_management.`airbnb_calendar`;

select id, last_scraped, name, summary, space, description, access, thumbnail_url, medium_url, picture_url, 
host_name, host_url, host_since, host_location, host_response_rate, host_acceptance_rate, host_is_superhost
host_neighbourhood, host_listings_count, host_total_listings_count, host_verifications, city, neighbourhood, 
state, zipcode, market, smart_location, country_code, country, latitude, longitude, property_type, room_type, accommodates, bathrooms, bedrooms, beds, 
bed_type, menities, price, cleaning_fees, huest_include, extra_people, minimum_nights, maximum_nights, calendar_updated
availablity_30, availablity_60, availablity_90, availablity_365, number_of_review, review_scores_rating, review_scores_accuracy, 
review_scores_cleanlines, review_scores_checkin, review_scores_communication, review_scores_location, review_scores_value, requires_license, 
jurisdiction_names, instant_bookable, cancellation_policy from energy_management.`airbnb_listings`;

select * FROM san_francisco_salaries;

CREATE VIEW san_francisco__employe_salaries
AS
	SELECT
    s.JobTitle,
    (
		s.TotalPay > (SELECT ROUND(AVG(s2.TotalPay), 2)
        FROM san_francisco_salaries s2
        where s2.TotalPay = s.TotalPay)
	) AS ishigher_than_dept_avg_salary
    from energy_management.`san_francisco_salaries` s
    order by s.JobTitle;
    
SELECT * from energy_management.`san_francisco__employe_salaries`;

SELECT JobTitle, san_francisco__employe_salaries, COUNT(*) as total_employees from energy_management.`san_francisco_salaries`
GROUP BY 1, 2;

/* Assume that people who earn at latest 100,000 salary is Executive.
We want to know the average salary for executives for each department. */

select * from energy_management.`san_francisco_salaries`;

SELECT JobTitle, ROUND(AVG(TotalPay), 2) as average_salary
from energy_management.`san_francisco_salaries` 
WHERE TotalPay >= 100000
GROUP BY JobTitle
Order by 2 DESC;

/* who earn the most in the company? 
It seems like Stanley Grocery earns the most.
*/

select * from energy_management.`san_francisco_salaries`;

SELECT EmployeeName, JobTitle, BasePay
from energy_management.`san_francisco_salaries`
WHERE BasePay = (SELECT MAX(s2.BasePay)
				FROM energy_management.`san_francisco_salaries` as s2
                );
                
/* who earn the most in his/her own department */
/* Based on the results, we see that there are some missing rows returns. We know that there are 900 staffs.
*/

SELECT s.department, s.last_name, s.salary
from staff s
where s.salary = (SELECT MAX(s2.salary)
					from staff s2
                    where s2.department = s.department)
Order by 1;

/* full details info of employees with company division */
SELECT s.last_name, s.department, cd.company_division
FROM staff s
JOIN company_divisions cd
	on cd.department = s.department
WHERE company_division is NULL;

/* who are those people with missing company division? */
CREATE VIEW vw_staff_div_reg AS
	SELECT s.*, cd.company_division, cr.company_regions
	FROM staff s
	LEFT JOIN company_divisions cd ON s.department = cd.department
	LEFT JOIN company_regions cr ON s.region_id = cr.region_id;

SELECT COUNT(*)
FROM vw_staff_div_reg;

/* How many staff are in each company regions */
SELECT company_regions, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 1
ORDER BY 1;

SELECT company_regions, company_division, COUNT(*) AS total_employees
FROM vw_staff_div_reg
GROUP BY 1,2
ORDER BY 1,2;

SELECT * FROM company_regions; 

CREATE OR REPLACE VIEW vm_staff_div_reg_country AS
	SELECT s.*, cd.company_division, cr.company_regions, cr.country
    FROM staff s
    LEFT JOIN company_divisions cd on s.department = s.staff
    LEFT JOIN company_regions cr on s.region_id = cr.region_cd;

/* employees per regions and country */
SELECT company_regions, country, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY 
	company_regions, country
ORDER BY country, company_regions;

/* number of employees per regions & country, Then sub totals per Country, Then toal for whole table*/
SELECT country,company_regions, COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY
	ROLLUP(country, company_regions)
ORDER BY country, company_regions;

/* What are the top salary earners ? */
SELECT last_name, salary
FROM staff
ORDER BY salary DESC
FETCH FIRST	10 ROWS ONLY;
	
	
/* Top 5 division with highest number of employees*/
SELECT
	company_division,
	COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY company_division
ORDER BY company_division
FETCH FIRST 5 ROWS ONLY;



SELECT
	company_division,
	COUNT(*) AS total_employees
FROM vw_staff_div_reg_country
GROUP BY company_division
ORDER BY company_division
LIMIT 5;