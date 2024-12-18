CREATE OR REPLACE TRIGGER invoices_before_update_total
BEFORE UPDATE OF invoice_total
ON invoices
FOR EACH ROW
DECLARE
  sum_line_item_amount NUMBER;
BEGIN
  SELECT SUM(line_item_amt) 
  INTO sum_line_item_amount
  FROM invoice_line_items
  WHERE invoice_id = :new.invoice_id;
  
  IF sum_line_item_amount != :new.invoice_total THEN    
    RAISE_APPLICATION_ERROR(-20001, 
      'Line item total must match invoice total.');
  END IF;
END;
/

UPDATE invoices
SET invoice_total = 600
WHERE invoice_id = 100;

SELECT invoice_id, invoice_total, credit_total, payment_total 
FROM invoices WHERE invoice_id = 100;
