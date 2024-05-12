-- Business rule for trigger:
-- credit total should never be greater than 
-- the max value of the invoice total column for a vendor

-- NOTE: this trigger prevents the mutating-table error
CREATE OR REPLACE TRIGGER invoices_before_update_total_2
FOR UPDATE OF invoice_total, credit_total
ON invoices
COMPOUND TRIGGER 
  TYPE vendor_ids_table             IS TABLE OF NUMBER;
  TYPE max_invoice_totals_table     IS TABLE OF NUMBER;
  TYPE ids_totals_table             IS TABLE OF NUMBER
                                    INDEX BY BINARY_INTEGER;

  vendor_ids                        vendor_ids_table;  
  max_invoice_totals                max_invoice_totals_table;  
  ids_totals                        ids_totals_table;

  BEFORE STATEMENT IS
    vendor_id NUMBER;
    max_invoice_total NUMBER;
  BEGIN
    SELECT vendor_id, MAX(invoice_total)
    BULK COLLECT INTO vendor_ids, max_invoice_totals
    FROM invoices
    GROUP BY vendor_id;
    
    FOR i IN 1..vendor_ids.COUNT() LOOP
      vendor_id := vendor_ids(i);
      max_invoice_total:= max_invoice_totals(i);
      ids_totals(vendor_id) := max_invoice_total;
    END LOOP;   
  END BEFORE STATEMENT;

  BEFORE EACH ROW IS
    max_invoice_total NUMBER;
  BEGIN
    max_invoice_total := ids_totals(:new.vendor_id);
    IF :new.credit_total > max_invoice_total THEN
      RAISE_APPLICATION_ERROR(-20001, 
        'invoice_credit value may not exceed the maximum 
        invoice_total value for a vendor.');
    END IF;
  END BEFORE EACH ROW;  

END;
/

UPDATE invoices
SET credit_total = 1000
WHERE invoice_id = 100;

SELECT invoice_id, invoice_total, credit_total, payment_total 
FROM invoices WHERE invoice_id = 100;
