-- use the EX connection
CONNECT ex/ex;

DROP TABLE invoices;
DROP TABLE vendors;

CREATE TABLE vendors
(
  vendor_id     NUMBER          PRIMARY KEY,
  vendor_name   VARCHAR2(50)    NOT NULL       UNIQUE
);

ALTER TABLE vendors
ADD last_transaction_date DATE;

ALTER TABLE vendors
DROP COLUMN last_transaction_date;

ALTER TABLE vendors
MODIFY vendor_name VARCHAR2(100);

ALTER TABLE vendors
MODIFY vendor_name CHAR(100);

ALTER TABLE vendors
MODIFY vendor_name DEFAULT 'New Vendor';

INSERT INTO vendors
VALUES (1, 'US Postal Service');

ALTER TABLE vendors
MODIFY vendor_name CHAR(10);
