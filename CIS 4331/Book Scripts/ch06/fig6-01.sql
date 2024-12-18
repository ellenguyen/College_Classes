SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_total > 
    (SELECT AVG(invoice_total)
     FROM invoices)
ORDER BY invoice_total
