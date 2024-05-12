SELECT payment_date,
       NVL(TO_CHAR(payment_date), 'Unpaid') AS payment_date_2
FROM invoices