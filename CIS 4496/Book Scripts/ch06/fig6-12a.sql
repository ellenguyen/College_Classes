SELECT v_sub.vendor_state, v_sub.vendor_name,
    SUM(i_sub.invoice_total) AS sum_of_invoices
FROM invoices i_sub JOIN vendors v_sub
    ON i_sub.vendor_id = v_sub.vendor_id
GROUP BY v_sub.vendor_state, v_sub.vendor_name
ORDER BY v_sub.vendor_state, v_sub.vendor_name
