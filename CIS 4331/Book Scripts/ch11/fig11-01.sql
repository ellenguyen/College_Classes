-- to execute a single statement, move the cursor into the statement and press F9
-- to execute the entire script, press F5
-- to get rid of errors, you may need to execute the entire script a second time

-- use the AP connection

CREATE VIEW vendors_min AS
  SELECT vendor_name, vendor_state, vendor_phone
  FROM vendors;

SELECT * FROM vendors_min;

SELECT * FROM vendors_min
WHERE vendor_state = 'CA'
ORDER BY vendor_name;

UPDATE vendors_min
SET vendor_phone = '(800) 555-3941'
WHERE vendor_name = 'Register of Copyrights';

ROLLBACK;

DROP VIEW vendors_min;