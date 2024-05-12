SELECT vendor_name, 
       vendor_contact_first_name || ' ' || 
           SUBSTR(vendor_contact_last_name, 1, 1) || '.' 
           AS contact_name, 
       SUBSTR(vendor_phone, 7) AS phone
FROM vendors
WHERE SUBSTR(vendor_phone, 2, 3) = '559'
ORDER BY vendor_name