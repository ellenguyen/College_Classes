--Week 5, Part 1
--SQL Code related to Murach Chapter 6

--Covered topics:
--1. Basic subquery
--2. JOIN vs Subquery
--3. Subquery in FROM clause, Top-N query
--4. Subquery in WHERE clause

--Run all queries as user AP

--1. Basic subquery

--Print the invoice number, invoice date, and invoice amount of invoices with 
--  an above average invoice amount.
SELECT invoice_number, invoice_date, invoice_total --main, outer query
FROM invoices
WHERE invoice_total > 
    (SELECT AVG(invoice_total) --inner, sub query
     FROM invoices)
ORDER BY invoice_total;


--2. JOIN vs Subquery

--Query with JOIN
--Print the invoice numbers, invoice dates, and invoice amounts of invoices
--  for vendors in California.
--Sort the result in increasing order of invoice dates.
SELECT invoice_number, invoice_date, invoice_total
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
WHERE vendor_state = 'CA'
ORDER BY invoice_date;

--Query equivalent to above, but uses Subquery instead of JOIN
SELECT invoice_number, invoice_date, invoice_total
FROM invoices 
WHERE vendor_id IN 
   (SELECT vendor_id
    FROM vendors
    WHERE vendor_state = 'CA')
ORDER BY invoice_date;

--NOT IN operator
--Print vendor ids, names, and states of vendors that don't have any invoice.
--Sort the result in increasing order of vendor ids.
SELECT vendor_id, vendor_name, vendor_state
FROM vendors
WHERE vendor_id NOT IN
    (SELECT DISTINCT vendor_id
     FROM invoices)
ORDER BY vendor_id;

--Query equivalent to above, but uses an outer join
SELECT v.vendor_id, vendor_name, vendor_state
FROM vendors v LEFT JOIN invoices i
    ON v.vendor_id = i.vendor_id
WHERE i.vendor_id IS NULL
ORDER BY v.vendor_id;

--3. Subquery in FROM clause, Top-N query

--Print the invoices number and invoice amounts of the top 3 largest invoices.
SELECT *
FROM   (SELECT invoice_number, invoice_total
        FROM   invoices
        ORDER BY invoice_total DESC)
WHERE ROWNUM <= 3;

--4. Subquery in WHERE clause

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