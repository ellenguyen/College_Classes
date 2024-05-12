SELECT vendor_state, vendor_city, COUNT(*) AS qty_vendors
FROM vendors
WHERE vendor_state IN ('IA', 'NJ')
GROUP BY ROLLUP (vendor_state, vendor_city)
ORDER BY vendor_state, vendor_city
