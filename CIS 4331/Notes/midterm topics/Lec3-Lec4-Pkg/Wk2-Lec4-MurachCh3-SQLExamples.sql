--Wk2, Lec4
--SQL Examples covered in Lec 4 that are related to Murach Ch 3

--Continued from Lec 3
--Covered topics: 
--9. IN operator
--10. BETWEEN AND operator
--11. LIKE operator
--12. IS NULL, IS NOT NULL
--13. ORDER BY


---More in WHERE clause


--9. IN operator

-- in the set of number values
SELECT terms_id
FROM terms
WHERE terms_id IN (1, 3, 4); 

-- not in the set of number values
SELECT terms_id
FROM terms
WHERE terms_id NOT IN (1, 3, 4); 

-- in the set of string values
SELECT vendor_name, vendor_state
FROM vendors
WHERE vendor_state IN ('CA', 'NV', 'OR')
ORDER BY vendor_state;

-- not in the set of string values
SELECT vendor_name, vendor_state
FROM vendors
WHERE vendor_state NOT IN ('CA', 'NV', 'OR')
ORDER BY vendor_state;


--10. BETWEEN AND operator

-- between 2 date values (including the boundaries)
SELECT invoice_id, invoice_date
FROM  invoices
WHERE invoice_date BETWEEN '01-MAY-2014' AND '31-MAY-2014'
ORDER BY invoice_date DESC;

-- equivalent to above
SELECT invoice_id, invoice_date
FROM  invoices
WHERE invoice_date >= '01-MAY-2014' AND 
      invoice_date <= '31-MAY-2014'
ORDER BY invoice_date DESC;

-- not between 2 number values
SELECT vendor_zip_code
FROM  vendors
WHERE vendor_zip_code NOT BETWEEN 93600 AND 93799
ORDER BY vendor_zip_code;

-- between 2 date values
SELECT DISTINCT invoice_due_date
FROM invoices
WHERE invoice_due_date NOT BETWEEN SYSDATE AND (SYSDATE + 30) -- 30: 30 days
ORDER BY invoice_due_date;

-- between 2 date values
SELECT DISTINCT invoice_due_date
FROM invoices
WHERE invoice_due_date NOT BETWEEN (SYSDATE - 5) AND (SYSDATE + 30) -- +30: 30 days after; -5: 5 days before
ORDER BY invoice_due_date;


--11. LIKE operator

--wildcard symbol for pattern specification:
--%: any string of zero or more characters
--_: any single character

--vendor city names start with San, followed by anything
SELECT DISTINCT vendor_city
FROM vendors
WHERE vendor_city LIKE 'San%'
ORDER BY vendor_city;

--vendor city names start with San or SAN, followed by anything
SELECT  vendor_name, vendor_city
FROM vendors
WHERE vendor_city LIKE 'San%' OR vendor_city LIKE 'SAN%'
ORDER BY vendor_city;

--vendor city names that always include Fran, but can start with or end with anything.
SELECT  vendor_name, vendor_city
FROM vendors
WHERE vendor_city LIKE '%Fran%'
ORDER BY vendor_city;

--vendor city names start with COMPU, followed by any character, then ER, then anything
SELECT  vendor_name, vendor_city
FROM vendors
WHERE vendor_name LIKE 'COMPU_ER%'
ORDER BY vendor_name;


--vendor city names start with Compu, followed by any character, then er, then anything
SELECT DISTINCT vendor_name
FROM vendors
WHERE vendor_name LIKE 'Compu_er%'
ORDER BY vendor_name;

--vendor city names start with Compu, followed by any two characters, then r, then anything
SELECT DISTINCT vendor_name
FROM vendors
WHERE vendor_name LIKE 'Compu__r%'
ORDER BY vendor_name;

-- exclude a pattern
SELECT DISTINCT vendor_name
FROM vendors
WHERE vendor_name NOT LIKE 'Compu__r%'
ORDER BY vendor_name;


--12. IS NULL, IS NOT NULL

--can not use = or != for comparing values to NULLs
SELECT invoice_id, payment_date
FROM  invoices
WHERE  payment_date = null;

SELECT invoice_id, payment_date
FROM  invoices
WHERE  payment_date != null;

--Use IS NULL to check if a value is a NULL
SELECT invoice_id, payment_date
FROM  invoices
WHERE payment_date IS NULL;

--Use IS NOT NULL to check if a value is not a NULL
SELECT invoice_id, payment_date
FROM  invoices
WHERE payment_date IS NOT NULL;

--Equivalent to above query
SELECT invoice_id, payment_date
FROM  invoices
WHERE NOT (payment_date IS NULL);

--NOT same as IS NOT NULL
SELECT invoice_id, payment_date
FROM  invoices
WHERE NOT (payment_date = null);

--does not print invoices whose payment dates are NULLs.
SELECT invoice_id, payment_date
FROM  invoices
WHERE payment_date > '25-FEB-14';

-- run as user ex due to table null_sample
SELECT *
FROM null_sample;

-- run as user ex due to table null_sample
-- print sample rows with value zero in invoicie total
SELECT *
FROM null_sample
WHERE invoice_total = 0;  -- NULL is different from 0

-- run as user ex due to table null_sample
-- print sample rows with non-zero number values in invoice total
SELECT *
FROM null_sample
WHERE invoice_total <> 0; -- The expression NULL <> 0 evaluates to NULL

-- run as user ex due to table null_sample
-- print sample rows with NULL values in invoice total
SELECT *
FROM null_sample
WHERE invoice_total IS NULL;

-- run as user ex due to table null_sample
-- print sample rows where the invoice total is not a NULL value
SELECT *
FROM null_sample
WHERE invoice_total IS NOT NULL;

-- print the ids and cities of vendors if the vendor cities are unknown
SELECT vendor_id, vendor_city
FROM  vendors
WHERE vendor_city IS NULL;

--13. ORDER BY

--sort by single table column in default order: ascending
SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY vendor_name;

--sort by single table column in descending order
SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY vendor_name DESC;

--nested sort: sort by multiple table columns
SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY vendor_state, vendor_city, vendor_name;

--sort by table alias without ""
SELECT vendor_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY address, vendor_name;

--sort by table alias containing ""
SELECT DISTINCT vendor_city city, vendor_state "state"
FROM vendors
ORDER BY "state";

--sort by an expression
SELECT vendor_name, vendor_contact_last_name ||' ' ||  vendor_contact_first_name,
    vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS address
FROM vendors
ORDER BY vendor_contact_last_name  ||' ' || vendor_contact_first_name;