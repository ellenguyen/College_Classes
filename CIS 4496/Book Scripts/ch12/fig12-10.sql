-- this SELECT statement will fail
CONNECT john/sesame;
SELECT vendor_name FROM vendors WHERE vendor_id = 1;

-- create a private synonym
CONNECT ap/ap;
GRANT CREATE SYNONYM TO john;

CONNECT john/sesame;
CREATE SYNONYM vendors FOR ap.vendors;

SELECT vendor_name FROM vendors WHERE vendor_id = 1;

DROP SYNONYM vendors;