WITH mql AS (
    SELECT * FROM {{ ref('stg_mql') }}
),
deals AS (
    SELECT * FROM {{ ref('stg_closed_deals') }}
)

SELECT
    mql.mql_id,
    mql.origin,
    mql.contact_date,
    deals.won_at,
    -- Sales Velocity: Days until closing
    {{ get_sales_velocity('deals.won_at', 'mql.contact_date') }} AS days_to_revenue,
    
    -- Efficiency flag
    CASE WHEN {{ get_sales_velocity('deals.won_at', 'mql.contact_date') }} <= 30 THEN 1 ELSE 0 END AS is_fast_track,
    
    deals.revenue,
    CASE WHEN deals.won_at IS NOT NULL THEN 1 ELSE 0 END AS is_converted
FROM mql
LEFT JOIN deals ON mql.mql_id = deals.mql_id