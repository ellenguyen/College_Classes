CONNECT ap/ap;

SET SERVEROUTPUT ON;

DECLARE
  terms_id_var NUMBER;
BEGIN  
  SELECT terms_id INTO terms_id_var 
  FROM invoices WHERE invoice_id = 4;

  CASE terms_id_var
    WHEN 1 THEN 
      DBMS_OUTPUT.PUT_LINE('Net due 10 days');      
    WHEN 2 THEN 
      DBMS_OUTPUT.PUT_LINE('Net due 20 days');      
    WHEN 3 THEN 
      DBMS_OUTPUT.PUT_LINE('Net due 30 days');      
    ELSE
      DBMS_OUTPUT.PUT_LINE('Net due more than 30 days');      
  END CASE;

  -- rewritten as a Searched CASE statement
  /*
  CASE 
    WHEN terms_id_var = 1 THEN 
      DBMS_OUTPUT.PUT_LINE('Net due 10 days');      
    WHEN terms_id_var = 2 THEN 
      DBMS_OUTPUT.PUT_LINE('Net due 20 days');      
    WHEN terms_id_var = 3 THEN 
      DBMS_OUTPUT.PUT_LINE('Net due 30 days');      
    ELSE
      DBMS_OUTPUT.PUT_LINE('Net due more than 30 days');      
  END CASE;
  */

END;
/