CONNECT ap/ap;

SET SERVEROUTPUT ON;

DECLARE
  CURSOR invoices_cursor IS
    SELECT invoice_id, invoice_total  FROM invoices
    WHERE invoice_total - payment_total - credit_total > 0;

  invoice_row invoices%ROWTYPE;
BEGIN  
  FOR invoice_row IN invoices_cursor LOOP   
  
    IF (invoice_row.invoice_total > 1000) THEN
      UPDATE invoices
      SET credit_total = credit_total + (invoice_total * .1)
      WHERE invoice_id = invoice_row.invoice_id;

      DBMS_OUTPUT.PUT_LINE('1 row updated where invoice_id = ' || 
                            invoice_row.invoice_id);
    END IF; 

  END LOOP;
  
  -- remove ROLLBACK to view changes
  ROLLBACK;
  DBMS_OUTPUT.PUT_LINE('ROLLBACK succeeded.');

END;
/

/*
SELECT * FROM invoices WHERE invoice_total > 1000 AND invoice_total - payment_total - credit_total > 0;

UPDATE invoices
SET credit_total = credit_total + (invoice_total * .1)
WHERE invoice_total - payment_total - credit_total > 0
AND invoice_total > 1000;

ROLLBACK;
*/