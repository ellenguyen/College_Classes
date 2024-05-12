    SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE (invoice_total - payment_total - credit_total) > 0
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    where (invoice_total - payment_total - credit_total) <= 0
ORDER BY invoice_total DESC