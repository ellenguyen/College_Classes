SELECT
    CASE
        WHEN GROUPING(vendor_state) = 1 THEN '=========='
        ELSE vendor_state
    END AS vendor_state,
    CASE
        WHEN GROUPING(vendor_city) = 1 THEN '=========='
        ELSE vendor_city
    END AS vendor_city,
    COUNT(*) AS qty_vendors
FROM vendors
WHERE vendor_state IN ('IA', 'NJ')
GROUP BY ROLLUP(vendor_state, vendor_city)
ORDER BY vendor_state DESC, vendor_city DESC