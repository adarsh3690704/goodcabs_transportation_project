/*
Generate a report that displays the total trips, average fare per km, average fare per trip, 
and the percentage contribution of each city's trips to the overall trips.
This report will help in assessing trip volume, pricing efficiency, 
and each city's contribution to the overall trip count.

Fields:
city_name
total_trips
avg_fare_per_km
• avg_fare_per_trip
• %_contribution_to_total_trips
*/

SELECT
	c.city_name,
	COUNT(trip_id) AS 'total_trips',
    ROUND(AVG(fare_amount/distance_travelled_km),2) AS 'avg_fare_per_km',
    ROUND(AVG(fare_amount),2) AS 'avg_fare_per_trip',
    ROUND((COUNT(*)/(SELECT COUNT(*) FROM fact_trips))*100,2) AS '%_contribution_to_total_trips'
FROM 
	fact_trips t INNER JOIN dim_city c ON t.city_id = c.city_id
GROUP BY 
	t.city_id









