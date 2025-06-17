# Guide for Non-dbt SQL Implementation

If you prefer not to use dbt for this technical case, you can organize your solution using plain SQL files in a structured manner. Here's a suggested approach:

## Directory Structure

Create a directory structure similar to the following:

```
sql_solution/
├── 1_staging/         # Clean and standardize raw data
├── 2_intermediate/    # Join and transform data
└── 3_marts/           # Final reporting views
```

## Naming Conventions

Use a consistent naming convention for your SQL files:

- Staging models: `stg_[source_table].sql`
- Intermediate models: `int_[entity]_[description].sql`
- Mart models: `mart_[business_area]_[entity].sql`

## Documentation

Include comments at the beginning of each SQL file explaining:
- The purpose of the model
- Input tables/dependencies
- Key transformations
- Any business logic applied
- Assumptions made

## Example SQL Model

```sql
-- File: 1_staging/stg_customers.sql
-- Purpose: Standardize customer data from raw source
-- Dependencies: raw.customers

CREATE OR REPLACE VIEW staging.stg_customers AS
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
FROM raw.customers;
```

## Testing

Include SQL queries that validate your data, such as:

```sql
-- File: tests/test_stg_customers.sql
-- Purpose: Verify customer data integrity

-- Check for duplicate customer IDs
SELECT 
    customer_id, 
    COUNT(*) as count
FROM staging.stg_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check for missing required fields
SELECT 
    COUNT(*) as missing_email_count
FROM staging.stg_customers
WHERE email IS NULL;
```

## Execution Order

Include a README or markdown file that documents the order in which your SQL files should be executed, along with any dependencies between them.

This structure will allow you to implement a solution that follows good data modeling practices, even without using dbt.
