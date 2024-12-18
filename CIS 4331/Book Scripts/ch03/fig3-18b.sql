SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY vendor_contact_last_name || vendor_contact_first_name
