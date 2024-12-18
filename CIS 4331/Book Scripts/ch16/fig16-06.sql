CONNECT ap/ap;

CREATE OR REPLACE TRIGGER ap_before_create_drop
BEFORE CREATE OR DROP ON ap.SCHEMA
BEGIN
  RAISE_APPLICATION_ERROR(-20001, 
    'You cannot create or drop an object in the AP schema');
END;
/

CREATE TABLE test1 (test_id NUMBER);

DROP TRIGGER ap_before_create_drop;