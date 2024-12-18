--Week5, Part 2
--SQL Code related to Murach Chapter 5

--Covered topics: (cont'd)
--3. GROUP BY
--4. HAVING
--5. WHERE clause and HAVING clause in summary query


--3. GROUP BY

--Print the vendor state, vendor city, 
--  the invoice quantity and average invoice amount (rounded to 2 digits after decial point)
--  per vendor state and city value pair for vendors with at least one invoice.
--Sort the result in increasing order of vendor state and vendor city.
--Do not print the information of vendors that don't have any invoice.
--Can NOT add invoices.vendor_id in SELECT clause.
--Can add a constant like '2/15/2019' in SELECT clause.
SELECT vendor_state, vendor_city, COUNT(*) AS invoice_qty, 
    ROUND(AVG(invoice_total),2) AS invoice_avg 
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state, vendor_city
ORDER BY vendor_state, vendor_city;

--Query similar to the query above.
--But the grouping is based on the contacatenation of vendor state and vendor city.
--Print the contacatenation of vendor state and vendor city, instead of the two values separately. 
SELECT vendor_state || vendor_city, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state || vendor_city
ORDER BY vendor_state || vendor_city;

--4. HAVING

--For each vendor with at least one invoice and an average invoice amount more than $2000,
--  print its id and the average invoice amount (rounded to 2 digits after decimal point).
--Sort the result so that the vendor with the largest average invoice amount appear first.
SELECT vendor_id, ROUND(AVG(invoice_total), 2) AS average_invoice_amount
FROM invoices
GROUP BY vendor_id
HAVING AVG(invoice_total) > 2000
ORDER BY average_invoice_amount DESC;

--Print the vendor state, vendor city, the invoice quantity if it's at least 2,
--  and average invoice amount (rounded to 2 digits after decial point)
--  per vendor state and city value pair for vendors with at least one invoice.
--Sort the result in increasing order of vendor state and vendor city.
--Do not print the information of vendors that don't have any invoice.
SELECT vendor_state, vendor_city, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM invoices JOIN vendors
    ON invoices.vendor_id = vendors.vendor_id
GROUP BY vendor_state, vendor_city
HAVING COUNT(*) >= 2
ORDER BY vendor_state, vendor_city;

--For each vendor with at least one invoice and average invoice amount of more than $500,
--  print its name, the invoice quantity, and average invoice amount (rounded to 2 digits after decial point).
--Sort the result so that the vendor with most invoices appear first.
--Use headings INVOICE_QTY, INVOICE_AVG for the invoice quantity and average invoice amount.
SELECT vendor_name, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
GROUP BY vendor_name
HAVING AVG(invoice_total) > 500
ORDER BY invoice_qty DESC;


--5. WHERE clause and HAVING clause in summary query

--For each vendor with at least one invoice, print its name,
--  the quantity of this vendor's invoices with an invoice amount of more than $500,
--  and the average invoice amount (rounded to 2 digits after decial point) of these invoices.
--Sort the result so that the vendor with most invoices appear first.
--Use headings INVOICE_QTY, INVOICE_AVG for the invoice quantity and average invoice amount.
SELECT vendor_name, COUNT(*) AS invoice_qty,
    ROUND(AVG(invoice_total),2) AS invoice_avg
FROM vendors JOIN invoices
    ON vendors.vendor_id = invoices.vendor_id
WHERE invoice_total > 500
GROUP BY vendor_name
ORDER BY invoice_qty DESC;

--Compound condition in HAVING
--For each day in May 2014 with at least 2 invoices on that day and 
--  total daily invoice amount of more than $100,
--  print its date, daily invoice quantity, and total daily invoice amount. 
--Sort the result so that the last day in May 2014 appears first.
--Use headings INVOICE_QTY, INVOICE_SUM for the invoice quantity and total daily invoice amount.
SELECT 
   invoice_date,
   COUNT(*) AS invoice_qty,
   SUM(invoice_total) AS invoice_sum
FROM invoices
GROUP BY invoice_date
HAVING invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
   AND COUNT(*) > 1
   AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;

--Query that is equivalent to the query above.
--But move the invoice-date-limiting condition from HAVING clause to WHERE clause.
SELECT 
   invoice_date,  
   COUNT(*) AS invoice_qty,  
   SUM(invoice_total) AS invoice_sum
FROM invoices
WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
GROUP BY invoice_date
HAVING COUNT(*) > 1
   AND SUM(invoice_total) > 100
ORDER BY invoice_date DESC;