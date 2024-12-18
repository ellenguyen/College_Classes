--SQL Examples in Midterm Review
--Part 2


--1. Pattern

--begin with US
SELECT vendor_name
FROM vendors
WHERE vendor_name LIKE 'US%';

--second character is S
SELECT vendor_name
FROM vendors
WHERE vendor_name LIKE '_S%';


--end with Inc
SELECT vendor_name
FROM vendors
WHERE vendor_name LIKE '%Inc';

--contains Gas
SELECT vendor_name
FROM vendors
WHERE vendor_name LIKE '%Gas%';


--2. Scalar function, DATE values and format

SELECT invoice_date
from   invoices;

--convert to something like JUL/18/2014
SELECT TO_CHAR(invoice_date, 'MON/DD/YYYY')
from   invoices;

--convert to something like February/25/2014
SELECT TO_CHAR(invoice_date, 'Month/DD/YYYY')
from   invoices;

--add or substract in days
SELECT invoice_date, invoice_date - 1, invoice_date + 2
from   invoices;

--time period in days between 2 date values
SELECT invoice_date, SYSDATE, SYSDATE - invoice_date
FROM invoices;

--ROUND a number to 2 digits after decimal point for precision
SELECT ROUND(123.4, 2), ROUND(123.4567, 2)
FROM  dual;

--3. Others

--ROWNUM
--return at most 5 vendors
SELECT *
FROM vendors
WHERE ROWNUM <= 5;