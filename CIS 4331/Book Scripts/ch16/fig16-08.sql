CREATE OR REPLACE TRIGGER invoices_compound_update
FOR UPDATE OF invoice_total, credit_total
ON invoices
COMPOUND TRIGGER 
  test_value NUMBER := 1; 
  
  BEFORE STATEMENT IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('before statement: ' || test_value);
  END BEFORE STATEMENT;

  BEFORE EACH ROW IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('before row: ' || test_value);
  END BEFORE EACH ROW;

  AFTER EACH ROW IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('after row: ' || test_value);
  END AFTER EACH ROW;
  
  AFTER STATEMENT IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('after statement: ' || test_value);
  END AFTER STATEMENT;
END;
/

SET SERVEROUTPUT ON;

UPDATE invoices
SET credit_total = 0
WHERE invoice_id = 100;