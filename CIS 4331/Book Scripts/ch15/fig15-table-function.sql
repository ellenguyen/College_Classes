-- A simple table function example

-- create a type for each row in the table
CREATE TYPE invoice_min AS OBJECT
(
  invoice_number  VARCHAR2(50), 
  invoice_date    DATE, 
  invoice_total   NUMBER(9,2)
);
/

-- create a type for the table
CREATE TYPE invoices_min AS TABLE OF invoice_min;
/

-- create a function that returns the table (a pipelined table function)
CREATE OR REPLACE FUNCTION get_invoices
(
   vendor_id_param NUMBER
)
RETURN invoices_min PIPELINED
AS 
  invoices_min_var invoices_min := invoices_min();

  CURSOR invoices_min_cur IS
    SELECT invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE vendor_id = vendor_id_param;
BEGIN
  FOR invoice_row IN invoices_min_cur LOOP
    PIPE ROW (invoice_min(
        invoice_row.invoice_number, 
        invoice_row.invoice_date, 
        invoice_row.invoice_total));  
  END LOOP;
  
  RETURN;
END;
/

-- use the TABLE function to use the nested table 
-- that's returned by the function in a SELECT statement
SELECT *
FROM TABLE(get_invoices(37));