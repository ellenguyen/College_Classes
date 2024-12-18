CREATE OR REPLACE TRIGGER vendors_before_update_state
BEFORE INSERT OR UPDATE OF vendor_state 
ON vendors
FOR EACH ROW 
WHEN (new.vendor_state != UPPER(new.vendor_state))
BEGIN
  :new.vendor_state := UPPER(:new.vendor_state);
END;
/

UPDATE vendors
SET vendor_state = 'wi'
WHERE vendor_id = 1;

SELECT vendor_name, vendor_state
FROM vendors
WHERE vendor_id = 1;