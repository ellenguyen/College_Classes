CREATE OR REPLACE FUNCTION get_balance_due
(
   invoice_id_param NUMBER
)
RETURN NUMBER
AS 
  balance_due_var NUMBER;
BEGIN
  SELECT invoice_total - payment_total - credit_total AS balance_due
  INTO balance_due_var
  FROM invoices
  WHERE invoice_id = invoice_id_param;
  
  RETURN balance_due_var;
END;
/

SELECT vendor_id, invoice_number, 
       get_balance_due(invoice_id) AS balance_due 
FROM invoices
WHERE vendor_id = 37;
