SELECT invoice_number, invoice_date, invoice_total,
    payment_total, credit_total,
    invoice_total - payment_total - credit_total AS balance_due
FROM invoices 
WHERE invoice_total - payment_total - credit_total > 0
ORDER BY invoice_date
