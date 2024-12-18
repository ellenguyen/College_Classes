CREATE OR REPLACE PROCEDURE update_invoices_credit_total
(
  invoice_number_param  VARCHAR2,
  credit_total_param    NUMBER 
)
AS
BEGIN
  UPDATE invoices
  SET credit_total = credit_total_param
  WHERE invoice_number = invoice_number_param;
  
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/

-- Use the CALL statement
CALL update_invoices_credit_total('367447', 200);

SELECT invoice_number, credit_total 
FROM invoices WHERE invoice_number = '367447';

BEGIN
  update_invoices_credit_total('367447', 300);
END;
/

BEGIN
  update_invoices_credit_total(
    credit_total_param=>300, 
    invoice_number_param=>'367447');
END;
/

SELECT invoice_number, credit_total 
FROM invoices WHERE invoice_number = '367447';

CALL update_invoices_credit_total('367447', 0);

SELECT invoice_number, credit_total 
FROM invoices WHERE invoice_number = '367447';