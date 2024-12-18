CREATE FUNCTION get_sum_balance_due
(
   vendor_id_param NUMBER
)
RETURN NUMBER
AS 
  sum_balance_due_var NUMBER;
BEGIN
  SELECT SUM(get_balance_due(invoice_id)) AS sum_balance_due
  INTO sum_balance_due_var 
  FROM invoices
  WHERE vendor_id = vendor_id_param;
  
  RETURN sum_balance_due_var;
END;
/

SELECT vendor_id, invoice_number, 
       get_balance_due(invoice_id) AS balance_due, 
       get_sum_balance_due(vendor_id) AS sum_balance_due
FROM invoices
WHERE vendor_id = 37;

DROP FUNCTION get_sum_balance_due;