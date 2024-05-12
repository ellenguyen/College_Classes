SELECT invoice_number, invoice_date, invoice_total,
    invoice_total - payment_total - credit_total
FROM invoices
