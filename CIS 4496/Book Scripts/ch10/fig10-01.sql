-- to execute a single statement, move the cursor into the statement and press F9
-- to execute the entire script, press F5
-- to get rid of errors, you may need to execute the entire script a second time

-- use the EX connection
CONNECT ex/ex;

DROP TABLE vendors;  -- if necessary
CREATE TABLE vendors
(
  vendor_id     NUMBER,
  vendor_name   VARCHAR2(50)
);

DROP TABLE vendors;
CREATE TABLE vendors
(
  vendor_id     NUMBER          NOT NULL    UNIQUE,
  vendor_name   VARCHAR2(50)    NOT NULL    UNIQUE
);

DROP TABLE invoices;  -- if necessary
CREATE TABLE invoices
(
  invoice_id       NUMBER          NOT NULL    UNIQUE,
  vendor_id        NUMBER          NOT NULL,
  invoice_number   VARCHAR2(50)    NOT NULL,
  invoice_date     DATE                        DEFAULT SYSDATE,
  invoice_total    NUMBER(9,2)     NOT NULL,
  payment_total    NUMBER(9,2)                 DEFAULT 0
);