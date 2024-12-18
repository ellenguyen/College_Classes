CONNECT ap/ap;

--INSERT INTO general_ledger_accounts VALUES (130, 'Cash');

SET SERVEROUTPUT ON;

BEGIN  
  INSERT INTO general_ledger_accounts VALUES (130, 'Cash');

  DBMS_OUTPUT.PUT_LINE('1 row inserted.');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('You attempted to insert a duplicate value.');

  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected exception occurred.');
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
