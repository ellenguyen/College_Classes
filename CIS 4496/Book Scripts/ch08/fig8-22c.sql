SELECT RANK() OVER (ORDER BY invoice_total) AS rank, 
       DENSE_RANK() OVER (ORDER BY invoice_total) AS dense_rank,
       invoice_total, invoice_number
FROM invoices
