{{config(
    materialized = 'table'
)}}
WITH DIM_STORE AS (
    SELECT * FROM {{ref('dim_store')}}
),
src_sensor_data as (
    SELECT * FROM {{ref('src_sensor_data')}}
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY store.STORE_ID
    ) SENSOR_ID,
    store.STORE_ID,
    src.ENTRANCE_NAME,
    TO_DATE('2020-01-01', 'YYYY-MM-DD') AS updated_at
FROM src_sensor_data src
INNER JOIN DIM_STORE store 
ON src.STORE_NUMBER = store.STORE_NUMBER
GROUP BY store.STORE_ID, src.ENTRANCE_NAME