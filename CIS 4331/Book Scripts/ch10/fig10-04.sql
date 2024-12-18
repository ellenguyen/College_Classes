-- use the EX connection
CONNECT ex/ex;

DROP TABLE invoices;

CREATE TABLE invoices
(
  invoice_id       NUMBER          PRIMARY KEY,
  invoice_total    NUMBER(9,2)     NOT NULL    CHECK (invoice_total >= 0),
  payment_total    NUMBER(9,2)     DEFAULT 0   CHECK (payment_total >= 0)
);

DROP TABLE invoices;

CREATE TABLE invoices
(
  invoice_id       NUMBER          PRIMARY KEY,
  invoice_total    NUMBER(9,2)     NOT NULL,
  payment_total    NUMBER(9,2)     DEFAULT 0, 
  CONSTRAINT invoices_ck CHECK (invoice_total >= 0 AND payment_total >= 0)
);

-- An INSERT statement that fails because of a check constraint
INSERT INTO invoices
VALUES (1, 99.99, -10);