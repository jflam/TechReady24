-- Place SQL query retrieving data for the R stored procedure here

select top 1000 
	tipped, 
	tip_amount, 
	fare_amount,     
	passenger_count,
	trip_time_in_secs,
	trip_distance,     
	pickup_datetime, 
	dropoff_datetime,     
	cast(pickup_longitude as float) as pickup_longitude,
	cast(pickup_latitude as float) as pickup_latitude,
	cast(dropoff_longitude as float) as dropoff_longitude,
	cast(dropoff_latitude as float) as dropoff_latitude, 
	payment_type 
from nyctaxi_sample 
tablesample (1 percent) 

repeatable (98052)