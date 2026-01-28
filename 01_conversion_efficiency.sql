/* BUSINESS CASE: Marketing Funnel Efficiency.
  Goal: Identify which channels (Origin) produce the fastest and highest conversions.
*/

SELECT 
    m.origin,
    COUNT(m.mql_id) AS total_leads,
    COUNT(c.mql_id) AS won_deals,
    -- Conversion Rate
    ROUND((COUNT(c.mql_id)::numeric / COUNT(m.mql_id) * 100), 2) AS conv_rate_pct,
    -- Time to Close (Sales Velocity)
    ROUND(AVG(c.won_date::date - m.first_contact_date::date), 1) AS avg_days_to_close
FROM olist_mql m
LEFT JOIN olist_closed c ON m.mql_id = c.mql_id
GROUP BY 1
HAVING COUNT(m.mql_id) > 50 -- Filter out noise from low-volume origins
ORDER BY conv_rate_pct DESC;