SELECT invoice_date, 
    SYSDATE AS today, 
    ROUND(SYSDATE - invoice_date)  AS invoice_age_in_days
FROM invoices
