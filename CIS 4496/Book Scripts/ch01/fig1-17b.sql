SELECT vendor_id, invoice_total, avg_invoice_total(vendor_id)
FROM invoices
ORDER BY vendor_id
