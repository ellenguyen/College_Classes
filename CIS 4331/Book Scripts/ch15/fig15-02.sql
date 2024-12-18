CREATE OR REPLACE PROCEDURE update_invoices_credit_total
(
  invoice_number_param IN  VARCHAR2,
  credit_total_param   IN  NUMBER, 
  update_count         OUT INTEGER
)
AS
BEGIN
  UPDATE invoices
  SET credit_total = credit_total_param
  WHERE invoice_number = invoice_number_param;
  
  SELECT COUNT(*) 
  INTO update_count 
  FROM invoices
  WHERE invoice_number = invoice_number_param;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    SELECT 0 INTO update_count FROM dual;
    ROLLBACK;
END;
/

SET SERVEROUTPUT ON;
DECLARE
  row_count INTEGER;
BEGIN
  update_invoices_credit_total('367447', 200, row_count);
  DBMS_OUTPUT.PUT_LINE('row_count: ' || row_count);
END;
/