SELECT vendor_name || CHR(13)
     || vendor_address1 || CHR(13)
     || vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code
     AS vendor_address
FROM vendors
WHERE vendor_id = 1