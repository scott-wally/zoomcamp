## Week 1 Homework 1 Part A

## Q1
docker build --help

A: --iidfile string


## Q2
docker run -it --entrypoint /bin/bash python:3.9
pip list

A: 3


## Q3
SELECT COUNT(1)
FROM green_taxi_trips
WHERE CAST(lpep_dropoff_datetime AS DATE) = '2019-01-15' AND CAST(lpep_pickup_datetime AS DATE) = '2019-01-15'
LIMIT 10;

A: 20530


## Q4
SELECT CAST(lpep_pickup_datetime AS DATE) AS "day", MAX(trip_distance) AS "Largest Trip Dist"
FROM green_taxi_trips
GROUP BY CAST(lpep_pickup_datetime AS DATE)
ORDER BY MAX(trip_distance) DESC
;

A: 2019-01-15


## Q5
SELECT passenger_count, COUNT(passenger_count)
FROM green_taxi_trips
WHERE CAST(lpep_pickup_datetime AS DATE) = '2019-01-01'
GROUP BY passenger_count
;

A: 2: 1282, 3: 254


## Q6
SELECT 
	lpep_pickup_datetime,
	lpep_dropoff_datetime,
	tip_amount,
	zpu."Zone" AS "pick_up_loc",
	zdo."Zone" AS "drop_off_loc"
FROM 
	green_taxi_trips g,
	zones zpu,
	zones zdo
WHERE
	g."PULocationID" = zpu."LocationID" AND
	g."DOLocationID" = zdo."LocationID" AND
	zpu."Zone" = 'Astoria'
ORDER BY tip_amount DESC
;

A: Long Island City/Queens Plaza
