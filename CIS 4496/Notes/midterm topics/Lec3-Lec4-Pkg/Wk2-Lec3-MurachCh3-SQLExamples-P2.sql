--Wk2, Lec3, Part 2
--SQL Examples covered in Lec 3 that are related to Murach Ch 3

--Continued from Lec 3 Part 1
--Covered topics: 
--7. ROWNUM
--8. logical operators


---More in WHERE clause

--7. ROWNUM

--return at most 5 rows
SELECT vendor_id, invoice_total
FROM invoices
WHERE ROWNUM <= 5;

SELECT vendor_id, invoice_total
FROM invoices
ORDER BY invoice_total DESC;

SELECT *
FROM invoices
WHERE ROWNUM <= 5;

--not top-n query
SELECT vendor_id, invoice_total 
FROM invoices
WHERE ROWNUM <= 5
ORDER BY invoice_total DESC;

--vendors whose names start with 'A' to 'L'
SELECT vendor_name
FROM vendors
WHERE vendor_name < 'M'; -- 'M' < 'M1'; 'M1' is not < 'M'
--lower case letters are larger than upper case letters in the alphametical order.

--invoices dated on or before May 31, 2014
SELECT invoice_id, invoice_date 
FROM invoices
WHERE invoice_date <= '31-MAY-14'
ORDER BY invoice_date DESC;


--8. logical operators

--SQL operators: AND, OR, NOT
-- same operator precedance as Java

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_date > '01-MAY-2014'
      OR invoice_total > 500
      AND invoice_total - payment_total - credit_total > 0
ORDER BY invoice_number;

--use parentheses to change order of operations
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE (invoice_date > '01-MAY-2014' OR invoice_total > 500)
       AND invoice_total - payment_total - credit_total > 0
ORDER BY invoice_number;
