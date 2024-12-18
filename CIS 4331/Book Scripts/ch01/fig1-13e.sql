-- NOTE: This doesn't work due to foreign key constraint
DELETE FROM invoices
WHERE invoice_total - payment_total - credit_total = 0
