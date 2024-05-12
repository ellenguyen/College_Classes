SELECT invoice_number, vendor_name
FROM vendors INNER JOIN invoices 
ON vendors.vendor_id = invoices.vendor_id
ORDER BY invoice_number
