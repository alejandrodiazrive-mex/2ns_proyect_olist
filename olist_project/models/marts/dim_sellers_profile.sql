{{ config(materialized='table') }}

WITH deals AS (
    SELECT * FROM {{ ref('stg_closed_deals') }}
)

SELECT
    seller_id,
    -- We use MAX or ANY_VALUE to ensure only 1 row per seller
    MAX(business_segment) AS primary_business_segment,
    MAX(lead_type) AS primary_lead_type,
    MAX(business_type) AS business_type,
    
    -- We labeled the Seller's ICP (Ideal Customer Profile).
    CASE 
        WHEN MAX(lead_type) IN ('online_big', 'industry') THEN 'Enterprise Seller'
        WHEN MAX(lead_type) IN ('online_medium', 'offline_big') THEN 'Mid-Market Seller'
        ELSE 'Long-tail / SMB'
    END AS icp_segment,
    
    -- We added useful metrics
    SUM(revenue) AS total_declared_revenue,
    COUNT(mql_id) AS total_deals_closed

FROM deals
GROUP BY 1