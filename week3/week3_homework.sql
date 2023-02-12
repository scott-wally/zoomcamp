-- Homework 3


-- ===========================================================================
-- Load FHV 2019 Data:

-- External Table:
CREATE OR REPLACE EXTERNAL TABLE `dezoomcamp.external_fhv2019`
OPTIONS (
  format = 'CSV',
  uris = ['gs://prefect-de-zoomcamp-42/data/fhv2019/fhv_tripdata_2019-*.csv.gz']
);

-- Materialized Table:
CREATE OR REPLACE TABLE dezoomcamp.fhv2019_non_partitioned AS
SELECT * FROM dezoomcamp.external_fhv2019;

--Records read: 20101474
--Records written: 20101474 


-- ===========================================================================
-- Question 1:

-- From BQ GUI: Number of rows 43,244,696

SELECT COUNT(1) FROM `dezoomcamp-375622.dezoomcamp.fhv2019_non_partitioned`;
-- Output: 43244696


-- ===========================================================================
-- Question 2:

-- External Table:
SELECT COUNT(DISTINCT(affiliated_base_number)) FROM `dezoomcamp-375622.dezoomcamp.external_fhv2019`;
-- This query will process 0 B when run.

-- Materialized Table:
SELECT COUNT(DISTINCT(affiliated_base_number)) FROM `dezoomcamp-375622.dezoomcamp.fhv2019_non_partitioned`;
-- This query will process 317.94 MB when run.
-- Output: 3165

-- ===========================================================================
-- Question 3:

SELECT COUNT(*) FROM `dezoomcamp-375622.dezoomcamp.fhv2019_non_partitioned` 
WHERE DOlocationID IS null AND PUlocationID IS null;

-- Output: 717748


-- ===========================================================================
-- Question 4:

-- Partition by pickup_datetime Cluster on affiliated_base_number

CREATE OR REPLACE TABLE dezoomcamp.fhv2019_partitioned
PARTITION BY DATE(pickup_datetime)
CLUSTER BY Affiliated_base_number AS
SELECT * FROM dezoomcamp.external_fhv2019;


-- ===========================================================================
-- Question 5:

-- Non-partitioned Table:
SELECT distinct(Affiliated_base_number) FROM `dezoomcamp-375622.dezoomcamp.fhv2019_non_partitioned`
WHERE pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31';
-- This query will process 647.87 MB when run.

-- Partitioned Table:
SELECT distinct(Affiliated_base_number) FROM `dezoomcamp-375622.dezoomcamp.fhv2019_partitioned`
WHERE pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31';
-- This query will process 23.05 MB when run.


-- ===========================================================================
-- Question 6:

-- GCP Bucket


-- ===========================================================================
-- Question 7:

-- False