CREATE OR REPLACE TRIGGER vendors_before_update_state
BEFORE INSERT OR UPDATE OF vendor_state 
ON vendors
FOR EACH ROW --row level trigger, fired for each row
WHEN (new.vendor_state != UPPER(new.vendor_state)) -- no : before new in WHEN clause
BEGIN
  :new.vendor_state := UPPER(:new.vendor_state); --must use : before new
END;
/

UPDATE vendors
SET vendor_state = 'wi'
WHERE vendor_id = 1;


DROP TRIGGER vendors_before_update_state;