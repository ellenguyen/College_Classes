SELECT vendor_id, invoice_total
FROM invoices
WHERE ROWNUM <= 5
