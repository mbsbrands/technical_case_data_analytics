-- Example of a staging model for customers

{{
    "materialized": "table",
    "tags": []
}}

WITH source AS (
    SELECT * FROM {{ source('raw', 'customers') }}
)

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    city,
    state,
    country,
    brand_id,
    created_at,
    updated_at
FROM source
