CREATE OR REPLACE TRIGGER invoices_before_insert
BEFORE INSERT ON invoices
FOR EACH ROW
WHEN (NEW.invoice_id IS NULL)
BEGIN
  SELECT invoice_id_seq.NEXTVAL 
  INTO :new.invoice_id 
  FROM dual;
END;
/

INSERT INTO invoices 
(vendor_id, invoice_number, invoice_date, invoice_total, terms_id, invoice_due_date)
VALUES
(34, 'ZXA-080', '30-AUG-08', 14092.59, 3, '30-SEP-08');

SELECT * FROM invoices WHERE invoice_number = 'ZXA-080';

-- clean up
DELETE FROM invoices WHERE invoice_number = 'ZXA-080';