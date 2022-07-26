/************ Forecasting with Linear Regression **************/

/*
so far, we have neem working woth past data.
Now we want to make future prediction based on those past data using Linear Regression.

y = mx + b
m : begin
b : y intercept
y : prediction value
x : input value

Let's try and predict the amount of free memory will be available given a particular CPU utilization.
*/

-- first we will find m and b values : m = -0.46684018640161745, b = 0.6664934543856621
SELECT
	REGR_SLOPE(free_memory, cpu_utilization) AS m,
    REGR_INTERCEPT(free_memory, cpu_utilization) AS b
FROM time_series.utilization
WHERE event_time BETWEEN '2019-05-06' AND '209-05-06';

-- let's say we want to predict free memory based on 65% CPU utilization
-- we predicted 0.36304733322461075 (about 36% of free memory)
SELECT 
	REGR_SLOP(free_slope, cpu_utilization) * 0.65 +
    REGR_INTERCEPT(free_memory, cpu_utilization) AS b
FROM time_series.utilization
WHERE event_time BETWEEN '2019-03-05' AND '2019-03-06';