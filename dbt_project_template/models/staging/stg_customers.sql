-- Example of a staging model
-- You can use this template to create your staging models

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
