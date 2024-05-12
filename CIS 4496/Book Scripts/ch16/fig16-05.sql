CREATE OR REPLACE VIEW ibm_invoices AS
  SELECT invoice_number, invoice_date, invoice_total
  FROM invoices
  WHERE vendor_id = 34;

CREATE OR REPLACE TRIGGER ibm_invoices_instead_of_insert
INSTEAD OF INSERT
ON ibm_invoices
BEGIN
  INSERT INTO invoices VALUES
  (invoice_id_seq.NEXTVAL, 34, :new.invoice_number, :new.invoice_date, 
  :new.invoice_total, 0, 0, 3, :new.invoice_date + 30, NULL);

  -- OR, you can use the stored procedure from figure 15-05
  /*
  insert_invoice(34, :new.invoice_number, :new.invoice_date, :new.invoice_total);
  */
END;
/

INSERT INTO ibm_invoices VALUES ('ZXA-080', '30-AUG-08', 14092.59);

SELECT * FROM ibm_invoices;

-- clean up
-- DELETE FROM invoices WHERE invoice_number = 'ZXA-080';