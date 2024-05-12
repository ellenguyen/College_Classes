SELECT vendor_name || '''s address: ',
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code
FROM vendors
