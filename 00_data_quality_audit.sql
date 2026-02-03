/* DATA QUALITY AUDIT
GOAL: Validate data integrity before analysis.
CHECKS: 
1. Null values in critical keys (mql_id).
2. Consistency of dates (Won date cannot be before First Contact).
3. Duplicate checks.
*/

-- 1. CHECK FOR ORPHANED DEALS (Closed deals without an original MQL record)
SELECT 
    COUNT(c.mql_id) as orphaned_deals_count
FROM olist_closed c
LEFT JOIN olist_mql m ON c.mql_id = m.mql_id
WHERE m.mql_id IS NULL;

-- 2. CHECK FOR DATE INCONSISTENCIES (Time Travel Check)
-- Logic: A deal cannot be won BEFORE the first contact.
SELECT 
    c.mql_id,
    m.first_contact_date,
    c.won_date
FROM olist_closed c
JOIN olist_mql m ON c.mql_id = m.mql_id
WHERE c.won_date < m.first_contact_date;

-- 3. NULL ORIGIN ANALYSIS
-- Logic: How much data are we missing in the 'origin' column?
SELECT 
    origin,
    COUNT(*) as count_leads,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_mql), 2) as pct_of_total
FROM olist_mql
GROUP BY 1
ORDER BY count_leads DESC;

/* CONCLUSION:
- If 'orphaned_deals' > 0, we must use INNER JOINs in later analysis to avoid errors.
- If 'Time Travel' records exist, they should be excluded from Sales Velocity calculations.
*/