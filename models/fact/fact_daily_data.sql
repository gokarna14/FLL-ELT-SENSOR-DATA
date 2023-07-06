{{
  config(
    materialized = 'incremental',
    )
}}

WITH QHD AS (
    SELECT * FROM {{ref('fact_quarter_hourly_data')}}
)
SELECT
    {{dbt_utils.surrogate_key(['Date_Key', 'Sensor_ID'])}} AS Daily_Data_ID,
    DATE_KEY,
    STORE_ID,
    SENSOR_ID,
    SUM(IN_COUNT) AS IN_COUNT,
    SUM(OUT_COUNT) AS OUT_COUNT
FROM QHD

{%if is_incremental() %}
   WHERE DATE_KEY  > (SELECT MAX(DATE_KEY) FROM {{this}})
{% endif %}

GROUP BY DATE_KEY, STORE_ID, SENSOR_ID
