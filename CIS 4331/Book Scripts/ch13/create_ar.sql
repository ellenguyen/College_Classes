SPOOL create_ar.log;

PROMPT Creating AR user...
PROMPT 

CONNECT system/system;
BEGIN  
  EXECUTE IMMEDIATE 'DROP USER ar CASCADE';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
CREATE USER ar IDENTIFIED BY ar DEFAULT TABLESPACE users;
GRANT ALL PRIVILEGES TO ar;

PROMPT Creating AR tables...
PROMPT 

CONNECT ar/ar;
CREATE TABLE customers
(
  customer_id             NUMBER          NOT NULL,
  customer_first_name     VARCHAR2(50)    NOT NULL,
  customer_last_name      VARCHAR2(50)    NOT NULL,
  CONSTRAINT customers_pk 
    PRIMARY KEY (customer_id)
);
INSERT INTO customers VALUES (1, 'Jack', 'Samson');
INSERT INTO customers VALUES (2, 'Joan', 'Redding');
INSERT INTO customers VALUES (3, 'Jim', 'Abbot');

SPOOL OFF;

PROMPT Check create_ar.log for details...
PROMPT 

EXIT;