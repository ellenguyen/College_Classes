--compiled before stored in the database
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
  WHEN OTHERS THEN  --for all other errors not handled by previous WHEN clause
    ROLLBACK;
END;
/

-- Use the CALL statement
CALL update_invoices_credit_total('367447', 200);


--call from anonymous pl/sql block, without parameter names
-- value order = parameter order
BEGIN
  update_invoices_credit_total('367447', 300);
END;
/

--call from anonymous pl/sql block with parameter names
--value order can be different from parameter order
BEGIN
  update_invoices_credit_total(
    credit_total_param=>300, 
    invoice_number_param=>'367447');
END;
/

CALL update_invoices_credit_total('367447', 0);

DROP PROCEDURE update_invoices_credit_total;