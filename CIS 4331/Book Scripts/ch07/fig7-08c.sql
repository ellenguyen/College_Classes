DELETE FROM invoice_line_items
WHERE invoice_id IN
    (SELECT invoice_id
    FROM invoices
    WHERE vendor_id = 115)