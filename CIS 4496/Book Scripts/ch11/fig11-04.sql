-- use the AP schema
CONNECT ap/ap;

-- an updateable view that contains a calculated column
CREATE OR REPLACE VIEW balance_due_view AS 
  SELECT vendor_name, invoice_number, 
         invoice_total, payment_total, credit_total, 
         invoice_total - payment_total - credit_total AS balance_due
  FROM vendors JOIN invoices ON vendors.vendor_id = invoices.vendor_id
  WHERE invoice_total - payment_total - credit_total > 0;

-- you can update a column
UPDATE balance_due_view
SET credit_total = 300
WHERE invoice_number = '989319-497';

-- but you can't update the calculated column
UPDATE balance_due_view
SET balance_due = 0
WHERE invoice_number = '989319-497';

ROLLBACK;

CREATE OR REPLACE VIEW balance_due_view AS 
  SELECT vendor_name, invoice_number, 
         invoice_total, payment_total, credit_total, 
         invoice_total - payment_total - credit_total AS balance_due
  FROM vendors JOIN invoices ON vendors.vendor_id = invoices.vendor_id
  WHERE invoice_total - payment_total - credit_total > 0
WITH READ ONLY;

-- you can't update any columns in a read-only view
UPDATE balance_due_view
SET credit_total = 300
WHERE invoice_number = '989319-497';