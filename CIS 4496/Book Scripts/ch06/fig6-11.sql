SELECT summary1.vendor_state, summary1.vendor_name, top_in_state.sum_of_invoices
FROM
    (
    SELECT v_sub.vendor_state, v_sub.vendor_name,
        SUM(i_sub.invoice_total) AS sum_of_invoices
    FROM invoices i_sub JOIN vendors v_sub
        ON i_sub.vendor_id = v_sub.vendor_id
    GROUP BY v_sub.vendor_state, v_sub.vendor_name
    ) summary1
    JOIN
        (
        SELECT summary2.vendor_state,
            MAX(summary2.sum_of_invoices) AS sum_of_invoices
        FROM
            (
            SELECT v_sub.vendor_state, v_sub.vendor_name,
                SUM(i_sub.invoice_total) AS sum_of_invoices
            FROM invoices i_sub JOIN vendors v_sub
                ON i_sub.vendor_id = v_sub.vendor_id
            GROUP BY v_sub.vendor_state, v_sub.vendor_name
            ) summary2
        GROUP BY summary2.vendor_state
        ) top_in_state
    ON summary1.vendor_state = top_in_state.vendor_state AND
       summary1.sum_of_invoices = top_in_state.sum_of_invoices
ORDER BY summary1.vendor_state
