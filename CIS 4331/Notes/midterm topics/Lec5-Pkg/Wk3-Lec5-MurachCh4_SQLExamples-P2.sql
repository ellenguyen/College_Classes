--Week 3, Lec 5, Murach Ch4, Part 2
--SQL Examples demoed in class

--Continued from Lec 5
--Topics covered:
--7. multiple JOIN conditions, WHERE condition
--8. SELF JOIN


--7. multiple JOIN conditions, WHERE condition

--two join conditions 
--print the invoice number, invoice date, invoice total and invoice line item amount
--  of each invoice that has at least 2 items.
-- sort result in increasing order of invoice number
SELECT invoice_number, invoice_date,
    invoice_total, line_item_amt
FROM invoices i JOIN invoice_line_items li
    ON (i.invoice_id = li.invoice_id) AND
       (i.invoice_total > li.line_item_amt)
ORDER BY invoice_number;

--equivalent to above, but place the primary join condition in ON expression of FROM clause,
--  place the other join condition in WHERE clause
SELECT invoice_number, invoice_date,
    invoice_total, line_item_amt
FROM invoices i JOIN invoice_line_items li  
    ON i.invoice_id = li.invoice_id            --primary join condition
WHERE i.invoice_total > li.line_item_amt       
ORDER BY invoice_number;


--8. SELF JOIN

--SELF JOIN : a table joins with itself and is treated as two different tables

--SELF JOIN
--Print the name pairs, city and state of vendors that are located in the same city and state
SELECT v1.vendor_name, v2.vendor_name, v1.vendor_city, v1.vendor_state
FROM  vendors v1 INNER JOIN vendors v2 ON (v1.vendor_city = v2.vendor_city)
      AND (v1.vendor_state = v2.vendor_state)
      AND (v1.vendor_id <> v2.vendor_id);      

--SELF JOIN
--Not equivalent to above query. It includes extra pairs of same vendors.
SELECT v1.vendor_name, v2.vendor_name, v1.vendor_city, v1.vendor_state
FROM  vendors v1 INNER JOIN vendors v2 ON (v1.vendor_city = v2.vendor_city)
      AND (v1.vendor_state = v2.vendor_state);

--A cross join of vendors table. 
--It's related to the first SELF-JOIN query, but not equivalent.
--This returns all possible pairs of vendors, including those in the same city and state, 
--  those not in the same city and state, and pairs of same vendors.
SELECT v1.vendor_name, v1.vendor_city, v1.vendor_state,
       v2.vendor_name, v2.vendor_city, v2.vendor_state
FROM  vendors v1 CROSS JOIN vendors v2;