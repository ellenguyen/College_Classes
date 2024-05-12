CONNECT ap/ap;
SET SERVEROUTPUT ON;

DECLARE
  invoice_id_var NUMBER;
  terms_id_var NUMBER;
  dynamic_sql VARCHAR2(400);
BEGIN
  invoice_id_var := &invoice_id;
  terms_id_var := &terms_id;
  
  dynamic_sql := 'UPDATE invoices ' ||
                 'SET terms_id = ' || terms_id_var || ' ' ||
                 'WHERE invoice_id = ' || invoice_id_var;

  DBMS_OUTPUT.PUT_LINE('dynamic_sql: ' || dynamic_sql);
  
  EXECUTE IMMEDIATE dynamic_sql;
END;
/

SELECT invoice_id, terms_id FROM invoices WHERE invoice_id = 114;