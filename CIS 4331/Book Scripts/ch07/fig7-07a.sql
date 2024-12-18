UPDATE invoices
SET credit_total = credit_total + 100,
    invoice_due_date = (SELECT MAX(invoice_due_date) FROM invoices)
WHERE invoice_number = '97/522'