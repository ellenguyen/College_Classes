SELECT invoice_id, invoice_date, invoice_total,
    CAST(invoice_date AS VARCHAR2(9)) AS varchar_date,
    CAST(invoice_total AS NUMBER(9)) AS integer_total
FROM invoices