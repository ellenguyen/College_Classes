CREATE OR REPLACE PACKAGE murach AS 

  PROCEDURE update_invoices_credit_total
  (invoice_number_param VARCHAR2, credit_total_param NUMBER);

  FUNCTION get_vendor_id
  (vendor_name_param VARCHAR2)
  RETURN NUMBER;

END murach;
/

CREATE OR REPLACE PACKAGE BODY murach AS

  PROCEDURE update_invoices_credit_total
  (
    invoice_number_param  VARCHAR2,
    credit_total_param    NUMBER 
  )
  AS
  BEGIN
    UPDATE invoices
    SET credit_total = credit_total_param
    WHERE invoice_number = invoice_number_param;
    
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END;

  FUNCTION get_vendor_id 
  (vendor_name_param VARCHAR2)
  RETURN NUMBER
  AS 
    vendor_id_var NUMBER;
  BEGIN
    SELECT vendor_id
    INTO vendor_id_var
    FROM vendors
    WHERE vendor_name = vendor_name_param;
    
    RETURN vendor_id_var;
  END;

END murach;
/

-- test murach.update_invoices_credit_total
CALL murach.update_invoices_credit_total('367447', 200);
CALL murach.update_invoices_credit_total('367447', 0);

-- test murach.get_vendor_id
SELECT invoice_number, invoice_total
FROM invoices
WHERE vendor_id = murach.get_vendor_id('IBM');

-- DROP PACKAGE BODY murach;
-- DROP PACKAGE murach;
