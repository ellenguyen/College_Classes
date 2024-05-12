-- this SELECT statement will fail
CONNECT john/sesame;
SELECT vendor_name FROM vendors WHERE vendor_id = 1;

-- create a public synonym
CONNECT ap/ap;
GRANT CREATE PUBLIC SYNONYM, 
      DROP PUBLIC SYNONYM 
      TO ap_user;

CONNECT john/sesame;
CREATE PUBLIC SYNONYM vendors FOR ap.vendors;

CONNECT jane/sesame;
SELECT vendor_name FROM vendors WHERE vendor_id = 1;

DROP PUBLIC SYNONYM vendors;