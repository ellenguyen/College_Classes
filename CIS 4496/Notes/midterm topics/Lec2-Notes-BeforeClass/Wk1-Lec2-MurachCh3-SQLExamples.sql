--4331
--Week 1, Lec 2  
--SQL Examples covered in Lec 2 that are related to Murach Ch 3

--SELECT  --which columns to appear in the query result
--FROM  -- which tables desired data come from
--WHERE -- conditions desired data must satisfy
--ORDER BY --how desired data to be sorted and presented


--1. Basics

-- all columns
--Print all information about all invoices
SELECT  *  
FROM  invoices;

--selected columns and sorted query result
--Print the invoice numbers, invoice dates, invoice totals of all invoices
--Sort the result in the increasing order of invoice total amounts
SELECT  invoice_number, invoice_date, invoice_total 
FROM  invoices
ORDER BY invoice_total;

--display a math expression and only a subset of rows from a table
--print the invoice id, invoice total, and the sum of customer's credit and payment
-- of invoice with id 17.
SELECT invoice_id, invoice_total,  (credit_total + payment_total) 
FROM invoices
WHERE invoice_id = 17;

--print the same data as above, but use AS keyword to rename the heading of 
--   the displayed column (credit_total + payment_total) as TOTAL_CREDITS
-- to make the report look nicer
SELECT invoice_id, invoice_total, 
           (credit_total + payment_total) AS  total_credits
FROM invoices
WHERE invoice_id = 17;

-- AS keyword: optional
--print the same data as above, but do not use AS keyword for the column alias
SELECT invoice_id, invoice_total, 
           (credit_total + payment_total)   total_credits
FROM invoices
WHERE invoice_id = 17;



























--3. ORDER BY

--selected columns, sorted in default order
--Print the invoice numbers, invoice dates, invoice totals of all invoices
-- in the increasing order of invoice totals
SELECT  invoice_number, invoice_date, invoice_total 
FROM  invoices
ORDER BY invoice_total;  --default: ascending order: ASC

--selected columns, sorted in explicit ascending order
--Print the invoice numbers, invoice dates, invoice totals of all invoices
-- in the increasing order of invoice totals
SELECT  invoice_number, invoice_date, invoice_total 
FROM  invoices
ORDER BY invoice_total ASC;  --explicit ascending order

--selected columns, sorted in explicit descending order
--Print the invoice numbers, invoice dates, invoice totals of all invoices
-- in the decreasing order of invoice totals
SELECT  invoice_number, invoice_date, invoice_total --selected columns
FROM  invoices
ORDER BY invoice_total DESC;  --explicit descending order


-- Print the names and states of all vendors
SELECT  vendor_name, vendor_state
FROM    vendors;
 
--Sort query result by multiple columns 
-- Print the names and states of all vendors,
--   sort the result in the ascending order of vendor states, 
--   then in the descending order of vendor names
SELECT  vendor_name, vendor_state
FROM    vendors
ORDER BY vendor_state ASC, vendor_city DESC;

--4. Column alias

--Default heading of a column in the query result: same as column name and in ALL UPPERCASE
--Must user column aliases for headings in other formats
-- print the invoice numbers of all invoices, display the heading as "Invoice Number"
SELECT  invoice_number "Invoice Number"
FROM  invoices;

--Column alias
-- print the invoice numbers of all invoices, display the heading as "Invoice_Number"
SELECT  invoice_number "Invoice_Number" --column alias
FROM  invoices;