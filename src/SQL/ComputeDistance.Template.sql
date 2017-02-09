CREATE PROCEDURE [ComputeDistance]
AS
BEGIN
EXEC sp_execute_external_script @language = N'R'
    , @script = N'_RCODE_'
    , @input_data_1 = N'_INPUT_QUERY_'
--- Edit this line to handle the output data frame.
    WITH RESULT SETS (
	(
		[tipped] INT, 
		[tip_amount] FLOAT, 
		[fare_amount] FLOAT,
		[passenger_count] INT,
		[trip_time_in_secs] INT,
		[trip_distance] FLOAT,
		[pickup_datetime] DATETIME, 
		[dropoff_datetime] DATETIME,
		[pickup_longitude] FLOAT,
		[pickup_latitude] FLOAT,
		[dropoff_longitude] FLOAT,
		[dropoff_latitude] FLOAT, 
		[payment_type] NVARCHAR(max),
		[distance] FLOAT
	)
	);
END;
