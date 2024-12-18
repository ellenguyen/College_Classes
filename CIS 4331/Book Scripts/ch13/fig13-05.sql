CONNECT ap/ap;

SET SERVEROUTPUT ON;

DECLARE
  first_invoice_due_date DATE;
BEGIN  
  SELECT MIN(invoice_due_date)
  INTO first_invoice_due_date
  FROM invoices
  WHERE invoice_total - payment_total - credit_total > 0;

  IF first_invoice_due_date < SYSDATE() THEN
    DBMS_OUTPUT.PUT_LINE('Outstanding invoices overdue!');
  ELSIF first_invoice_due_date = SYSDATE() THEN
    DBMS_OUTPUT.PUT_LINE('Outstanding invoices are due today!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('No invoices are overdue.');
  END IF;

  -- the IF statement rewritten as a Searched CASE statement
  /*
  CASE  
    WHEN first_invoice_due_date < SYSDATE() THEN
      DBMS_OUTPUT.PUT_LINE('Outstanding invoices overdue!');
    WHEN first_invoice_due_date = SYSDATE() THEN
      DBMS_OUTPUT.PUT_LINE('Outstanding invoices are due today!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('No invoices are overdue.');
  END CASE;
  */
  
END;
/