/*
Generate a report that calculates the total new passengers for each city and ranks them based on this value.
Identify the top 3 cities with the highest number of new passengers as well as the bottom 3 cities 
with the lowest number of new passengers, categorising them as "Top 3" or "Bottom 3" accordingly.
Fields
city_name
total_new_passengers
• city_category ("Top 3" or "Bottom 3")
*/

WITH t AS (
(SELECT 
	city_id,
    SUM(total_passengers) 'total_new_passengers',
	'TOP 3' AS 'city_category'
FROM 
	fact_passenger_summary
GROUP BY
	city_id
ORDER BY 
	total_new_passengers DESC
LIMIT 3)
UNION ALL
(SELECT 
	city_id,
    SUM(total_passengers) 'total_new_passengers',
	'BOTTOM 3'
FROM 
	fact_passenger_summary
GROUP BY
	city_id
ORDER BY 
	total_new_passengers 
LIMIT 3  )  
							)
SELECT 
	city_name,
    total_new_passengers,
    city_category
FROM 
	t LEFT JOIN dim_city c ON t.city_id = c.city_id  ;