--Week 6, Lec 12
--Murach Ch7 Book Chapter Code covered in class

--NOTE: Run all statements as user AP unless explictly indicated otherwise.

--Covered topic
--1. Create copies of tables
--2. INSERT(1 Row, N Rows), COMMIT, ROLLBACK
--3. UPDATE
--4. DELETE
--5. DELETE FROM vs DROP TABLE

--1. Create copies of tables

--Create a table named invoice_copy that contains a copy of all data in table invoices
CREATE TABLE invoices_copy AS 
  SELECT * FROM invoices;

--Remove the definition and data of table invoices_copy
DROP TABLE invoices_copy;

--Create a table named old_invoices that contains a copy of all invoices with zero balance due.
CREATE TABLE old_invoices AS 
  SELECT * 
  FROM invoices 
  WHERE invoice_total - payment_total - credit_total = 0;

--Create a table named vendor_balances, which contains each vendor's id, 
--   and the total invoice amount of all its invoices with a non-zero balance due.
CREATE TABLE vendor_balances AS 
  SELECT vendor_id, SUM(invoice_total) AS sum_of_invoices 
  FROM invoices 
  WHERE (invoice_total - payment_total - credit_total) <> 0 
  GROUP BY vendor_id;
  
--2. INSERT(1 Row, N Rows), COMMIT, ROLLBACK
 
--Insert a new invoice into table invoices_copy
--New invoice with invoice id: 200, vendor id 97, etc.
  INSERT INTO invoices_copy 
  VALUES (200, 97, '456789', '01-AUG-14', 8344.50, 0, 0, 1, '31-AUG-14', NULL);

--Cancel the data modification in the current transaction
--The change does not exist after you log off.
  ROLLBACK;

--Insert a new invoice into table invoices_copy with column names listed explicitly
--New invoice with invoice id: 200, vendor id 97, etc.
  INSERT INTO invoices_copy (invoice_id, vendor_id, 
        invoice_number, invoice_total, payment_total, 
        credit_total, terms_id, invoice_date, invoice_due_date) 
  VALUES (200, 97, '456789', 8344.50, 0, 0, 1, '01-AUG-14', '31-AUG-14');
  
--Make the data modification in the current transaction permanent.
-- The change in the current transaction is visible to other transactions after this statement is successfuly executed.
-- The change still exists after you log off.
  COMMIT;  
  
 
--Insert a new invoice into table invoices_copy
--New invoice with invoice id: 200, vendor id 97, etc.
  INSERT INTO invoices_copy 
  VALUES (200, 97, '456789', '01-AUG-14', 8344.50, 0, 0, 1, '31-AUG-14', NULL);

--Cancel the data modification in the current transaction  
  ROLLBACK;

--Insert a new invoice into table invoices_copy with column names listed explicitly
--New invoice with invoice id: 200, vendor id 97, etc.
  INSERT INTO invoices_copy (invoice_id, vendor_id, 
        invoice_number, invoice_total, payment_total, 
        credit_total, terms_id, invoice_date, invoice_due_date) 
  VALUES (200, 97, '456789', 8344.50, 0, 0, 1, '01-AUG-14', '31-AUG-14');
  
--Make the data modification in the current transaction permanent.
-- The change still exists after you log off.
  COMMIT;
  
--NOTE: Run all inserts into table color_sample as user EX

--color_sample table contains 3 columns:
-- color_id, color_number, color_name (listed in the same order as when the table was created)

--Each INSERT statement adds a new color into table color_sample
--Use default values for any column not having a value explicitly given.
  INSERT INTO color_sample (color_id, color_number) 
  VALUES (1, 606);     --color name: default value
  
  INSERT INTO color_sample (color_id, color_name) 
  VALUES (2, 'Yellow');  --color number: default value
  
  INSERT INTO color_sample 
  VALUES (3, DEFAULT, 'Orange');  --color number: default value
  
  INSERT INTO color_sample 
  VALUES (4, 808, NULL);  --color name: NULL
  
  INSERT INTO color_sample 
  VALUES (5, DEFAULT, NULL); --color
  
--Make the data modification in the current transaction permanent.
-- The change still exists after you log off.
  COMMIT;

--Insert N rows from other tables using subquery

--insert int table invoice_archive all invoices with a zero balance due.
INSERT INTO invoice_archive  -- without specifying column list
   SELECT * 
   FROM invoices 
   WHERE invoice_total - payment_total - credit_total = 0;
  
--equivalent to above, but with user specified column list  
INSERT INTO invoice_archive -- with user-specified column list
    (invoice_id, vendor_id, invoice_number, 
     invoice_total, credit_total,
     payment_total, terms_id, invoice_date, 
     invoice_due_date)
SELECT
    invoice_id, vendor_id, invoice_number, invoice_total, 
    credit_total, payment_total, terms_id, 
    invoice_date, invoice_due_date
FROM invoices
WHERE invoice_total - payment_total - credit_total = 0;
  
 
--3. UPDATE 
  
--change the payment date to 9/21/2014 and payment amount to $19351.18
--  for the invoice with invoice number 97/522.
UPDATE invoices_copy 
SET payment_date = '21-SEP-14', payment_total = 19351.18 
WHERE invoice_number = '97/522';

--change the terms ids of all invoices of Vendor 95 to 1
UPDATE invoices_copy 
SET terms_id = 1 
WHERE vendor_id = 95;  
 
--increase the credit amount of the invoice with invoice number 95/522 by $100. 
UPDATE invoices_copy 
SET credit_total = credit_total + 100 
WHERE invoice_number = '97/522';  

--Make these changes to the invoice with invoice number 95/522:
-- increase the credit amount by $100, 
-- change the due date to the latest due date among all invoices.
UPDATE invoices_copy 
SET credit_total = credit_total + 100, 
    invoice_due_date = 
      (SELECT MAX(invoice_due_date) 
       FROM invoices) 
WHERE invoice_number = '97/522'; 

--change the terms ids to 1 for all invoices of vendor Pacific Bell.
UPDATE invoices_copy 
SET terms_id = 1 
WHERE vendor_id = 
    (SELECT vendor_id 
     FROM vendors 
     WHERE vendor_name = 'Pacific Bell'); 
     
--change the terms ids to 1 for all invoices of vendors in California, Arizona, or Nevada.  
UPDATE invoices_copy 
SET terms_id = 1 
WHERE vendor_id IN 
  (SELECT vendor_id 
   FROM vendors 
   WHERE vendor_state IN ('CA', 'AZ', 'NV')); 
  
--4. DELETE  

--create a copy of the table invoice_line_items and name it invoice_line_items_copy.   
CREATE TABLE invoice_line_items_copy AS 
  SELECT * FROM invoice_line_items;  

--delete the first item in the invoice with invoice ID 100.  
DELETE FROM invoice_line_items_copy 
WHERE invoice_id = 100 AND invoice_sequence = 1;

--delete all items in the invoice with invoice ID 100.   
DELETE FROM invoice_line_items_copy 
WHERE invoice_id = 100;

--delete the items in all invoices of vendor 115.
DELETE FROM invoice_line_items_copy 
WHERE invoice_id IN 
  (SELECT invoice_id FROM invoices WHERE vendor_id = 115); 

--5. DELETE FROM vs DROP TABLE

--delete all rows from table invoice_line_items_copy.  
DELETE FROM invoice_line_items_copy;

--remove the rows and the definition of table invoice_line_items_copy. 
DROP TABLE invoice_line_items_copy;  