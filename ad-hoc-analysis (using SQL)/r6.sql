/*
Generate a report that calculates two metrics:

1. Monthly Repeat Passenger Rate: 
Calculate the repeat passenger rate for each city and month by comparing 
the number of repeat passengers to the total passengers.

 2. City-wide Repeat Passenger Rate: 
 Calculate the overall repeat passenger rate for each city, considering all passengers across months.

Fields:

# city_name 
# month
# total_passengers 
# repeat_passengers
# monthly_repeat_passenger_rate (%): Repeat passenger rate at the city and month level
# city_repeat_passenger_rate (%): Overall repeat passenger rate for each city, aggregated across months
 */
 
SELECT 
	city_id,
    monthname(month) 'month',
    total_passengers,
    repeat_passengers,
    ROUND((repeat_passengers/total_passengers)*100,2) 'monthly_repeat_passenger_rate (%)' ,
    ROUND((SUM(repeat_passengers) OVER w / SUM(total_passengers) OVER w )*100,2) AS 'city_repeat_passenger_rate (%)'
FROM
		fact_passenger_summary
WINDOW w AS (PARTITION BY city_id)
    
    
    
    
    
    
 