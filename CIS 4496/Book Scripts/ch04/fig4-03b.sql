SELECT vendor_name, customer_last_name, customer_first_name,
    vendor_state AS state, vendor_city AS city
FROM ap.vendors v
    JOIN om.customers c
    ON v.vendor_zip_code = c.customer_zip
ORDER BY state, city
