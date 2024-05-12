UPDATE invoices
SET invoice_due_date = invoice_due_date + 30
WHERE terms_id = 4
