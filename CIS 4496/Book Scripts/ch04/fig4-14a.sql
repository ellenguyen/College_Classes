SELECT invoice_number, vendor_name
FROM vendors 
    NATURAL JOIN invoices
ORDER BY invoice_number