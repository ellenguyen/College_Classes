SELECT invoice_number, vendor_name, invoice_due_date,
    (invoice_total - payment_total - credit_total) AS balance_due
FROM vendors v JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE (invoice_total - payment_total - credit_total) > 0
ORDER BY invoice_due_date DESC
