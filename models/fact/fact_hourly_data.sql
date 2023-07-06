{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

WITH qhd AS (
    SELECT * FROM {{ref('fact_quarter_hourly_data')}}
),
dht AS (
    SELECT * FROM {{ref('dim_hourly_time')}}
),
CTE AS (
SELECT
    DATE_KEY,
    TIME_KEY - TIME_KEY%10000 AS TIME_KEY,
    STORE_ID,
    SENSOR_ID, 
    IN_COUNT,
    OUT_COUNT
FROM qhd
)
SELECT 
    {{dbt_utils.surrogate_key(['cte.Date_Key', 'dht.Time_Key', 'cte.Sensor_ID'])}} AS hourly_data_id,
    CTE.DATE_KEY,
    dht.TIME_KEY,
    CTE.STORE_ID,
    CTE.SENSOR_ID,
    SUM(CTE.IN_COUNT) AS IN_COUNT,
    SUM(CTE.OUT_COUNT) AS OUT_COUNT
FROM CTE
INNER JOIN dht 
    ON dht.TIME_KEY = dht.TIME_KEY

{%if is_incremental() %}
   WHERE CTE.DATE_KEY + dht.TIME_KEY > (SELECT MAX(DATE_KEY) + MAX(TIME_KEY) FROM {{this}})
{% endif %}

GROUP BY STORE_ID, SENSOR_ID, DATE_KEY, dht.TIME_KEY