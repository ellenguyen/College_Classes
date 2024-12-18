--Week 6, Wk 7 
--Murach Ch10 Book Chapter Code covered in class
--Part 2

--NOTE: Run all statements as user EX

--Topics covered (cont'd)
--4. Create tables with Check constraints
--5. Add/Drop/Modify column definition using ALTER TABLE
--6. Change the constraints using ALTER TABLE
----6.1 Add/Drop/Modify check constraint type
----6.2 Modify foreign key constraint type
----6.3 Modify unique constraint type
----6.4 Modify NOT NULL constraint type
--7. Rename a table
--8. Truncate a table


--3. Create tables with Foreign Key constraints

  DROP TABLE invoices;
  DROP TABLE vendors;

CREATE TABLE vendors
(
  vendor_id     NUMBER          PRIMARY KEY,
  vendor_name   VARCHAR2(50)    NOT NULL       UNIQUE
);

--column level foreign key constraint
CREATE TABLE invoices
(
  invoice_id       NUMBER          PRIMARY KEY,
  vendor_id        NUMBER          REFERENCES vendors (vendor_id),
  invoice_number   VARCHAR2(50)    NOT NULL    UNIQUE
);

  DROP TABLE invoices;
--table level foreign key constraint
CREATE TABLE invoices
(
  invoice_id       NUMBER          NOT NULL,
  vendor_id        NUMBER          NOT NULL,
  invoice_number   VARCHAR2(50)    NOT NULL    UNIQUE,
  CONSTRAINT invoices_pk 
    PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_vendors
    FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id)
);

--foreign key constraint with ON DELETE clause
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
    ON DELETE CASCADE --when deleting a vendor, all its invoices are automatically deleted too.
);

--An insert violating the above foreign key constraint invoices_fk_vendors
INSERT INTO invoices
VALUES (1, 1, '1');

--4. Create tables with CHECK constraint

  DROP TABLE invoices;
--column level CHECK constraint
CREATE TABLE invoices
(
  invoice_id       NUMBER          PRIMARY KEY,
  invoice_total    NUMBER(9,2)     NOT NULL    CHECK (invoice_total >= 0),
  payment_total    NUMBER(9,2)     DEFAULT 0   CHECK (payment_total >= 0)
);

  DROP TABLE invoices;
--table level CHECK constraint involving 2 columns
CREATE TABLE invoices
(
  invoice_id       NUMBER          PRIMARY KEY,
  invoice_total    NUMBER(9,2)     NOT NULL,
  payment_total    NUMBER(9,2)     DEFAULT 0, 
  CONSTRAINT invoices_ck CHECK (invoice_total >= 0 AND payment_total >= 0)
);

-- An INSERT statement that fails because of a check constraint: payment_total >= 0
INSERT INTO invoices VALUES (1, 99.99, -10);


--5. Add/Drop/Modify column definition using ALTER TABLE

--recreate the table vendors
DROP TABLE invoices;
DROP TABLE vendors;
CREATE TABLE vendors
(
  vendor_id     NUMBER          PRIMARY KEY,
  vendor_name   VARCHAR2(50)    NOT NULL       UNIQUE
);

--add a column
ALTER TABLE vendors
ADD last_transaction_date DATE;

--drop an existing column
ALTER TABLE vendors
DROP COLUMN last_transaction_date;

--enlarge the length of an existing column vendor_name
ALTER TABLE vendors
MODIFY vendor_name VARCHAR2(100);  --old: VARCHAR2(50)

--change the type of vendor_name column
ALTER TABLE vendors
MODIFY vendor_name CHAR(100); --old: VARCHAR2(100)

--add a new default value for column vendor_name
ALTER TABLE vendors
MODIFY vendor_name DEFAULT 'New Vendor';

INSERT INTO vendors
VALUES (1, 'US Postal Service');

--Try to shorten the length of column vendor_name, but failed
ALTER TABLE vendors
MODIFY vendor_name CHAR(10);


--6. Change the constraints using ALTER TABLE

--recreate and populate the tables for the examples
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

----6.1 Add/Drop/Modify check constrain type
/***************************************
* CHECK constraints
**************************************/
--drop a constraint named invoice_total_ck
ALTER TABLE invoices
DROP CONSTRAINT invoice_total_ck;

--add a constraint to ensure invoice total is at least 0
ALTER TABLE invoices
ADD CONSTRAINT invoice_total_ck CHECK (invoice_total >= 0);

ALTER TABLE invoices
DROP CONSTRAINT invoice_total_ck;

--recreate the constraint invoice_total_ck, making sure invoice total is at least 10,
-- but disable it initially.
--The rule applies to neither new nor existing data.
ALTER TABLE invoices
ADD CONSTRAINT invoice_total_ck CHECK (invoice_total >= 10) DISABLE;

--change the status of constraint invoice_total_ck to enabled and not validated
--The rule applies to only new data. Does not check existing data against the rule.
ALTER TABLE invoices
ENABLE NOVALIDATE CONSTRAINT invoice_total_ck;

--enable the constraint invoice_total_ck, also check existing data against the rule.
ALTER TABLE invoices
ENABLE CONSTRAINT invoice_total_ck;

--disable the constraint invoice_total_ck so that the rule is not applied to new and existing invoices
ALTER TABLE invoices
DISABLE CONSTRAINT invoice_total_ck;

----6.2 Modify foreign key constraint type

/***************************************
* FOREIGN KEY constraints
**************************************/
--add a foreign key constraint to child table invoices, 
--   referencing column vendor_id in parent table vendors
ALTER TABLE invoices
ADD CONSTRAINT invoices_fk_vendors
FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id);

--drop a foreign key constraint invoices_fk_vendors
ALTER TABLE invoices
DROP CONSTRAINT invoices_fk_vendors;

----6.3 Modify unique constraint type

/***************************************
* UNIQUE constraints
**************************************/
--add a new unique constraint named vendors_vendor_name_uq, ensuring unique vendor name
ALTER TABLE vendors
ADD CONSTRAINT vendors_vendor_name_uq
UNIQUE (vendor_name);

--drop the constraint named vendors_vendor_name_uq
ALTER TABLE vendors
DROP CONSTRAINT vendors_vendor_name_uq;

----6.4 Modify NOT NULL constraint type

/***************************************
* NOT NULL constraints
**************************************/
--add a constraint named vendors_vendor_name_nn, excluding null values in vendor_name column
ALTER TABLE vendors
MODIFY vendor_name 
CONSTRAINT vendors_vendor_name_nn NOT NULL;

--drop the constraint named vendors_vendor_name_nn
ALTER TABLE vendors
DROP CONSTRAINT vendors_vendor_name_nn;

--7. Rename a table
RENAME vendors TO vendor;
RENAME invoices TO invoice;

--8. Truncate a table
TRUNCATE TABLE invoice;
TRUNCATE TABLE vendor;


