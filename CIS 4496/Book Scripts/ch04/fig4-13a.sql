SELECT invoice_number, vendor_name
FROM vendors 
    JOIN invoices USING (vendor_id)
ORDER BY invoice_number