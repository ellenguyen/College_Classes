SELECT invoice_number, invoice_total, invoice_date, invoice_due_date,  
    CASE
        WHEN (TO_DATE('20-JUL-14') - invoice_due_date) > 30
            THEN 'Over 30 days past due'
        WHEN (TO_DATE('20-JUL-14') - invoice_due_date) > 0
            THEN '1 to 30 days past due'
        ELSE 'Current'
    END AS status
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0