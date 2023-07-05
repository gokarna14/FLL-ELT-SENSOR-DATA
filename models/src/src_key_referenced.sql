{{
    config(
        materialized='view',
    )
}}
WITH dim_time as (
    SELECT * FROM {{ref('dim_quarter_hourly_time')}}
),
dim_date as (
    SELECT * FROM {{ref('dim_date')}}
),
dim_store as (
    SELECT * FROM {{ref('dim_store')}}
),
dim_sensor as (
    SELECT * FROM {{ref('dim_sensor')}}
),
src_data as (
    select * from {{ref('src_sensor_data')}}
)
SELECT 
    dim_date.date_key,
    dim_time.time_key,
    dim_store.store_ID,
    dim_sensor.SENSOR_ID,
    src_data.IN_COUNT,
    src_data.OUT_COUNT
FROM src_data
INNER JOIN dim_date
    ON dim_date.full_date = src_data.TRAFFIC_DATE
INNER JOIN dim_time
    ON dim_time.start_time = src_data.TRAFFIC_TIME
INNER JOIN dim_store
    ON dim_store.STORE_NUMBER = src_data.STORE_NUMBER
INNER JOIN dim_sensor
    ON dim_store.STORE_ID = dim_sensor.store_ID  AND src_data.ENTRANCE_NAME = dim_sensor.ENTRANCE_NAME
