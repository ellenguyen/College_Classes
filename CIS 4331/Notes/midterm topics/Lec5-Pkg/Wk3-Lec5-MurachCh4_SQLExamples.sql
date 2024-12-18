---Wk3, Lec 5, Murach Ch4 SQL Examples

--Topics covered:
--1. Basics of CROSS JOIN, INNER JOIN, equijoin
--2. Table alias and column qualification, join condition, search condition, equijoin
--3. schema.table_name
--4. Ad-hoc query
--5. multiple JOIN conditions
--6. INNER JOIN 3 tables


--1. Basics of CROSS JOIN, INNER JOIN, equijoin

--CROSS JOIN
--cartesian product of table vendors and table invoices
--Print all information about any combination of any vendor with any invoice.
-- In SELECT clause: print all columns in table vendors, followed by all columns in table invoices
SELECT vendors.*, invoices.*
FROM vendors CROSS JOIN invoices;

--CROSS JOIN
--cartesian product of table vendors and table invoices
--Print all information about any combination of any vendor with any invoice
-- In SELECT clause: print all columns in each combined row.
SELECT *
FROM vendors CROSS JOIN invoices;

--INNER JOIN based on primary key (PK) and foreign key (FK) relationship
--print all info. about each vendor and each of its invoices
SELECT vendors.*, invoices.*
FROM vendors INNER JOIN invoices 
   ON vendors.vendor_id = invoices.vendor_id   -- JOIN condition: parent-table.PK value = child-table.FK value
ORDER BY invoice_number;

--similar to above query, but print only selected number of columns in each combined row
--INNER JOIN based on primary key (PK) and foreign key (FK) relationship
--print invoice number and vendor name for each vendor and each of its invoices
SELECT invoice_number, vendor_name
FROM vendors INNER JOIN invoices 
   ON vendors.vendor_id = invoices.vendor_id   -- JOIN condition: parent-table.PK value = child-table.FK value
ORDER BY invoice_number;

--same as above, add optional keyword INNER
SELECT invoice_number, vendor_name
FROM vendors INNER JOIN invoices 
  ON vendors.vendor_id = invoices.vendor_id
ORDER BY invoice_number;

--2. Table alias and column qualification, join condition, search condition

--Use aliases for all tables
--print the vendor name, vendor id, and invoice number of each vendor and each of its invoices.
SELECT vendor_name, v.vendor_id, invoice_number
FROM vendors v INNER JOIN invoices i  --aliases: v, i
        ON v.vendor_id = i.vendor_id;  --column qualification
         
--Similar to above, but with errors, must use table alias to qualify vendor_id
SELECT vendor_name, vendor_id, invoice_number
FROM vendors v INNER JOIN invoices i  --table aliases: v, i
        ON vendor_id = vendor_id;  

--Equivalent to first query about table alias, but does not use table alias
SELECT vendor_name, vendors.vendor_id, invoice_number
FROM vendors INNER JOIN invoices
        ON vendors.vendor_id = invoices.vendor_id;   --column qualification

--Use aliases for all tables
-- Print the invoice number, vendor name, invoice due date, and 
--    invoice balance due amount for each vendor and 
--    each of its invoices that has not been paid off.
-- Sort the result in the decreasing order of invoice due dates.
SELECT i.invoice_number, vendor_name, invoice_due_date,
    (invoice_total - payment_total - credit_total) AS balance_due
FROM vendors v INNER JOIN invoices i
        ON v.vendor_id = i.vendor_id
WHERE (invoice_total - payment_total - credit_total) > 0
ORDER BY invoice_due_date DESC;

--Use only 1 table alias for a join of two tables
--Explicit syntax of JOIN
SELECT invoice_number, line_item_amt, line_item_description
FROM invoices INNER JOIN invoice_line_items line_items  --table alias: line_items
    ON invoices.invoice_id = line_items.invoice_id --join condition
WHERE account_number = 540  --search condition
ORDER BY invoice_date;

--Equijoin: a join based on matching values in different tables using the equal operator
SELECT invoice_number, vendor_name
FROM vendors INNER JOIN invoices 
  ON vendors.vendor_id = invoices.vendor_id
ORDER BY invoice_number;
  
--3. schema.table_name

--login as ap, then run the statement below
--Allow user ex to query table vendors in user ap
GRANT SELECT ON vendors TO ex;
 
--login as om, then run the statement below
--Allow user ex to query table customers in user om
GRANT SELECT ON customers TO ex;

--connect as EX, then run the query below
--print the vendor names, customer last names, customer first names,
--  vendor states, and vendor citys of vendors  and customers that are in the same zip code.
--  sort the result first in increasing order of vendor state, then in increasing order of vendor city.
SELECT vendor_name, customer_last_name, customer_first_name,
    vendor_state AS state, vendor_city AS city
FROM ap.vendors v
    INNER JOIN om.customers c
    ON v.vendor_zip_code = c.customer_zip
ORDER BY state, city;

--4. Ad-hoc query
--Join data from multiple tables based on relationships that are not stored in the database
SELECT vendor_name, customer_last_name, customer_first_name,
    vendor_state AS state, vendor_city AS city
FROM ap.vendors v
    INNER JOIN om.customers c
    ON v.vendor_zip_code = c.customer_zip   --Ad-hoc join condition
ORDER BY state, city;

--5. multiple JOIN conditions

-- INNER JOIN with join conditions
-- For each invoice with an invoice total more than the amount of each item in this invoice,
--    print its invoice number, invoice date, invoice total,
--     and the amount of each individual item in this invoice.
--  Sort the result in increasing order of invoice numbers.
SELECT invoice_number, invoice_date,
    invoice_total, line_item_amt
FROM invoices i JOIN invoice_line_items li
    ON (i.invoice_id = li.invoice_id) AND
       (i.invoice_total > li.line_item_amt)
ORDER BY invoice_number;

--6. INNER JOIN 3 tables
-- For each invoice with an invoice total more than the amount of each item in this invoice,
--    print its vendor name, invoice number, invoice date, invoice total,
--      and the amount of each individual item in this invoice.
--  Sort the result in increasing order of invoice numbers.
SELECT v.vendor_name, i.invoice_id, invoice_number, invoice_date,
      invoice_total, line_item_amt
FROM vendors v INNER JOIN invoices i ON (i.vendor_id = v.vendor_id)
     INNER JOIN invoice_line_items li
        ON (i.invoice_id = li.invoice_id) --AND
            --(i.invoice_total > li.line_item_amt)     
ORDER BY invoice_number;

--equivalent to the above query, but not as easy to read as the above query.
SELECT i.invoice_id, invoice_number, invoice_date,
    invoice_total, line_item_amt, v.vendor_name
FROM  invoices i INNER JOIN invoice_line_items li
    ON (i.invoice_id = li.invoice_id) AND
       (i.invoice_total > li.line_item_amt)
       INNER JOIN vendors v ON (i.vendor_id = v.vendor_id)    
ORDER BY invoice_number;

