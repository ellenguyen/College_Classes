SELECT invoice_id,
    MOD(invoice_id, 10) AS remainder
FROM invoices
ORDER BY invoice_id
