SELECT
    *
FROM 
    {{ ref('fact_quarter_hourly_data') }}
WHERE IN_COUNT < 0 or OUT_COUNT < 0