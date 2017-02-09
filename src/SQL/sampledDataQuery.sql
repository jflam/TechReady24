SELECT TOP 1000 
    tipped, 
    tip_amount, 
    fare_amount, 
    passenger_count, 
    trip_time_in_secs,trip_distance,
    pickup_datetime, 
    dropoff_datetime,
    cast(pickup_longitude AS float) AS pickup_longitude,
    cast(pickup_latitude AS float) AS pickup_latitude,
    cast(dropoff_longitude AS float) AS dropoff_longitude,
    cast(dropoff_latitude AS float) AS dropoff_latitude,
    payment_type 
FROM nyctaxi_sample 
TABLESAMPLE (1 percent) 
REPEATABLE (98052)
