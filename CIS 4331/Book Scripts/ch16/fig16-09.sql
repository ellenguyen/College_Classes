-- Business rule for trigger:
-- credit total should never be greater than 
-- the max value of the invoice total column for a vendor

-- NOTE: this trigger compiles cleanly, 
-- but results in the mutating-table error when it is fired
CREATE OR REPLACE TRIGGER invoices_before_update_total_2
BEFORE UPDATE OF invoice_total, credit_total
ON invoices
FOR EACH ROW
DECLARE
  max_invoice_total NUMBER;
BEGIN
  SELECT MAX(invoice_total) 
  INTO max_invoice_total
  FROM invoices
  WHERE vendor_id = :new.vendor_id;
  
  IF :new.credit_total > max_invoice_total THEN
    RAISE_APPLICATION_ERROR(-20001, 
      'invoice_credit value may not the maximum invoice_total value.');
  END IF;
END;
/

UPDATE invoices
SET credit_total = 0
WHERE invoice_id = 100;

SELECT invoice_id, invoice_total, credit_total, payment_total 
FROM invoices WHERE invoice_id = 100;