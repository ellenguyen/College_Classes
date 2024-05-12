-- use the EX connection
CONNECT ex/ex;

DROP TABLE invoices;
DROP TABLE vendors;

CREATE TABLE vendors
(
  vendor_id     NUMBER          PRIMARY KEY,
  vendor_name   VARCHAR2(50)    NOT NULL       UNIQUE
);

CREATE TABLE invoices
(
  invoice_id       NUMBER          PRIMARY KEY,
  vendor_id        NUMBER          REFERENCES vendors (vendor_id),
  invoice_number   VARCHAR2(50)    NOT NULL    UNIQUE
);

DROP TABLE invoices;

CREATE TABLE invoices
(
  invoice_id       NUMBER          NOT NULL,
  vendor_id        NUMBER          NOT NULL,
  invoice_number   VARCHAR2(50)    NOT NULL    UNIQUE,
  CONSTRAINT invoices_pk 
    PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_vendors
    FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id)
    ON DELETE CASCADE
);

-- An INSERT statement that fails because a related row doesn't exist
INSERT INTO invoices
VALUES (1, 1, '1');
