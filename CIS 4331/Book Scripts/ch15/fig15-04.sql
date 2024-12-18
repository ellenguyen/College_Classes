CREATE OR REPLACE PROCEDURE update_invoices_credit_total
(
  invoice_number_param VARCHAR2,
  credit_total_param   NUMBER
)
AS
BEGIN
  IF credit_total_param < 0 THEN
    RAISE VALUE_ERROR;
    -- RAISE_APPLICATION_ERROR(-20001, 'Credit total may not be negative.');
  END IF;

  UPDATE invoices
  SET credit_total = credit_total_param
  WHERE invoice_number = invoice_number_param;
  
  COMMIT;
END;
/

CALL update_invoices_credit_total('367447', -100);

SET SERVEROUTPUT ON;

BEGIN
  update_invoices_credit_total('367447', -100);
EXCEPTION
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('A VALUE_ERROR occurred.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unknown exception occurred.');
END;
/

SELECT invoice_number, credit_total 
FROM invoices WHERE invoice_number = '367447';