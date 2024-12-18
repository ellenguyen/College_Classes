CREATE OR REPLACE FUNCTION avg_invoice_total
(
   vendor_id_param INTEGER
)
RETURN NUMBER AS 
   avg_invoice_total_var NUMBER(9,2);
BEGIN
  SELECT AVG(invoice_total)
  INTO avg_invoice_total_var
  FROM invoices
  WHERE vendor_id = vendor_id_param;
  
  RETURN avg_invoice_total_var;
END;
/