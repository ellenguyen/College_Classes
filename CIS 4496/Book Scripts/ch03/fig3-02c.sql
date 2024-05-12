SELECT invoice_id, invoice_total, (credit_total + payment_total) AS      total_credits
FROM invoices
WHERE invoice_id = 17
