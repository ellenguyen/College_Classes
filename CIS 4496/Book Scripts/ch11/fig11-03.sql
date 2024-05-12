-- use the AP schema
CONNECT ap/ap;

DROP VIEW vendors_phone_list;

CREATE VIEW vendors_phone_list AS
  SELECT vendor_name, vendor_contact_last_name, 
         vendor_contact_first_name, vendor_phone
  FROM vendors
  WHERE vendor_id IN (SELECT vendor_id FROM invoices);

-- SELECT * FROM vendors_phone_list;

CREATE OR REPLACE VIEW vendors_phone_list_short AS
  SELECT vendor_name, vendor_phone
  FROM vendors_phone_list;

-- SELECT * FROM vendors_phone_list_short;

CREATE OR REPLACE VIEW vendor_invoices AS
  SELECT vendor_name, invoice_number, invoice_date, invoice_total 
  FROM vendors 
    JOIN invoices ON vendors.vendor_id = invoices.vendor_id;
  
-- SELECT * FROM vendor_invoices;

CREATE OR REPLACE VIEW top5_invoice_totals AS
  SELECT vendor_id, invoice_total
  FROM (SELECT vendor_id, invoice_total FROM invoices
        ORDER BY invoice_total DESC)
  WHERE ROWNUM <= 5;

-- SELECT * FROM top5_invoice_totals;

CREATE OR REPLACE VIEW invoices_outstanding
  (invoice_number, invoice_date, invoice_total, balance_due)
AS
  SELECT invoice_number, invoice_date, invoice_total,
         invoice_total - payment_total - credit_total
  FROM invoices
  WHERE invoice_total - payment_total - credit_total > 0;

CREATE OR REPLACE VIEW invoices_outstanding AS
  SELECT invoice_number, invoice_date, invoice_total,
         invoice_total - payment_total - credit_total AS balance_due
  FROM invoices
  WHERE invoice_total - payment_total - credit_total > 0;

-- SELECT * FROM invoices_outstanding;

CREATE OR REPLACE VIEW invoice_summary AS
  SELECT vendor_name, 
    COUNT(*) AS invoice_count, 
    SUM(invoice_total) AS invoice_total_sum
  FROM vendors 
    JOIN invoices ON vendors.vendor_id = invoices.vendor_id
  GROUP BY vendor_name;

-- SELECT * FROM invoice_summary;

CREATE OR REPLACE FORCE VIEW products_price_list AS
  SELECT product_description, product_price 
  FROM products;
  
-- SELECT * FROM products_price_list;