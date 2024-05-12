-- use the EX connection
CONNECT ex/ex;

DROP TABLE vendors;
CREATE TABLE vendors
(
  vendor_id     NUMBER          PRIMARY KEY,
  vendor_name   VARCHAR2(50)    NOT NULL   UNIQUE
);

-- Another possible syntax
DROP TABLE vendors;
CREATE TABLE vendors
(
  vendor_id     NUMBER          CONSTRAINT vendors_pk PRIMARY KEY,
  vendor_name   VARCHAR2(50)    CONSTRAINT vendor_name_nn NOT NULL
                                CONSTRAINT vendor_name_un UNIQUE
);

DROP TABLE vendors;
CREATE TABLE vendors
(
  vendor_id     NUMBER,
  vendor_name   VARCHAR2(50)   NOT NULL,
  CONSTRAINT vendors_pk 
    PRIMARY KEY (vendor_id),
  CONSTRAINT vendor_name_unq 
    UNIQUE (vendor_name)
);

DROP TABLE invoice_line_items;
CREATE TABLE invoice_line_items
(
  invoice_id              NUMBER        NOT NULL,
  invoice_sequence        NUMBER        NOT NULL,
  line_item_description   VARCHAR2(100) NOT NULL,
  CONSTRAINT line_items_pk 
    PRIMARY KEY (invoice_id, invoice_sequence)
);