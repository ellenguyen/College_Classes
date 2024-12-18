SELECT invoice_total, payment_total, credit_total,
    invoice_total - payment_total - credit_total AS balance_due
FROM invoices
--ORDER BY invoice_id