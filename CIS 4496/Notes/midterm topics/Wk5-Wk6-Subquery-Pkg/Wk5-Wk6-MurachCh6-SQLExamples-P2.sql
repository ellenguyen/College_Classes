--Week 5, Week 6, Part 2
--Murach Ch6 Book Chapter Code covered in class

--Covered topics: (continued)


--4. Subquery in WHERE clause, ALL, ANY/SOME (cont'd)
--5. Correlated subquery, EXISTS, NOT EXISTS
--6. Inline view
--7. Subquery factoring

--RUN as user AP

--4. Subquery in WHERE clause, ALL, ANY/SOME (cont'd)

--Print the invoice numbers, dates, and balance dues of invoices with a balance due above
--   the average balance due of all invoices that have not been paid off.
--Sort the result such that the largest invoices appears first.
SELECT invoice_number, invoice_date, 
    invoice_total - payment_total - credit_total AS balance_due
FROM invoices
WHERE invoice_total - payment_total - credit_total  > 0 
    AND invoice_total - payment_total - credit_total < --2912
    (
      SELECT AVG(invoice_total - payment_total - credit_total)
      FROM invoices
      WHERE invoice_total - payment_total - credit_total > 0
    )
ORDER BY invoice_total DESC;

--ALL, SOME/ANY

--Print the vendor names, invoice numbers, and invoice amounts of invoices with an invoice 
--  amount more than all invoices of vendor 34.
SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total > ALL 
    (SELECT invoice_total
    FROM invoices
    WHERE vendor_id = 34)
ORDER BY vendor_name;

--ANY/SOME
--Print the vendor names, invoice numbers, and invoice amounts of invoices with an invoice 
--  amount more than some invoice(s) of vendor 34.
SELECT vendor_name, invoice_number, invoice_total
FROM invoices i JOIN vendors v ON i.vendor_id = v.vendor_id
WHERE invoice_total > SOME 
    (SELECT invoice_total
    FROM invoices
    WHERE vendor_id = 34)
ORDER BY vendor_name;

--5. Correlated subquery, EXISTS, NOT EXISTS

--Correlated subquery:
--subquery runs once for each row processed by the main query
--Print the vendor id, invoice number, and invoice amount of each invoice with an invoice amount
--  more than its vendor's average invoice amount.
SELECT vendor_id, invoice_number, invoice_total
FROM invoices inv_main
WHERE invoice_total >
    (SELECT AVG(invoice_total)
     FROM invoices inv_sub
     WHERE inv_sub.vendor_id = inv_main.vendor_id)
ORDER BY vendor_id, invoice_total;

--NOT EXISTS + correlated subquery
--Print the vendor ids, names, states of vendors without any invoice.
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE NOT EXISTS --empty result set from subquery makes WHERE condition to be true
    (SELECT *
    FROM invoices
    WHERE invoices.vendor_id = vendors.vendor_id)
ORDER BY vendor_id;

--EXISTS + correlated subquery
--Print the vendor ids, names, states of vendors with at least one invoice.
SELECT vendor_id, vendor_name, vendor_state
FROM vendors  
WHERE EXISTS    --non-empty result set from subquery makes WHERE condition to be true
    (SELECT *
    FROM invoices
    WHERE invoices.vendor_id = vendors.vendor_id)
ORDER BY vendor_id;


--6. Inline view

--For each vendor with an average invoice amount more than $4900, print its vendor id, 
--  latest invoice date, and average invoice amount.
--Sort the result in decreasing order of vendors' latest invoice dates. 
SELECT i.vendor_id, MAX(invoice_date) AS "Last_Invoice_Date",
    AVG(invoice_total) AS average_invoice_total
FROM invoices i JOIN
    (  --inline view
     SELECT vendor_id, AVG(invoice_total) AS average_invoice_total
     FROM invoices
     GROUP BY vendor_id    
     HAVING AVG(invoice_total) > 4900
    ) v
    ON i.vendor_id = v.vendor_id
GROUP BY i.vendor_id
ORDER BY MAX(invoice_date) DESC;



--Subquery in the above query
--For each vendor with an average invoice amount more than $4900, 
-- print its vendor id and the average invoice amount.
SELECT vendor_id, AVG(invoice_total) AS average_invoice_total
FROM invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 4900;

--7. Subquery factoring

--The query that is equivalent to the query above, but uses subquery factoring.
--WITH clause names the result set of the subquery as vendor_invoice_summary. 
--The main query inner joins table invoices and named result-set: vendor_invoice_summary to print 
-- the same information.
WITH vendor_invoice_summary AS
(
   SELECT vendor_id, AVG(invoice_total) AS average_invoice_total
   FROM invoices
   GROUP BY vendor_id
   HAVING AVG(invoice_total) > 4900
)
SELECT i.vendor_id, MAX(invoice_date) AS last_invoice_date,
    AVG(invoice_total) AS average_invoice_total
FROM invoices i JOIN vendor_invoice_summary v
       ON i.vendor_id = v.vendor_id
GROUP BY i.vendor_id
ORDER BY MAX(invoice_date) DESC;
