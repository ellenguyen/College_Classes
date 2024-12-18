SELECT AVG(invoice_total)
FROM invoices inv_sub
WHERE inv_sub.vendor_id = 95
