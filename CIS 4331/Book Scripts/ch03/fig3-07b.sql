SELECT 'Invoice: # ' || invoice_number || ', dated ' || 
    TO_CHAR(payment_date, 'MM/DD/YYYY') || 
    ' for $' || TO_CHAR(payment_total) AS "Invoice Text"
FROM invoices
--ORDER BY invoice_id