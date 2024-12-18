--Week 6
--Murach Ch10 Book Chapter Code covered in class

--NOTE: Run all statements as user EX

--Topics covered
--1. Create table basics
--2. Create table with Primary Key constraints
--3. Create tables with Foreign Key constraints

--1. Create table basics

--Create table vendors with 2 columns
CREATE TABLE vendors
(
  vendor_id     NUMBER,    --maximum decimal number
  vendor_name   VARCHAR2(50) --variable length character with max 50 characters
);

--Remove table vendors (both data & definition) before recreating it
DROP TABLE vendors;

--Create tables with column attributes

--Create table vendors with unique vendor id and unique vendor name.
CREATE TABLE vendors
(
  vendor_id     NUMBER          NOT NULL    UNIQUE, --Column attributes: NOT NULL, UNIQUE
  vendor_name   VARCHAR2(50)    NOT NULL    UNIQUE
);

--Create table invoices with 6 columns and different column attributes
CREATE TABLE invoices
(
  invoice_id       NUMBER          NOT NULL    UNIQUE,
  vendor_id        NUMBER          NOT NULL,
  invoice_number   VARCHAR2(50)    NOT NULL,
  invoice_date     DATE                        DEFAULT SYSDATE, --column attribute: DEFAULT value
  invoice_total    NUMBER(9,2)     NOT NULL,                
  payment_total    NUMBER(9,2)                 DEFAULT 0
);

--2. Create table with Primary Key constraints

DROP TABLE vendors;

--create table vendors with vendor id being the primary key, uniquely identify each vendor
CREATE TABLE vendors
(
  vendor_id     NUMBER          PRIMARY KEY,   --column level constraint
  vendor_name   VARCHAR2(50)    NOT NULL   UNIQUE
);

DROP TABLE vendors;
--create table vendors with user-defined constraint names at column level
CREATE TABLE vendors
(
  vendor_id     NUMBER          CONSTRAINT vendors_pk PRIMARY KEY, 
  vendor_name   VARCHAR2(50)    CONSTRAINT vendor_name_nn NOT NULL
                                CONSTRAINT vendor_name_un UNIQUE
);

--table level constraints
  DROP TABLE vendors;
--table level named primary key constraint
CREATE TABLE vendors
(
  vendor_id     NUMBER,
  vendor_name   VARCHAR2(50)   NOT NULL,
  CONSTRAINT vendors_pk    
    PRIMARY KEY (vendor_id),
  CONSTRAINT vendor_name_uq 
    UNIQUE (vendor_name)
);

  DROP TABLE invoice_line_items;
--table level named composite primary key constraint  
CREATE TABLE invoice_line_items
(
  invoice_id              NUMBER        NOT NULL,
  invoice_sequence        NUMBER        NOT NULL,
  line_item_description   VARCHAR2(100) NOT NULL,
  CONSTRAINT line_items_pk 
    PRIMARY KEY (invoice_id, invoice_sequence)  
);

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
--table level foreign key (FK) constraint
CREATE TABLE invoices
(
  invoice_id       NUMBER          NOT NULL,
  vendor_id        NUMBER          NOT NULL,
  invoice_number   VARCHAR2(50)    NOT NULL    UNIQUE,
  CONSTRAINT invoices_pk 
    PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_vendors
    FOREIGN KEY (vendor_id) REFERENCES vendors (vendor_id) --table level FK
);
