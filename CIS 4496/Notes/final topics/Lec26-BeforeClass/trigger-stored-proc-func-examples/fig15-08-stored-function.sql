--compiled before stored in the database
--return a value or table
--cannot make changes to the database, e.g. run INSERT/DELETE/UPDATE

CREATE OR REPLACE FUNCTION get_vendor_id
(
   vendor_name_param VARCHAR2
)
RETURN NUMBER
AS 
  vendor_id_var NUMBER;
BEGIN
  SELECT vendor_id
  INTO vendor_id_var
  FROM vendors
  WHERE vendor_name = vendor_name_param;
  
  RETURN vendor_id_var;
END;
/

--call from a query
SELECT invoice_number, invoice_total
FROM invoices
WHERE vendor_id = get_vendor_id('IBM');

DROP FUNCTION get_vendor_id;
