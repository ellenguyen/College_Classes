CONNECT ap/ap;

-- Use an anonymous PL/SQL script to
-- drop all end users, roles, and synonyms in the current database 
-- and suppress any error messages that may be displayed 
-- if these objects don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP USER john';
  EXECUTE IMMEDIATE 'DROP USER jane';
  EXECUTE IMMEDIATE 'DROP USER jim';
  EXECUTE IMMEDIATE 'DROP USER joel CASCADE';

  EXECUTE IMMEDIATE 'DROP ROLE ap_user';
  EXECUTE IMMEDIATE 'DROP ROLE ap_manager';
  EXECUTE IMMEDIATE 'DROP ROLE ap_developer';
  
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM vendors';
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM invoices';
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM invoice_line_items';
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM general_ledger_accounts';
  EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM terms';  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- create the roles
CREATE ROLE ap_user;
CREATE ROLE ap_manager;
CREATE ROLE ap_developer;

-- grant privileges to the ap_user role
GRANT CREATE SESSION TO ap_user;
GRANT CREATE PUBLIC SYNONYM TO ap_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON vendors TO ap_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON invoices TO ap_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON invoice_line_items TO ap_user;
GRANT SELECT ON general_ledger_accounts TO ap_user;
GRANT SELECT ON terms TO ap_user;
GRANT SELECT ON invoice_id_seq TO ap_user;
GRANT SELECT ON vendor_id_seq TO ap_user;

-- grant privileges to the ap_manager role
GRANT ap_user TO ap_manager WITH ADMIN OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON general_ledger_accounts TO ap_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON terms TO ap_manager;

-- grant privileges to the ap_developer role
GRANT 
  ap_manager, 
  CREATE ANY TABLE, 
  DROP ANY TABLE, 
  CREATE ANY VIEW,
  DROP ANY VIEW,
  CREATE ANY SEQUENCE, 
  DROP ANY SEQUENCE
TO ap_developer;

-- create the users
CREATE USER john IDENTIFIED BY sesame DEFAULT TABLESPACE users;
CREATE USER jane IDENTIFIED BY sesame DEFAULT TABLESPACE users;
CREATE USER jim IDENTIFIED BY sesame DEFAULT TABLESPACE users;
CREATE USER joel IDENTIFIED BY sesame DEFAULT TABLESPACE users;

-- assign the users to their roles
GRANT ap_user TO john, jane;
GRANT ap_manager TO jim;
GRANT ap_developer TO joel;

-- allow Joel to create tables
ALTER USER joel QUOTA 10M ON users;

-- create synonyms for all users
CONNECT joel/sesame;
CREATE PUBLIC SYNONYM vendors FOR ap.vendors;
CREATE PUBLIC SYNONYM invoices FOR ap.invoices;
CREATE PUBLIC SYNONYM invoice_line_items FOR ap.invoice_line_items;
CREATE PUBLIC SYNONYM general_ledger_accounts FOR 
                      ap.general_ledger_accounts;
CREATE PUBLIC SYNONYM terms FOR ap.terms;

-- require the users to change their passwords when they log in
/*
CONNECT ap/ap;
ALTER USER john PASSWORD EXPIRE;
ALTER USER jane PASSWORD EXPIRE;
ALTER USER jim PASSWORD EXPIRE;
ALTER USER joel PASSWORD EXPIRE;
*/