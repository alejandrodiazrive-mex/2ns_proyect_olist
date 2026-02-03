/* BUSINESS CASE: Lead Quality & Operational Efficiency
GOAL: Identify which channels bring 'High-Value Leads' (HVL) and optimize Sales Velocity.
*/

WITH lead_quality_scoring AS (
    SELECT 
        m.origin,
        m.mql_id,
        c.lead_type,
        -- Fix: Use correct table aliases and casting
        (c.won_date::date - m.first_contact_date::date) AS days_to_close,
        -- Define High-Value Lead (HVL)
        CASE 
            WHEN c.lead_type IN ('online_big', 'online_medium', 'industry') THEN 1 
            ELSE 0 
        END AS is_high_value
    FROM olist_mql m  
    INNER JOIN olist_closed c ON m.mql_id = c.mql_id
)
SELECT 
    origin,
    COUNT(mql_id) AS closed_deals,
    -- METRIC 1: Quality Mix (% of leads that are 'High Value')
    ROUND(AVG(is_high_value) * 100, 2) AS hvl_percentage,
    -- METRIC 2: Sales Velocity (Efficiency)
    ROUND(AVG(days_to_close), 1) AS avg_days_to_close,
    -- METRIC 3: The Efficiency Index (Quality / Time)
    ROUND((AVG(is_high_value) * 100) / NULLIF(AVG(days_to_close), 0), 2) AS efficiency_index
FROM lead_quality_scoring
GROUP BY 1
HAVING COUNT(mql_id) > 10 
ORDER BY efficiency_index DESC;