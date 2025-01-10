/*
Monthly City-Level Trips Target Performance Report
Generate a report that evaluates the target performance for trips at the monthly and city level.
For each city and month, compare the actual total trips with the target trips and 
categorise the performance as follows:

• If actual trips are greater than target trips, mark it as "Above Target".
• If actual trips are less than or equal to target trips, mark it as "Below Target".
Additionally, calculate the % difference between actual and target trips to quantify the performance gap.
Fields:
•
City_name month_name
actual_trips
target_trips performance_status %_difference
*/

WITH actual_table AS (
	SELECT 
		city_id,
		monthname(date) AS 'month_name',
		COUNT(trip_id) AS 'actual_trips'
	FROM
		fact_trips
	GROUP BY
		city_id,month_name
						)
SELECT 
	c.city_name,
    monthname(mtt.month) AS 'month_name',
    IF(a.actual_trips<= mtt.total_target_trips,'Below Target','Above Target') AS 'actual_trips',
    ROUND(( (a.actual_trips/mtt.total_target_trips)-1)*100,2) AS 'target_trips performance_status %_difference'
FROM 
	 actual_table a LEFT JOIN targets_db.monthly_target_trips mtt
	 ON (a.city_id = mtt.city_id) AND (a.month_name = monthname(mtt.month))
     INNER JOIN dim_city c 
     ON c.city_id = a.city_id

