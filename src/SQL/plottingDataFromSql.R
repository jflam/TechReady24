
# Note that this code must be run
# using the latest Microsoft R Client

# Plotting data from SQL

source("dependencies.R")
source("Settings.R")

library(RevoScaleR)

# Define a DataSource with a query (sample 1% of data and take 
# 1000 observations # from that sample) 

sampleDataQuery <- "select top 1000 tipped, tip_amount, fare_amount, passenger_count, trip_time_in_secs,trip_distance,     pickup_datetime, dropoff_datetime,     cast(pickup_longitude as float) as pickup_longitude,     cast(pickup_latitude as float) as pickup_latitude,     cast(dropoff_longitude as float) as dropoff_longitude,     cast(dropoff_latitude as float)  as dropoff_latitude, payment_type from nyctaxi_sample tablesample (1 percent) repeatable (98052) "

ptypeColInfo <- list(
    payment_type = list(
        type = "factor", 
        levels = c("CSH", "CRD", "DIS", "NOC", "UNK"), 
        newLevels = c("CSH", "CRD", "DIS", "NOC", "UNK")))

inDataSource <- RxSqlServerData(
    sqlQuery = sampleDataQuery, 
    connectionString = dbConnection, 
    colInfo = ptypeColInfo, 
    colClasses = c(
        pickup_longitude = "numeric", 
        pickup_latitude = "numeric", 
        dropoff_longitude = "numeric", 
        dropoff_latitude = "numeric"
    ),
    rowsPerRead = 500)

# Plot a histogram

rxHistogram(~fare_amount, data = inDataSource, title = "Fare Amount Histogram")

# Plot a map

mapPlot <- function(inDataSource, googMap) {
    library(ggmap)
    library(mapproj)
    ds <- rxImport(inDataSource)
    p <- ggmap(googMap) + geom_point(aes(x = pickup_longitude, y = pickup_latitude), data = ds, alpha = .5, color = "darkred", size = 1.5)
    return(list(myplot = p))
}

library(ggmap)
library(mapproj)
gc <- geocode("Times Square", source = "google")
googMap <- get_googlemap(
    center = as.numeric(gc),
    zoom = 12,
    maptype = 'roadmap',
    color = 'color'
);

myplots <- rxExec(mapPlot, inDataSource, googMap, timesToRun = 1)
plot(myplots[[1]][["myplot"]]);

