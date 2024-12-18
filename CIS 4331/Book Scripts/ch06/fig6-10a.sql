SELECT vendor_name,
    (SELECT MAX(invoice_date) FROM invoices
    WHERE invoices.vendor_id = vendors.vendor_id) AS latest_inv
FROM vendors
ORDER BY latest_inv
