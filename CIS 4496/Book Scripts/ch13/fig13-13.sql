CONNECT ap/ap;

SET SERVEROUTPUT ON;

-- Use the VARIABLE keyword to declare a bind variable
VARIABLE invoice_id_value NUMBER;
     
-- Use a PL/SQL block to set the value of a bind variable
-- to the value that's entered for a substitution variable
BEGIN
  :invoice_id_value := &invoice_id;
END;
/

-- Use a bind variable in a SELECT statement
SELECT invoice_id, invoice_number
FROM invoices
WHERE invoice_id = :invoice_id_value;
     
-- Use a bind variable in another PL/SQL block
BEGIN
  DBMS_OUTPUT.PUT_LINE('invoice_id_value: ' || :invoice_id_value);
END;
/