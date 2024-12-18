-- use the AP schema
CONNECT ap/ap;

CREATE OR REPLACE VIEW ibm_invoices AS
  SELECT invoice_number, invoice_date, invoice_total
  FROM invoices
  WHERE vendor_id = 34;
                     
SELECT * FROM ibm_invoices;

-- this causes an error
INSERT INTO ibm_invoices
  (invoice_number, invoice_date, invoice_total)
VALUES 
  ('RA23988', '31-JUL-14', 417.34);

-- this causes an error
DELETE FROM ibm_invoices
WHERE invoice_number = 'Q545443';

-- if you delete related line items first
DELETE FROM invoice_line_items
WHERE invoice_id = (SELECT invoice_id FROM invoices 
                    WHERE invoice_number = 'Q545443');

-- then you can delete invoices
DELETE FROM ibm_invoices
WHERE invoice_number = 'Q545443';

SELECT * FROM ibm_invoices;

-- NOTE: you can run the create_ap_tables.sql script 
-- to restore the database to it's original condition