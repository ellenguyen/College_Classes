SELECT payment_date, invoice_due_date, 
       COALESCE(payment_date, invoice_due_date, TO_DATE('01-JAN-1900')) 
       AS payment_date_2
FROM invoices