{{config(
    materialized = 'ephemeral'
)}}
WITH raw_traffic_data
AS(
    -- SELECT * FROM RAW.TRAFFIC_DATA
    SELECT * FROM {{source('sensor_data', 'RAW_DATA')}}

)
SELECT
    DATE_ AS TRAFFIC_DATE,
    HOUR_ AS TRAFFIC_TIME,
    STORE_NO AS STORE_NUMBER,
    STORE_NAME,
    ENTRANCE_NAME,
    IN_COUNT,
    OUT_COUNT
FROM raw_traffic_data