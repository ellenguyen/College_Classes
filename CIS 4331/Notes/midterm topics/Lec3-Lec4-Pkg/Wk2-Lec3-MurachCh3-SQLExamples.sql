--Wk2, Lec 3
--SQL Examples covered in Lec 3 that are related to Murach Ch 3

--1. Basics
--2. Column Alias
--3. Concatenation
--4. Operator & expression
--5. Scalar function
--5.1 dual: dummy table
--6. DISTINCT/ALL


--1. Basics

SELECT *
FROM invoices;

SELECT invoice_number, invoice_date, invoice_total
FROM invoices
ORDER BY invoice_total;

SELECT invoice_id, invoice_total,  (credit_total + payment_total) 
FROM invoices
WHERE invoice_id = 17;

--Alias for the heading of a displayed column (credit_total + payment_total)
SELECT invoice_id, invoice_total, 
           (credit_total + payment_total) AS  total_credits
FROM invoices
WHERE invoice_id = 17;

-- AS keyword: optional
SELECT invoice_id, invoice_total, 
           (credit_total + payment_total)   total_credits
FROM invoices
WHERE invoice_id = 17;

--basic between and operator
SELECT invoice_number, invoice_date, invoice_total
FROM invoices
WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
ORDER BY invoice_date;

--equivalent to above query
SELECT invoice_id, invoice_date, invoice_total
FROM invoices
WHERE invoice_date >= '01-MAY-2014' AND invoice_date <= '31-MAY-2014';

--basic condition in WHERE clause
SELECT invoice_number, invoice_date, invoice_total 
FROM invoices
WHERE invoice_total > 50000;


--2. Column Alias

--wrong due to keyword DATE
--SELECT invoice_number AS "Invoice Number", invoice_date AS date,
--    invoice_total AS total
--FROM invoices;

--Alias names contain 2 words or different cases
SELECT invoice_number AS "Invoice Number", invoice_date AS "Date",
    invoice_total AS total
FROM invoices;

SELECT invoice_number AS "Invoice Number", invoice_date AS "Date",
    invoice_total AS "total"
FROM invoices;

--"" is for column alias, '' is for character literal (constant)
SELECT invoice_number "Invoice Number", invoice_date "Date",
    invoice_total total
FROM invoices;

SELECT invoice_number "Invoice Number", invoice_date "Date",
    invoice_total "total"
FROM invoices;

SELECT invoice_number, invoice_date, invoice_total,
    invoice_total - payment_total - credit_total
FROM invoices;

SELECT invoice_number, invoice_date, invoice_total,
    invoice_total - payment_total - credit_total "BALANCE DUE"
FROM invoices;

--3. Concatenation
--Philadelphia, PA
--Philadelphia PA
SELECT vendor_city, vendor_state, vendor_city || vendor_state
FROM vendors;

--character literal (constant)
--|| like + in Java
SELECT vendor_city, vendor_state, vendor_city || ', ' || vendor_state
FROM vendors;

--format: Philly, PA 19122
SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors;

--add column alias: Address
SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS "Address"
FROM vendors;

--Format: FedEx's address is xxxx
SELECT vendor_name || '''s address: ',
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code  address
FROM vendors;


--4. Operator & expression

SELECT invoice_total, payment_total, credit_total,
    invoice_total - payment_total - credit_total AS balance_due
FROM invoices;
--ORDER BY invoice_id

--+, -, *, /
SELECT invoice_id,
    invoice_id + 7 * 3 AS order_of_precedence,
    (invoice_id + 7) * 3 AS add_first
FROM invoices
ORDER BY invoice_id;

--5. Scalar function

--get initials  by SUBSTR
SELECT vendor_contact_first_name, vendor_contact_last_name,
     SUBSTR(vendor_contact_first_name, 1, 1) || 
      SUBSTR(vendor_contact_last_name, 1, 1) AS initials
FROM vendors;

SELECT vendor_contact_first_name, vendor_contact_last_name,
     SUBSTR(vendor_contact_first_name, 0, 1) || 
      SUBSTR(vendor_contact_last_name, 0, 1) AS initials
FROM vendors;

--TO_CHAR
SELECT 'Invoice: # ' || invoice_number || ', dated ' || 
    TO_CHAR(payment_date, 'MM/DD/YYYY') || 
    ' for $' || TO_CHAR(payment_total) 
FROM invoices;

--TO_CHAR, add column alias
SELECT 'Invoice: # ' || invoice_number || ', dated ' || 
    TO_CHAR(payment_date, 'MM/DD/YYYY') || 
    ' for $' || TO_CHAR(payment_total) AS "Invoice Text"
FROM invoices;

--SYSDATE, ROUND
SELECT invoice_date, 
    SYSDATE AS today, 
    ROUND(SYSDATE - invoice_date) AS invoice_age_in_days
FROM invoices;
    
--MOD: java %
-- invoice_id % 10
SELECT invoice_id,
      MOD(invoice_id, 10) AS remainder
FROM invoices
ORDER BY invoice_id;

--5.1 dual: dummy table

SELECT 'test'  AS test_string, 
       10-7    AS test_calculation, 
       SYSDATE AS test_date
FROM Dual;

-- similar to above, without column alias
SELECT 'test'  , 
       10-7    , 
       SYSDATE 
FROM Dual;

SELECT 'test' || 'me' AS test_string,
       10 - 7 test_math_expr,
       SYSDATE test_date,
       TO_CHAR(SYSDATE, 'MM/DD/YYYY')       
FROM  dual;

--6. DISTINCT/ALL

--ALL keyword: all values including duplicates
SELECT ALL vendor_city
FROM vendors
ORDER BY vendor_city;

--default: same as ALL
SELECT vendor_city
FROM vendors
ORDER BY vendor_city;

--only unique values
SELECT DISTINCT vendor_city
FROM vendors
ORDER BY vendor_city;

SELECT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city;

--unique pairs
SELECT DISTINCT vendor_city, vendor_state
FROM vendors
ORDER BY vendor_city;


SELECT vendor_city, vendor_state, vendor_zip_code
FROM vendors
ORDER BY vendor_city;

--unique 3-value combos
SELECT DISTINCT vendor_city, vendor_state, vendor_zip_code
FROM vendors
ORDER BY vendor_city;