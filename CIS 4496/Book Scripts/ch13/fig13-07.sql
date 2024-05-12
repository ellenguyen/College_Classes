CONNECT ap/ap;

SET SERVEROUTPUT ON;

BEGIN  
  DBMS_OUTPUT.PUT_LINE('Begin FOR loop');
  FOR i IN REVERSE 1..3 LOOP
    DBMS_OUTPUT.PUT_LINE('i: ' || i);
  END LOOP;

END;
/

DECLARE
  i INTEGER;
BEGIN  
  DBMS_OUTPUT.PUT_LINE('Begin WHILE loop');
  i := 1;
  WHILE i < 4 LOOP
    DBMS_OUTPUT.PUT_LINE('i: ' || i);
    i := i + 1;
  END LOOP;

END;
/

DECLARE
  i INTEGER;
BEGIN  
  DBMS_OUTPUT.PUT_LINE('Begin simple loop');
  i := 1;
  LOOP
    DBMS_OUTPUT.PUT_LINE('i: ' || i);
    i := i + 1;
    IF i >= 4 THEN
      EXIT;
    END IF;
  END LOOP;

END;
/