-- to execute a single statement, move the cursor into the statement and press F9
-- to execute the entire script, press F5
-- to get rid of errors, you may need to execute the entire script a second time

CONNECT system/system;

-- drop the users
DROP USER john;
DROP USER jane;
DROP USER jim;

-- drop the role
DROP ROLE ar_user;

-- drop the synonym
DROP PUBLIC SYNONYM customers;

-- connect as the AR user
CONNECT ar/ar;

-- create the role
CREATE ROLE ar_user;

GRANT CREATE SESSION TO ar_user;
GRANT CREATE PUBLIC SYNONYM TO ar_user;
GRANT SELECT ON customers TO ar_user;
GRANT INSERT ON customers TO ar_user;

-- create the users
CREATE USER john IDENTIFIED BY sesame DEFAULT TABLESPACE users;
CREATE USER jane IDENTIFIED BY sesame DEFAULT TABLESPACE users;
CREATE USER jim  IDENTIFIED BY sesame DEFAULT TABLESPACE users;

GRANT ar_user TO john, jane, jim;

GRANT DELETE ON customers TO john;

-- create the public synonym
CONNECT john/sesame;
CREATE PUBLIC SYNONYM customers FOR ar.customers;

-- test John
CONNECT john/sesame;
SELECT customer_first_name FROM customers;

-- test Jane
CONNECT jane/sesame;
SELECT customer_first_name FROM customers;

-- connect as the AR user and revoke some privileges
CONNECT ar/ar;
REVOKE CREATE PUBLIC SYNONYM FROM ar_user;
REVOKE ar_user FROM jim;
REVOKE DELETE ON customers FROM john;
