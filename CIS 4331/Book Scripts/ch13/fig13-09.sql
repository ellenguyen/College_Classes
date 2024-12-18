CONNECT ap/ap;

SET SERVEROUTPUT ON;

-- a vararray
DECLARE
  TYPE names_array      IS VARRAY(3) OF VARCHAR2(25);
  names                 names_array := names_array(NULL, NULL, NULL);  
BEGIN
  names(1) := 'John';
  names(2) := 'Jane';
  names(3) := 'Joel';
--  names.EXTEND(1);
--  names(4) := 'Jack';
  
  FOR i IN 1..names.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Name ' || i || ': ' || names(i));
  END LOOP;
END;
/

-- a nested table
DECLARE
  TYPE names_table      IS TABLE OF VARCHAR2(25);
  names                 names_table := names_table(NULL, NULL, NULL);
BEGIN
  names(1) := 'John';
  names(2) := 'Jane';
  names(3) := 'Joel';
--  names.EXTEND(1);
--  names(4) := 'Jack';

  FOR i IN 1..names.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Name ' || i || ': ' || names(i));
  END LOOP;
END;
/

-- an associative array
DECLARE
  TYPE names_table      IS TABLE OF VARCHAR2(25)
                        INDEX BY BINARY_INTEGER;
  names                 names_table;
BEGIN
  names(76) := 'John';
  names(100) := 'Jane';
  names(123) := 'Joel';
  
  FOR i IN names.FIRST..names.LAST LOOP
    IF names.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE('Name ' || i || ': ' || names(i));
    END IF;
  END LOOP;
END;
/

-- a varray with BULK COLLECT and COUNT
DECLARE
  TYPE names_table      IS TABLE OF VARCHAR2(40);
  vendor_names          names_table;
BEGIN
  SELECT vendor_name
  BULK COLLECT INTO vendor_names
  FROM vendors
  WHERE rownum < 4
  ORDER BY vendor_id;

  FOR i IN 1..vendor_names.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Vendor name ' || i || ': ' || vendor_names(i));
  END LOOP;
END;
/