SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE (invoice_date > '01-MAY-2014' OR invoice_total > 500)
AND invoice_total - payment_total - credit_total > 0
ORDER BY invoice_number
