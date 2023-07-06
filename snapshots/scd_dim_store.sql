{% snapshot scd_dim_table %}


{{
   config(
       target_schema='dev',
       unique_key='store_id',

       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_delete = True
   )
}}




SELECT * FROM {{ ref('dim_store') }}

{% endsnapshot %}
