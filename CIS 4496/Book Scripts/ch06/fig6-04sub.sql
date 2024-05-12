SELECT AVG(invoice_total - payment_total - credit_total)
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0
