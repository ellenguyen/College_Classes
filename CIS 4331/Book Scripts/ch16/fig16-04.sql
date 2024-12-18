DROP TABLE invoices_audit;

CREATE TABLE invoices_audit
(
  vendor_id           NUMBER          NOT NULL,
  invoice_number      VARCHAR2(50)    NOT NULL,
  invoice_total       NUMBER          NOT NULL,
  action_type         VARCHAR2(50)    NOT NULL,
  action_date         DATE            NOT NULL
);

CREATE OR REPLACE TRIGGER invoices_after_dml
AFTER INSERT OR UPDATE OR DELETE
ON invoices
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    INSERT INTO invoices_audit VALUES
    (:new.vendor_id, :new.invoice_number, :new.invoice_total, 
    'INSERTED', SYSDATE);
  ELSIF UPDATING THEN
    INSERT INTO invoices_audit VALUES
    (:old.vendor_id, :old.invoice_number, :old.invoice_total, 
    'UPDATED', SYSDATE);
  ELSIF DELETING THEN
    INSERT INTO invoices_audit VALUES
    (:old.vendor_id, :old.invoice_number, :old.invoice_total, 
    'DELETED', SYSDATE);
  END IF;  
END;
/

-- make sure that there is at least one record to delete
INSERT INTO invoices VALUES 
(115, 34, 'ZXA-080', '30-AUG-14', 14092.59, 0, 0, 3, '30-SEP-14', NULL);

DELETE FROM invoices WHERE invoice_number = 'ZXA-080';

SELECT * FROM invoices_audit;

-- clean up
-- DELETE FROM invoices_audit;