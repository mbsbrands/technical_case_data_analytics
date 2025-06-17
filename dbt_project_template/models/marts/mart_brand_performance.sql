-- Example of a mart model for brand performance
-- This is an improved version of the existing brand_performance view

WITH brands AS (
    SELECT * FROM {{ ref('stg_brands') }}
),

-- Add references to your intermediate models here
-- For example:
-- brand_orders AS (
--     SELECT * FROM {{ ref('int_brand_orders') }}
-- ),

-- This is just a placeholder - you should create your own logic based on your intermediate models
brand_performance AS (
    SELECT
        b.brand_id,
        b.brand_name,
        b.website,
        -- Include metrics from your intermediate models here
        -- These would typically come from aggregated intermediate models
        -- rather than directly joining raw tables
        0 as product_count,  -- Replace with actual calculation
        0 as order_count,    -- Replace with actual calculation
        0 as total_sales     -- Replace with actual calculation
    FROM brands b
)

SELECT * FROM brand_performance
