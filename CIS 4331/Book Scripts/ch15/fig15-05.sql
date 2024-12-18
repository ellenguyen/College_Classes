CREATE OR REPLACE PROCEDURE insert_invoice
(
  vendor_id_param        invoices.vendor_id%TYPE,
  invoice_number_param   invoices.invoice_number%TYPE,
  invoice_date_param     invoices.invoice_date%TYPE,
  invoice_total_param    invoices.invoice_total%TYPE,
  payment_total_param    invoices.payment_total%TYPE DEFAULT 0,
  credit_total_param     invoices.credit_total%TYPE DEFAULT 0,
  terms_id_param         invoices.terms_id%TYPE DEFAULT NULL,
  invoice_due_date_param invoices.invoice_due_date%TYPE DEFAULT NULL,
  payment_date_param     invoices.payment_date%TYPE DEFAULT NULL
)
AS
  invoice_id_var         invoices.invoice_id%TYPE;
  terms_id_var           invoices.terms_id%TYPE;
  invoice_due_date_var   invoices.invoice_date%TYPE;  
  terms_due_days_var     INTEGER;  
BEGIN
  IF invoice_total_param < 0 THEN
    RAISE VALUE_ERROR;
  END IF;
  
  SELECT invoice_id_seq.NEXTVAL INTO invoice_id_var FROM dual;

  IF terms_id_param IS NULL THEN
    SELECT default_terms_id INTO terms_id_var
    FROM vendors WHERE vendor_id = vendor_id_param;
  ELSE
    terms_id_var := terms_id_param;
  END IF;

  IF invoice_due_date_param IS NULL THEN
    SELECT terms_due_days INTO terms_due_days_var
      FROM terms WHERE terms_id = terms_id_var;
    invoice_due_date_var := invoice_date_param + terms_due_days_var;
  ELSE
    invoice_due_date_var := invoice_due_date_param;
  END IF;

  INSERT INTO invoices
  VALUES (invoice_id_var, 
          vendor_id_param, invoice_number_param, invoice_date_param, 
          invoice_total_param, payment_total_param, credit_total_param, 
          terms_id_var, invoice_due_date_var, payment_date_param);
END;
/

CALL insert_invoice(34, 'ZXA-080', '30-AUG-08', 14092.59, 
                    0, 0, 3, '30-SEP-08', NULL);
CALL insert_invoice(34, 'ZXA-080', '30-AUG-08', 14092.59, 
                    0, 0, 3, '30-SEP-08');
CALL insert_invoice(34, 'ZXA-080', '30-AUG-08', 14092.59);

-- this statement raises an error
CALL insert_invoice(34, 'ZXA-080', '30-AUG-08', -14092.59);

SELECT * FROM invoices WHERE invoice_id >= 115;

DELETE FROM invoices WHERE invoice_id >= 115;