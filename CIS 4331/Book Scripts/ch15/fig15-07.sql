CREATE PROCEDURE clear_invoices_credit_total
(
  invoice_number_param  VARCHAR2
)
AS
BEGIN
  UPDATE invoices
  SET credit_total = 0
  WHERE invoice_number = invoice_number_param;
  
  COMMIT;
END;
/

CALL clear_invoices_credit_total('367447');

SELECT invoice_number, credit_total 
FROM invoices WHERE invoice_number = '367447';

DROP PROCEDURE clear_invoices_credit_total;

