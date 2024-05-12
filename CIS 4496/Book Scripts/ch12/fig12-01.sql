-- to execute a single statement, move the cursor into the statement and press F9
-- to execute the entire script, press F5
-- to fix errors, you may need to execute the entire script twice

-- drop the AR user and the Customers table
CONNECT system/system;
DROP USER ar CASCADE;

-- connect as the SYSTEM user and create the AR user
CONNECT system/system;
CREATE USER ar IDENTIFIED BY ar DEFAULT TABLESPACE users;
GRANT ALL PRIVILEGES TO ar;

-- connect as the AR user and create the Customers table
CONNECT ar/ar;
CREATE TABLE customers
(
  customer_id             NUMBER          NOT NULL,
  customer_first_name     VARCHAR2(50)    NOT NULL,
  customer_last_name      VARCHAR2(50)    NOT NULL,
  CONSTRAINT customers_pk 
    PRIMARY KEY (customer_id)
);
INSERT INTO ar.customers VALUES (1, 'Jack', 'Samson');
INSERT INTO customers VALUES (2, 'Joan', 'Redding');
INSERT INTO customers VALUES (3, 'Jim', 'Abbot');

-- change the password for the AR user
ALTER USER ar IDENTIFIED BY sesame;

-- change the password for the AR user
ALTER USER ar IDENTIFIED BY ar;

SELECT * FROM ar.customers;