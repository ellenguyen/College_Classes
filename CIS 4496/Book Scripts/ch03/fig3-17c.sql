SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY vendor_state, vendor_city, vendor_name
