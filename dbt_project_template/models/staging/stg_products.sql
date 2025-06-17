-- Example of a staging model for products
-- You can use this template to create your staging models

WITH source AS (
    SELECT * FROM {{ source('raw', 'products') }}
)

SELECT
    product_id,
    product_name,
    product_description,
    price,
    category_id,
    brand_id,
    created_at,
    updated_at,
    is_active
FROM source
