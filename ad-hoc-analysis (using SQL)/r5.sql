
/*
Generate a report that identifies the month with the highest revenue for each city.
 For each city, display the month_name, the revenue amount for that month, 
 and the percentage contribution of that month's revenue to the city's total revenue.
Fields
#city_name
#highest_revenue_month
#revenue
#percentage_contribution (%)
*/

WITH revenue_month_city AS (
	SELECT
		city_id,
		monthname(date) AS 'month_name',
		SUM(fare_amount) AS 'revenue'
	FROM
		fact_trips
	GROUP BY 
		city_id,month_name
	)
SELECT 
		city_name,
        month_name AS 'highest_revenue_month',
        revenue,
        percentage_contribution
FROM(
	SELECT 
		*,
		MAX(revenue) OVER(PARTITION BY city_id) AS 'max_revenue',
        ROUND((MAX(revenue) OVER(PARTITION BY city_id) /SUM(revenue) OVER(PARTITION BY city_id))*100,2) AS 'percentage_contribution'
	FROM 
		revenue_month_city
) t INNER JOIN dim_city c ON t.city_id = c.city_id
WHERE 
	revenue = max_revenue;







