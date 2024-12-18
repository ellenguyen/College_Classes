--Weeks 12, 13
--Murach Ch11 Book Chapter Code covered in class

--NOTE: Run all statements as user AP

--1. Create view basics
--2. Create views using subquery
--3. Create or replace a view
--4. Create views with calculated column in related query
--5. Create a view using summary queries
--6. FORCE keyword
--7. Create updatable view
--8. Create a read only view
--9. Create a view using WITH CHECK OPTION
--10. View update and base table constraints
--11. Drop a view

--1. Create view basics

--create a view named vendors_min, including only name, state, phone of vendors.  
CREATE VIEW vendors_min AS 
  SELECT vendor_name, vendor_state, vendor_phone
  FROM vendors;

--run a query from view vendors_min
--get name, state, phone numbers of vendors in california,
--  sort the result in increasing order of vendor names.
SELECT * FROM vendors_min
WHERE vendor_state = 'CA'
ORDER BY vendor_name;

--update the phone number of vendor named Register of Copyrights
UPDATE vendors_min
SET vendor_phone = '(800) 555-3941'
WHERE vendor_name = 'Register of Copyrights';

--rollback the above change
ROLLBACK;

--2. Create views using subquery

--Create a view named vendors_phone_list, including only the names, contact names,
--   phone numbers of vendors that have at least 1 invoice
CREATE VIEW vendors_phone_list AS
  SELECT vendor_name, vendor_contact_last_name, 
         vendor_contact_first_name, vendor_phone
  FROM vendors
  WHERE vendor_id IN 
       (SELECT vendor_id FROM invoices);

--3. Create or replace a view

--create a new view or replace an existing view named vendors_phone_list_short
CREATE OR REPLACE VIEW vendors_phone_list_short AS
  SELECT vendor_name, vendor_phone
  FROM vendors_phone_list;

--create a new view or replace an existing view named vendor_invoices
-- including only names of vendors, invoice numbers, dates, invoice totals of its invoices
CREATE OR REPLACE VIEW vendor_invoices AS
  SELECT vendor_name, invoice_number, invoice_date, invoice_total 
  FROM vendors JOIN invoices 
         ON vendors.vendor_id = invoices.vendor_id;

--create a new view or replace an existing view named top5_invoice_totals
--  including only the vendor ids, invoice totals of the top 5 largest invoices
CREATE OR REPLACE VIEW top5_invoice_totals AS
  SELECT vendor_id, invoice_total
  FROM (SELECT vendor_id, invoice_total 
        FROM invoices
        ORDER BY invoice_total DESC)
  WHERE ROWNUM <= 5;  

--4. Create views with calculated column in related query

--Use a column list to name calculated columns in SELECT list
CREATE OR REPLACE VIEW invoices_outstanding
  (invoice_num, invoice_date, invoice_total, balance_due)
AS
  SELECT invoice_number, invoice_date, invoice_total,
         invoice_total - payment_total - credit_total
  FROM invoices
  WHERE invoice_total - payment_total - credit_total > 0;

--Use column alias to name calculated column in SELECT list
CREATE OR REPLACE VIEW invoices_outstanding AS
  SELECT invoice_number, invoice_date, invoice_total,
         invoice_total - payment_total - credit_total AS balance_due
  FROM invoices
  WHERE invoice_total - payment_total - credit_total > 0;

--5. Create a view using summary queries

--create a new view or replace an existing view named invoice_summary
--including only each vendor's name, invoice count, and sum of invoice totals of all its invoices
CREATE OR REPLACE VIEW invoice_summary AS
  SELECT vendor_name, 
    COUNT(*) AS invoice_count, 
    SUM(invoice_total) AS invoice_total_sum
  FROM vendors 
    JOIN invoices ON vendors.vendor_id = invoices.vendor_id
  GROUP BY vendor_name;


--6. FORCE keyword

--create view products_price_list without the existence of base table products
CREATE FORCE VIEW products_price_list AS
  SELECT product_description, product_price 
  FROM products;

--7. Create updatable view

-- an updatable view that contains a calculated column
CREATE OR REPLACE VIEW balance_due_view AS 
  SELECT vendor_name, invoice_number, 
         invoice_total, payment_total, credit_total, 
         invoice_total - payment_total - credit_total AS balance_due
  FROM vendors JOIN invoices 
         ON vendors.vendor_id = invoices.vendor_id
  WHERE invoice_total - payment_total - credit_total > 0;

-- update the column credit_total of invoice: 989319-497 
UPDATE balance_due_view
SET credit_total = 300
WHERE invoice_number = '989319-497';

--cancel the above change
ROLLBACK;

-- try to update the calculated column and will fail
UPDATE balance_due_view
SET balance_due = 0
WHERE invoice_number = '989319-497';

--8. Create a read only view

--create a read only view named balance_due_view
CREATE OR REPLACE VIEW balance_due_view AS 
  SELECT vendor_name, invoice_number, 
         invoice_total, payment_total, credit_total, 
         invoice_total - payment_total - credit_total AS balance_due
  FROM vendors JOIN invoices 
      ON vendors.vendor_id = invoices.vendor_id
  WHERE invoice_total - payment_total - credit_total > 0
WITH READ ONLY;

-- try to make an update in the read-only view balance_due_view and fail
UPDATE balance_due_view
SET credit_total = 300
WHERE invoice_number = '989319-497';

--9. Create a view using WITH CHECK OPTION

--create a view vendor_payment using WITH CHECK OPTION
CREATE OR REPLACE VIEW vendor_payment AS
  SELECT vendor_name, invoice_number, invoice_date, payment_date,
         invoice_total, credit_total, payment_total
  FROM vendors JOIN invoices ON vendors.vendor_id = invoices.vendor_id
  WHERE invoice_total - payment_total - credit_total >= 0
WITH CHECK OPTION;

--successful update on the view vendor_payment
UPDATE vendor_payment
SET payment_total = payment_total + 400.00, 
    payment_date = '01-AUG-14'
WHERE invoice_number = 'P-0608';

ROLLBACK;

-- try to update the payment total of invoice: P-0608 and fail due to WITH CHECK OPTION
-- The update would not keep the invoice: P-0608 within the result set of the query
--   used in creating the view vendor_payment.
UPDATE vendor_payment
SET payment_total = 30000.00, 
    payment_date = '01-AUG-14'
WHERE invoice_number = 'P-0608';

-- make sure data is set back to original data
UPDATE vendor_payment
SET payment_total = 0, 
    payment_date = NULL
WHERE invoice_number = 'P-0608';

--10. View update and base table constraints

CREATE OR REPLACE VIEW ibm_invoices AS
  SELECT invoice_number, invoice_date, invoice_total
  FROM invoices
  WHERE vendor_id = 34;

-- this causes an error: would use NULL for the primary key: invoice_id in base table invoices
INSERT INTO ibm_invoices
  (invoice_number, invoice_date, invoice_total)
VALUES 
  ('RA23988', '31-JUL-14', 417.34);

-- this causes an error: invoice: Q545443 is referenced by child rows: 
--    items of this invoice in child table invoice_line_items.
DELETE FROM ibm_invoices
WHERE invoice_number = 'Q545443';

-- if you delete related line items first below:
DELETE FROM invoice_line_items
WHERE invoice_id = (SELECT invoice_id FROM invoices 
                    WHERE invoice_number = 'Q545443');

-- then you can delete this invoice: Q545443 
DELETE FROM ibm_invoices
WHERE invoice_number = 'Q545443';

-- NOTE: you can run the create_ap_tables.sql script 
-- to restore the database to it's original condition

--create an updatable view named vendors_sw, including only vendors in 4 states in south west region
CREATE VIEW vendors_sw AS
SELECT *
FROM vendors
WHERE vendor_state IN ('CA','AZ','NV','NM');

--Recreate the view vendors_sw, making it read only
CREATE OR REPLACE VIEW vendors_sw AS
SELECT *
FROM vendors
WHERE vendor_state IN ('CA','AZ','NV','NM','UT','CO')
WITH READ ONLY;

--11. Drop a view

--drop view named vendors_sw
DROP VIEW vendors_sw;