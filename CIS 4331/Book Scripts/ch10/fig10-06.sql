-- use the EX connection
CONNECT ex/ex;

DROP TABLE invoices;
DROP TABLE vendors;

-- NOTE: these tables don't contain FOREIGN KEY or UNIQUE constraints
CREATE TABLE vendors
(
  vendor_id     NUMBER          CONSTRAINT vendors_pk PRIMARY KEY,
  vendor_name   VARCHAR2(50)
);

CREATE TABLE invoices
(
  invoice_id       NUMBER          CONSTRAINT invoices_pk PRIMARY KEY,
  vendor_id        NUMBER          NOT NULL,
  invoice_total    NUMBER(9,2)     NOT NULL    CONSTRAINT invoice_total_ck   CHECK (invoice_total >= 0),
  payment_total    NUMBER(9,2)     DEFAULT 0   CONSTRAINT payment_total_ck   CHECK (payment_total >= 0)
);

INSERT INTO vendors
VALUES(1, 'US Postal Service');

INSERT INTO invoices
VALUES(1, 1, 0, 0);

/***************************************
* CHECK constraints
**************************************/
ALTER TABLE invoices
DROP CONSTRAINT invoice_total_ck;

ALTER TABLE invoices
ADD CONSTRAINT invoice_total_ck CHECK (invoice_total >= 0);

ALTER TABLE invoices
DROP CONSTRAINT invoice_total_ck;

ALTER TABLE invoices
ADD CONSTRAINT invoice_total_ck CHECK (invoice_total >= 1) DISABLE;

ALTER TABLE invoices
ENABLE NOVALIDATE CONSTRAINT invoice_total_ck;

ALTER TABLE invoices
DISABLE CONSTRAINT invoice_total_ck;

/***************************************
* FOREIGN KEY constraints
**************************************/
ALTER TABLE invoices
ADD CONSTRAINT invoices_fk_vendors
FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id);

ALTER TABLE invoices
DROP CONSTRAINT invoices_fk_vendors;

/***************************************
* UNIQUE constraints
**************************************/
ALTER TABLE vendors
ADD CONSTRAINT vendors_vendor_name_uq
UNIQUE (vendor_name);

ALTER TABLE vendors
DROP CONSTRAINT vendors_vendor_name_uq;

/***************************************
* NOT NULL constraints
**************************************/
ALTER TABLE vendors
MODIFY vendor_name 
CONSTRAINT vendors_vendor_name_nn NOT NULL;

ALTER TABLE vendors
DROP CONSTRAINT vendors_vendor_name_nn;
