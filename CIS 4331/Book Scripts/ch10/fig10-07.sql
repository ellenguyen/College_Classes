-- use the EX connection
CONNECT ex/ex;

RENAME vendors TO vendor;
RENAME invoices TO invoice;

TRUNCATE TABLE invoice;
TRUNCATE TABLE vendor;

-- use the AP schema
CONNECT ap/ap;

DROP TABLE ex.invoice;
DROP TABLE ex.vendor;

-- use the EX schema
CONNECT ex/ex;

CREATE TABLE vendors
(
  vendor_id     NUMBER          CONSTRAINT vendors_pk PRIMARY KEY,
  vendor_name   VARCHAR2(50)    UNIQUE
);

CREATE TABLE invoices
(
  invoice_id       NUMBER          CONSTRAINT invoices_pk PRIMARY KEY,
  vendor_id        NUMBER          CONSTRAINT invoices_fk_vendors REFERENCES vendors (vendor_id),
  invoice_total    NUMBER(9,2)     NOT NULL    CONSTRAINT invoice_total_ck   CHECK (invoice_total >= 0),
  payment_total    NUMBER(9,2)     DEFAULT 0   CONSTRAINT payment_total_ck   CHECK (payment_total >= 0)
);

INSERT INTO vendors
VALUES(1, 'US Postal Service');

INSERT INTO invoices
VALUES(1, 1, 0, 0);