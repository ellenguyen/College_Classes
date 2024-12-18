SELECT payment_date,
       NVL2(payment_date, 'Paid', 'Unpaid') AS payment_date_2
FROM invoices