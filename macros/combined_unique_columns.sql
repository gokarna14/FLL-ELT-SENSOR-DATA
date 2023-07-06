{% macro combined_unique_columns(model, column1, column2) -%}

    SELECT 
        {{column1}}
    FROM {{model}}
    GROUP BY {{column1}}, {{column2}}
    HAVING COUNT(*) > 1
{% endmacro %}