-- use the AP schema
CONNECT ap/ap;

CREATE OR REPLACE VIEW vendor_payment AS
  SELECT vendor_name, invoice_number, invoice_date, payment_date,
         invoice_total, credit_total, payment_total
  FROM vendors JOIN invoices ON vendors.vendor_id = invoices.vendor_id
  WHERE invoice_total - payment_total - credit_total >= 0
WITH CHECK OPTION;

SELECT * FROM vendor_payment
WHERE invoice_number = 'P-0608';

UPDATE vendor_payment
SET payment_total = payment_total + 400.00, 
    payment_date = '01-AUG-14'
WHERE invoice_number = 'P-0608';

SELECT * FROM vendor_payment
WHERE invoice_number = 'P-0608';

ROLLBACK;

-- this will fail due to the WITH CHECK OPTION clause
UPDATE vendor_payment
SET payment_total = 30000.00, 
    payment_date = '01-AUG-14'
WHERE invoice_number = 'P-0608';

SELECT * FROM vendor_payment
WHERE invoice_number = 'P-0608';

-- make sure data is set back to original data
UPDATE vendor_payment
SET payment_total = 0, 
    payment_date = NULL
WHERE invoice_number = 'P-0608';
