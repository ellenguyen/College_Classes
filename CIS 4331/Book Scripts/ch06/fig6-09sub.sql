SELECT vendor_id, AVG(invoice_total) AS average_invoice_total
FROM invoices
HAVING AVG(invoice_total) > 4900
GROUP BY vendor_id
