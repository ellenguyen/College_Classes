-- to execute a single statement, move the cursor into the statement and press F9
-- to execute the entire script, press F5

CONNECT ap/ap;

SET SERVEROUTPUT ON;

BEGIN
  INSERT INTO invoices
  VALUES (115, 34, 'ZXA-080', '30-AUG-06', 
          14092.59, 0, 0, 3, '30-SEP-06', NULL);

  INSERT INTO invoice_line_items 
  VALUES (115, 1, 160, 4447.23, 'HW upgrade');
  
  INSERT INTO invoice_line_items 
  VALUES (115, 2, 167, 9645.36, 'OS upgrade');

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('The transaction was committed.');
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('The transaction was rolled back.');
END;
/

SELECT invoice_id, invoice_number
FROM invoices WHERE invoice_id = 115;

SELECT invoice_id, invoice_sequence, line_item_description
FROM invoice_line_items WHERE invoice_id = 115;

-- Clean up
DELETE FROM invoice_line_items WHERE invoice_id = 115;
DELETE FROM invoices WHERE invoice_id = 115;