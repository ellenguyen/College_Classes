--Week 5
--SQL Code related to Murach Chapter 5

--Covered topics:
--1. Basic Summary Queries
--2. DISTINCT in summary queries

--Run all queries as user AP

--1. Basic Summary Queries

--Print how many invoices have not been paid off, 
--  and the total due amount for all such invoices.
SELECT COUNT(*) AS number_of_invoices,
       SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

--For invoices dated after 1/1/2014, print the message: After 1/1/2041 as selection date,
--  how many of such invoices, the average invoice total amount (rounded to 2 digits after decimal point),
--  and the total invoice amount of all such invoices.
--Use the headings: SELECT_DATE, NUMBER_OF_INVOICES, AVG_INVOICE_AMT, TOTAL_INVOICE_AMT in sequence.
--   for the query result.
SELECT 'After 1/1/2014' AS selection_date, 
    COUNT(*) AS number_of_invoices,
    ROUND(AVG(invoice_total), 2) AS avg_invoice_amt,
    SUM(invoice_total) AS total_invoice_amt
FROM invoices
WHERE invoice_date > '01-JAN-2014';

--For invoices dated after 1/1/2014, print the message: After 1/1/2041 as selection date,
--  how many of such invoices, the highest invoice total amount,
--  and the lowest invoice total amount.
--Use the headings: SELECT_DATE, NUMBER_OF_INVOICES, HIGHEST_INVOICE_TOTAL, LOWEST_INVOICE_TOTAL 
--   in sequence for the query result.
SELECT 'After 1/1/2014' AS selection_date, COUNT(*) AS number_of_invoices,
    MAX(invoice_total) AS highest_invoice_total,
    MIN(invoice_total) AS lowest_invoice_total
FROM invoices
WHERE invoice_date > '01-JAN-2014';

--Print the name of the vendor with the name being the first in the alphabetical order among all vendors,
-- the name of the vendor with the name being the last in the alphabetical order among all vendors,
-- and how many vendors whose names are known.
--Use the headings: FIRST_VENDOR, LAST_VENDOR, and NUMBER_OF_VENDORS in sequence
-- for the query result.
SELECT MIN(vendor_name) AS first_vendor,
    MAX(vendor_name) AS last_vendor,
    COUNT(vendor_name) AS number_of_vendors
FROM vendors;


--2. DISTINCT in summary queries

--For invoices dated after 1/1/2014, print how many unique vendors to which these invoices belong,
--  how many vendors to which these invoices belong, 
--  the average invoice total amount (rounded to 2 digits after decimal point),
--  and the total invoice amount of all such invoices.
--Use the headings: SELECT_DATE, NUMBER_OF_INVOICES, AVG_INVOICE_AMT, TOTAL_INVOICE_AMT in sequence.
--   for the query result.
SELECT COUNT(DISTINCT vendor_id) AS number_of_vendors,
    COUNT(vendor_id) AS number_of_invoices,
    ROUND(AVG(invoice_total),2) AS avg_invoice_amt,
    SUM(invoice_total) AS total_invoice_amt
FROM invoices
WHERE invoice_date > '01-JAN-2014';