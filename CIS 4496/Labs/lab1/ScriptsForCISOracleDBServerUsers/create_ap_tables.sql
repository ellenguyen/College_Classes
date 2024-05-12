--CONNECT ap/ap;

-- Use an anonymous PL/SQL script to
-- drop all tables and sequences in the current schema and
-- suppress any error messages that may displayed 
-- if these objects don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP SEQUENCE vendor_id_seq';
  EXECUTE IMMEDIATE 'DROP SEQUENCE invoice_id_seq';

  EXECUTE IMMEDIATE 'DROP TABLE invoice_archive';
  EXECUTE IMMEDIATE 'DROP TABLE invoice_line_items';
  EXECUTE IMMEDIATE 'DROP TABLE invoices';
  EXECUTE IMMEDIATE 'DROP TABLE vendor_contacts';
  EXECUTE IMMEDIATE 'DROP TABLE vendors';
  EXECUTE IMMEDIATE 'DROP TABLE terms';
  EXECUTE IMMEDIATE 'DROP TABLE general_ledger_accounts';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

CREATE TABLE general_ledger_accounts
(
  account_number        NUMBER          NOT NULL,
  account_description   VARCHAR2(50)    NOT NULL,
  CONSTRAINT gl_accounts_pk
    PRIMARY KEY (account_number),
  CONSTRAINT gl_account_description_uq 
    UNIQUE (account_description)
);

CREATE TABLE terms
(
  terms_id              NUMBER          NOT NULL,
  terms_description     VARCHAR2(50)    NOT NULL,
  terms_due_days        NUMBER          NOT NULL,
  CONSTRAINT terms_pk 
    PRIMARY KEY (terms_id)
);

CREATE TABLE vendors
(
  vendor_id                     NUMBER          NOT NULL,
  vendor_name                   VARCHAR2(50)    NOT NULL,
  vendor_address1               VARCHAR2(50),
  vendor_address2               VARCHAR2(50),
  vendor_city                   VARCHAR2(50)    NOT NULL,
  vendor_state                  CHAR(2)         NOT NULL,
  vendor_zip_code               VARCHAR2(20)    NOT NULL,
  vendor_phone                  VARCHAR2(50),
  vendor_contact_last_name      VARCHAR2(50),
  vendor_contact_first_name     VARCHAR2(50),
  default_terms_id              NUMBER          NOT NULL,
  default_account_number        NUMBER          NOT NULL,
  CONSTRAINT vendors_pk 
    PRIMARY KEY (vendor_id),
  CONSTRAINT vendors_vendor_name_uq 
    UNIQUE (vendor_name),
  CONSTRAINT vendors_fk_terms
    FOREIGN KEY (default_terms_id) 
    REFERENCES terms (terms_id),
  CONSTRAINT vendors_fk_accounts
    FOREIGN KEY (default_account_number) 
    REFERENCES general_ledger_accounts (account_number)
);

CREATE TABLE invoices
(
  invoice_id            NUMBER, 
  vendor_id             NUMBER          NOT NULL,
  invoice_number        VARCHAR2(50)    NOT NULL,
  invoice_date          DATE            NOT NULL,
  invoice_total         NUMBER(9,2)     NOT NULL,
  payment_total         NUMBER(9,2)                 DEFAULT 0,
  credit_total          NUMBER(9,2)                 DEFAULT 0,
  terms_id              NUMBER          NOT NULL,
  invoice_due_date      DATE            NOT NULL,
  payment_date          DATE,
  CONSTRAINT invoices_pk 
    PRIMARY KEY (invoice_id),
  CONSTRAINT invoices_fk_vendors
    FOREIGN KEY (vendor_id) 
    REFERENCES vendors (vendor_id),
  CONSTRAINT invoices_fk_terms
    FOREIGN KEY (terms_id) 
    REFERENCES terms (terms_id)
);

CREATE TABLE invoice_line_items
(
  invoice_id              NUMBER        NOT NULL,
  invoice_sequence        NUMBER        NOT NULL,
  account_number          NUMBER        NOT NULL,
  line_item_amt           NUMBER(9,2)   NOT NULL,
  line_item_description   VARCHAR2(100) NOT NULL,
  CONSTRAINT line_items_pk 
    PRIMARY KEY (invoice_id, invoice_sequence),
  CONSTRAINT line_items_fk_invoices
    FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id),
  CONSTRAINT line_items_fk_acounts
    FOREIGN KEY (account_number) REFERENCES general_ledger_accounts (account_number)
);

-- Create the indexes
CREATE INDEX vendors_terms_id_ix
  ON vendors (default_terms_id);
CREATE INDEX vendors_account_number_ix
  ON vendors (default_account_number);

CREATE INDEX invoices_invoice_date_ix
  ON invoices (invoice_date DESC);
CREATE INDEX invoices_vendor_id_ix
  ON invoices (vendor_id);
CREATE INDEX invoices_terms_id_ix
  ON invoices (terms_id);
CREATE INDEX line_items_account_number_ix
  ON invoice_line_items (account_number);
  
-- Create the sequences
CREATE SEQUENCE vendor_id_seq
  START WITH 124;
CREATE SEQUENCE invoice_id_seq
  START WITH 115;  

-- Create the test tables that aren't explicitly 
-- related to the previous five tables
CREATE TABLE vendor_contacts
(
  vendor_id       NUMBER        NOT NULL,
  last_name       VARCHAR2(50)  NOT NULL,
  first_name      VARCHAR2(50)  NOT NULL
);

CREATE TABLE invoice_archive
(
  invoice_id          NUMBER          NOT NULL,
  vendor_id           NUMBER          NOT NULL,
  invoice_number      VARCHAR2(50)    NOT NULL,
  invoice_date        DATE            NOT NULL,
  invoice_total       NUMBER          NOT NULL,
  payment_total       NUMBER          NOT NULL,
  credit_total        NUMBER          NOT NULL,
  terms_id            NUMBER          NOT NULL,
  invoice_due_date    DATE            NOT NULL,
  payment_date        DATE
);

-- Disable substitution variable prompting 
SET DEFINE OFF;

-- INSERT INTO general_ledger_accounts 
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (100,'Cash');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (110,'Accounts Receivable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (120,'Book Inventory');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (150,'Furniture');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (160,'Computer Equipment');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (162,'Capitalized Lease');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (167,'Software');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (170,'Other Equipment');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (181,'Book Development');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (200,'Accounts Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (205,'Royalties Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (221,'401K Employee Contributions');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (230,'Sales Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (234,'Medicare Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (235,'Income Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (237,'State Payroll Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (238,'Employee FICA Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (239,'Employer FICA Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (241,'Employer FUTA Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (242,'Employee SDI Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (243,'Employer UCI Taxes Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (251,'IBM Credit Corporation Payable');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (280,'Capital Stock');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (290,'Retained Earnings');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (300,'Retail Sales');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (301,'College Sales');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (302,'Trade Sales');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (306,'Consignment Sales');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (310,'Compositing Revenue');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (394,'Book Club Royalties');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (400,'Book Printing Costs');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (403,'Book Production Costs');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (500,'Salaries and Wages');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (505,'FICA');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (506,'FUTA');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (507,'UCI');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (508,'Medicare');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (510,'Group Insurance');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (520,'Building Lease');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (521,'Utilities');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (522,'Telephone');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (523,'Building Maintenance');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (527,'Computer Equipment Maintenance');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (528,'IBM Lease');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (532,'Equipment Rental');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (536,'Card Deck Advertising');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (540,'Direct Mail Advertising');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (541,'Space Advertising');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (546,'Exhibits and Shows');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (548,'Web Site Production and Fees');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (550,'Packaging Materials');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (551,'Business Forms');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (552,'Postage');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (553,'Freight');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (555,'Collection Agency Fees');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (556,'Credit Card Handling');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (565,'Bank Fees');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (568,'Auto License Fee');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (569,'Auto Expense');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (570,'Office Supplies');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (572,'Books, Dues, and Subscriptions');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (574,'Business Licenses and Taxes');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (576,'PC Software');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (580,'Meals');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (582,'Travel and Accomodations');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (589,'Outside Services');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (590,'Business Insurance');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (591,'Accounting');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (610,'Charitable Contributions');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (611,'Profit Sharing Contributions');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (620,'Interest Paid to Banks');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (621,'Other Interest');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (630,'Federal Corporation Income Taxes');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (631,'State Corporation Income Taxes');
INSERT INTO general_ledger_accounts (account_number,account_description) 
VALUES (632,'Sales Tax');

-- INSERT INTO terms 
INSERT INTO terms (terms_id,terms_description,terms_due_days) VALUES (1,'Net due 10 days',10);
INSERT INTO terms (terms_id,terms_description,terms_due_days) VALUES (2,'Net due 20 days',20);
INSERT INTO terms (terms_id,terms_description,terms_due_days) VALUES (3,'Net due 30 days',30);
INSERT INTO terms (terms_id,terms_description,terms_due_days) VALUES (4,'Net due 60 days',60);
INSERT INTO terms (terms_id,terms_description,terms_due_days) VALUES (5,'Net due 90 days',90);

-- INSERT INTO vendors 
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (1,'US Postal Service','Attn:  Supt. Window Services','PO Box 7005','Madison','WI','53707','(800) 555-1205','Alberto','Francesco',1,552);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (2,'National Information Data Ctr','PO Box 96621','NULL','Washington','DC','20090','(301) 555-8950','Irvin','Ania',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (3,'Register of Copyrights','Library Of Congress','NULL','Washington','DC','20559','NULL','Liana','Lukas',3,403);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (4,'Jobtrak','1990 Westwood Blvd Ste 260','NULL','Los Angeles','CA','90025','(800) 555-8725','Quinn','Kenzie',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (5,'Newbrige Book Clubs','3000 Cindel Drive','NULL','Washington','NJ','07882','(800) 555-9980','Marks','Michelle',4,394);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (6,'California Chamber Of Commerce','3255 Ramos Cir','NULL','Sacramento','CA','95827','(916) 555-6670','Mauro','Anton',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (7,'Towne Advertiser''s Mailing Svcs','Kevin Minder','3441 W Macarthur Blvd','Santa Ana','CA','92704','NULL','Maegen','Ted',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (8,'BFI Industries','PO Box 9369','NULL','Fresno','CA','93792','(559) 555-1551','Kaleigh','Erick',3,521);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (9,'Pacific Gas & Electric','Box 52001','NULL','San Francisco','CA','94152','(800) 555-6081','Anthoni','Kaitlyn',3,521);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (10,'Robbins Mobile Lock And Key','4669 N Fresno','NULL','Fresno','CA','93726','(559) 555-9375','Leigh','Bill',2,523);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (11,'Bill Marvin Electric Inc','4583 E Home','NULL','Fresno','CA','93703','(559) 555-5106','Hostlery','Kaitlin',2,523);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (12,'City Of Fresno','PO Box 2069','NULL','Fresno','CA','93718','(559) 555-9999','Mayte','Kendall',3,574);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (13,'Golden Eagle Insurance Co','PO Box 85826','NULL','San Diego','CA','92186','NULL','Blanca','Korah',3,590);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (14,'Expedata Inc','4420 N. First Street, Suite 108','NULL','Fresno','CA','93726','(559) 555-9586','Quintin','Marvin',3,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (15,'ASC Signs','1528 N Sierra Vista','NULL','Fresno','CA','93703','NULL','Darien','Elisabeth',1,546);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (16,'Internal Revenue Service','NULL','NULL','Fresno','CA','93888','NULL','Aileen','Joan',1,235);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (17,'Blanchard & Johnson Associates','27371 Valderas','NULL','Mission Viejo','CA','92691','(214) 555-3647','Keeton','Gonzalo',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (18,'Fresno Photoengraving Company','1952 "H" Street','P.O. Box 1952','Fresno','CA','93718','(559) 555-3005','Chaddick','Derek',3,403);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (19,'Crown Printing','1730 "H" St','NULL','Fresno','CA','93721','(559) 555-7473','Randrup','Leann',2,400);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (20,'Diversified Printing & Pub','2632 Saturn St','NULL','Brea','CA','92621','(714) 555-4541','Lane','Vanesa',3,400);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (21,'The Library Ltd','7700 Forsyth','NULL','St Louis','MO','63105','(314) 555-8834','Marques','Malia',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (22,'Micro Center','1555 W Lane Ave','NULL','Columbus','OH','43221','(614) 555-4435','Evan','Emily',2,160);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (23,'Yale Industrial Trucks-Fresno','3711 W Franklin','NULL','Fresno','CA','93706','(559) 555-2993','Alexis','Alexandro',3,532);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (24,'Zee Medical Service Co','4221 W Sierra Madre #104','NULL','Washington','IA','52353','NULL','Hallie','Juliana',3,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (25,'California Data Marketing','2818 E Hamilton','NULL','Fresno','CA','93721','(559) 555-3801','Jonessen','Moises',4,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (26,'Small Press','121 E Front St - 4th Floor','NULL','Traverse City','MI','49684','NULL','Colette','Dusty',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (27,'Rich Advertising','12 Daniel Road','NULL','Fairfield','NJ','07004','(201) 555-9742','Neil','Ingrid',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (29,'Vision Envelope & Printing','PO Box 3100','NULL','Gardena','CA','90247','(310) 555-7062','Raven','Jamari',3,551);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (30,'Costco','Fresno Warehouse','4500 W Shaw','Fresno','CA','93711','NULL','Jaquan','Aaron',3,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (31,'Enterprise Communications Inc','1483 Chain Bridge Rd, Ste 202','NULL','Mclean','VA','22101','(770) 555-9558','Lawrence','Eileen',2,536);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (32,'RR Bowker','PO Box 31','NULL','East Brunswick','NJ','08810','(800) 555-8110','Essence','Marjorie',3,532);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (33,'Nielson','Ohio Valley Litho Division','Location #0470','Cincinnati','OH','45264','NULL','Brooklynn','Keely',2,541);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (34,'IBM','PO Box 61000','NULL','San Francisco','CA','94161','(800) 555-4426','Camron','Trentin',1,160);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (35,'Cal State Termite','PO Box 956','NULL','Selma','CA','93662','(559) 555-1534','Hunter','Demetrius',2,523);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (36,'Graylift','PO Box 2808','NULL','Fresno','CA','93745','(559) 555-6621','Sydney','Deangelo',3,532);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (37,'Blue Cross','PO Box 9061','NULL','Oxnard','CA','93031','(800) 555-0912','Eliana','Nikolas',3,510);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (38,'Venture Communications Int''l','60 Madison Ave','NULL','New York','NY','10010','(212) 555-4800','Neftaly','Thalia',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (39,'Custom Printing Company','PO Box 7028','NULL','St Louis','MO','63177','(301) 555-1494','Myles','Harley',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (40,'Nat Assoc of College Stores','500 East Lorain Street','NULL','Oberlin','OH','44074','NULL','Bernard','Lucy',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (41,'Shields Design','415 E Olive Ave','NULL','Fresno','CA','93728','(559) 555-8060','Kerry','Rowan',2,403);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (42,'Opamp Technical Books','1033 N Sycamore Ave.','NULL','Los Angeles','CA','90038','(213) 555-4322','Paris','Gideon',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (43,'Capital Resource Credit','PO Box 39046','NULL','Minneapolis','MN','55439','(612) 555-0057','Maxwell','Jayda',3,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (44,'Courier Companies, Inc','PO Box 5317','NULL','Boston','MA','02206','(508) 555-6351','Antavius','Troy',4,400);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (45,'Naylor Publications Inc','PO Box 40513','NULL','Jacksonville','FL','32231','(800) 555-6041','Gerald','Kristofer',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (46,'Open Horizons Publishing','Book Marketing Update','PO Box 205','Fairfield','IA','52556','(515) 555-6130','Damien','Deborah',2,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (47,'Baker & Taylor Books','Five Lakepointe Plaza, Ste 500','2709 Water Ridge Parkway','Charlotte','NC','28217','(704) 555-3500','Bernardo','Brittnee',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (48,'Fresno County Tax Collector','PO Box 1192','NULL','Fresno','CA','93715','(559) 555-3482','Brenton','Kila',3,574);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (49,'Mcgraw Hill Companies','PO Box 87373','NULL','Chicago','IL','60680','(614) 555-3663','Holbrooke','Rashad',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (50,'Publishers Weekly','Box 1979','NULL','Marion','OH','43305','(800) 555-1669','Carrollton','Priscilla',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (51,'Blue Shield of California','PO Box 7021','NULL','Anaheim','CA','92850','(415) 555-5103','Smith','Kylie',3,510);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (52,'Aztek Label','Accounts Payable','1150 N Tustin Ave','Anaheim','CA','92807','(714) 555-9000','Griffin','Brian',3,551);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (53,'Gary McKeighan Insurance','3649 W Beechwood Ave #101','NULL','Fresno','CA','93711','(559) 555-2420','Jair','Caitlin',3,590);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (54,'Ph Photographic Services','2384 E Gettysburg','NULL','Fresno','CA','93726','(559) 555-0765','Cheyenne','Kaylea',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (55,'Quality Education Data','PO Box 95857','NULL','Chicago','IL','60694','(800) 555-5811','Misael','Kayle',2,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (56,'Springhouse Corp','PO Box 7247-7051','NULL','Philadelphia','PA','19170','(215) 555-8700','Maeve','Clarence',3,523);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (57,'The Windows Deck','117 W Micheltorena Top Floor','NULL','Santa Barbara','CA','93101','(800) 555-3353','Wood','Liam',3,536);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (58,'Fresno Rack & Shelving Inc','4718 N Bendel Ave','NULL','Fresno','CA','93722','NULL','Baylee','Dakota',2,523);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (59,'Publishers Marketing Assoc','627 Aviation Way','NULL','Manhatttan Beach','CA','90266','(310) 555-2732','Walker','Jovon',3,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (60,'The Mailers Guide Co','PO Box 1550','NULL','New Rochelle','NY','10802','NULL','Lacy','Karina',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (61,'American Booksellers Assoc','828 S Broadway','NULL','Tarrytown','NY','10591','(800) 555-0037','Angelica','Nashalie',3,574);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (62,'Cmg Information Services','PO Box 2283','NULL','Boston','MA','02107','(508) 555-7000','Randall','Yash',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (63,'Lou Gentile''s Flower Basket','722 E Olive Ave','NULL','Fresno','CA','93728','(559) 555-6643','Anum','Trisha',1,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (64,'Texaco','PO Box 6070','NULL','Inglewood','CA','90312','NULL','Oren','Grace',3,582);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (65,'The Drawing Board','PO Box 4758','NULL','Carol Stream','IL','60197','NULL','Mckayla','Jeffery',2,551);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (66,'Ascom Hasler Mailing Systems','PO Box 895','NULL','Shelton','CT','06484','NULL','Lewis','Darnell',3,532);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (67,'Bill Jones','Secretary Of State','PO Box 944230','Sacramento','CA','94244','NULL','Deasia','Tristin',3,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (68,'Computer Library','3502 W Greenway #7','NULL','Phoenix','AZ','85023','(602) 547-0331','Aryn','Leroy',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (69,'Frank E Wilber Co','2437 N Sunnyside','NULL','Fresno','CA','93727','(559) 555-1881','Millerton','Johnathon',3,532);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (70,'Fresno Credit Bureau','PO Box 942','NULL','Fresno','CA','93714','(559) 555-7900','Braydon','Anne',2,555);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (71,'The Fresno Bee','1626 E Street','NULL','Fresno','CA','93786','(559) 555-4442','Colton','Leah',2,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (72,'Data Reproductions Corp','4545 Glenmeade Lane','NULL','Auburn Hills','MI','48326','(810) 555-3700','Arodondo','Cesar',3,400);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (73,'Executive Office Products','353 E Shaw Ave','NULL','Fresno','CA','93710','(559) 555-1704','Danielson','Rachael',2,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (74,'Leslie Company','PO Box 610','NULL','Olathe','KS','66061','(800) 255-6210','Alondra','Zev',3,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (75,'Retirement Plan Consultants','6435 North Palm Ave, Ste 101','NULL','Fresno','CA','93704','(559) 555-7070','Edgardo','Salina',3,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (76,'Simon Direct Inc','4 Cornwall Dr Ste 102','NULL','East Brunswick','NJ','08816','(908) 555-7222','Bradlee','Daniel',2,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (77,'State Board Of Equalization','PO Box 942808','NULL','Sacramento','CA','94208','(916) 555-4911','Dean','Julissa',1,631);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (78,'The Presort Center','1627 "E" Street','NULL','Fresno','CA','93706','(559) 555-6151','Marissa','Kyle',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (79,'Valprint','PO Box 12332','NULL','Fresno','CA','93777','(559) 555-3112','Warren','Quentin',3,551);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (80,'Cardinal Business Media, Inc.','P O Box 7247-7844','NULL','Philadelphia','PA','19170','(215) 555-1500','Eulalia','Kelsey',2,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (81,'Wang Laboratories, Inc.','P.O. Box 21209','NULL','Pasadena','CA','91185','(800) 555-0344','Kapil','Robert',2,160);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (82,'Reiter''s Scientific & Pro Books','2021 K Street Nw','NULL','Washington','DC','20006','(202) 555-5561','Rodolfo','Carlee',2,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (83,'Ingram','PO Box 845361','NULL','Dallas','TX','75284','NULL','Yobani','Trey',2,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (84,'Boucher Communications Inc','1300 Virginia Dr. Ste 400','NULL','Fort Washington','PA','19034','(215) 555-8000','Carson','Julian',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (85,'Champion Printing Company','3250 Spring Grove Ave','NULL','Cincinnati','OH','45225','(800) 555-1957','Clifford','Jillian',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (86,'Computerworld','Department #1872','PO Box 61000','San Francisco','CA','94161','(617) 555-0700','Lloyd','Angel',1,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (87,'DMV Renewal','PO Box 942894','NULL','Sacramento','CA','94294','NULL','Josey','Lorena',4,568);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (88,'Edward Data Services','4775 E Miami River Rd','NULL','Cleves','OH','45002','(513) 555-3043','Helena','Jeanette',1,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (89,'Evans Executone Inc','4918 Taylor Ct','NULL','Turlock','CA','95380','NULL','Royce','Hannah',1,522);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (90,'Wakefield Co','295 W Cromwell Ave Ste 106','NULL','Fresno','CA','93711','(559) 555-4744','Rothman','Nathanael',2,170);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (91,'McKesson Water Products','P O Box 7126','NULL','Pasadena','CA','91109','(800) 555-7009','Destin','Luciano',2,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (92,'Zip Print & Copy Center','PO Box 12332','NULL','Fresno','CA','93777','(233) 555-6400','Javen','Justin',2,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (93,'AT&T','PO Box 78225','NULL','Phoenix','AZ','85062','NULL','Wesley','Alisha',3,522);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (94,'Abbey Office Furnishings','4150 W Shaw Ave','NULL','Fresno','CA','93722','(559) 555-8300','Francis','Kyra',2,150);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (95,'Pacific Bell','NULL','NULL','Sacramento','CA','95887','(209) 555-7500','Nickalus','Kurt',2,522);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (96,'Wells Fargo Bank','Business Mastercard','P.O. Box 29479','Phoenix','AZ','85038','(947) 555-3900','Damion','Mikayla',2,160);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (97,'Compuserve','Dept L-742','NULL','Columbus','OH','43260','(614) 555-8600','Armando','Jan',2,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (98,'American Express','Box 0001','NULL','Los Angeles','CA','90096','(800) 555-3344','Story','Kirsten',2,160);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (99,'Bertelsmann Industry Svcs. Inc','28210 N Avenue Stanford','NULL','Valencia','CA','91355','(805) 555-0584','Potter','Lance',3,400);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (100,'Cahners Publishing Company','Citibank Lock Box 4026','8725 W Sahara Zone 1127','The Lake','NV','89163','(301) 555-2162','Jacobsen','Samuel',4,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (101,'California Business Machines','Gallery Plz','5091 N Fresno','Fresno','CA','93710','(559) 555-5570','Rohansen','Anders',2,170);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (102,'Coffee Break Service','PO Box 1091','NULL','Fresno','CA','93714','(559) 555-8700','Smitzen','Jeffrey',4,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (103,'Dean Witter Reynolds','9 River Pk Pl E 400','NULL','Boston','MA','02134','(508) 555-8737','Johnson','Vance',5,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (104,'Digital Dreamworks','5070 N Sixth Ste. 71','NULL','Fresno','CA','93711','NULL','Elmert','Ron',3,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (105,'Dristas Groom & McCormick','7112 N Fresno St Ste 200','NULL','Fresno','CA','93720','(559) 555-8484','Aaronsen','Thom',3,591);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (106,'Ford Motor Credit Company','Dept 0419','NULL','Los Angeles','CA','90084','(800) 555-7000','Snyder','Karen',3,582);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (107,'Franchise Tax Board','PO Box 942857','NULL','Sacramento','CA','94257','NULL','Prado','Anita',4,507);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (108,'Gostanian General Building','427 W Bedford #102','NULL','Fresno','CA','93711','(559) 555-5100','Bragg','Walter',4,523);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (109,'Kent H Landsberg Co','File No 72686','PO Box 61000','San Francisco','CA','94160','(916) 555-8100','Stevens','Wendy',3,540);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (110,'Malloy Lithographing Inc','5411 Jackson Road','PO Box 1124','Ann Arbor','MI','48106','(313) 555-6113','Regging','Abe',3,400);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (111,'Net Asset, Llc','1315 Van Ness Ave Ste. 103','NULL','Fresno','CA','93721','NULL','Kraggin','Laura',1,572);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (112,'Office Depot','File No 81901','NULL','Los Angeles','CA','90074','(800) 555-1711','Pinsippi','Val',3,570);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (113,'Pollstar','4697 W Jacquelyn Ave','NULL','Fresno','CA','93722','(559) 555-2631','Aranovitch','Robert',5,520);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (114,'Postmaster','Postage Due Technician','1900 E Street','Fresno','CA','93706','(559) 555-7785','Finklestein','Fyodor',1,552);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (115,'Roadway Package System, Inc','Dept La 21095','NULL','Pasadena','CA','91185','NULL','Smith','Sam',4,553);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (116,'State of California','Employment Development Dept','PO Box 826276','Sacramento','CA','94230','(209) 555-5132','Articunia','Mercedez',1,631);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (117,'Suburban Propane','2874 S Cherry Ave','NULL','Fresno','CA','93706','(559) 555-2770','Spivak','Harold',3,521);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (118,'Unocal','P.O. Box 860070','NULL','Pasadena','CA','91186','(415) 555-7600','Bluzinski','Rachael',3,582);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (119,'Yesmed, Inc','PO Box 2061','NULL','Fresno','CA','93718','(559) 555-0600','Hernandez','Reba',2,589);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (120,'Dataforms/West','1617 W. Shaw Avenue','Suite F','Fresno','CA','93711','NULL','Church','Charlie',3,551);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (121,'Zylka Design','3467 W Shaw Ave #103','NULL','Fresno','CA','93711','(559) 555-8625','Ronaldsen','Jaime',3,403);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (122,'United Parcel Service','P.O. Box 505820','NULL','Reno','NV','88905','(800) 555-0855','Beauregard','Violet',3,553);
INSERT INTO vendors 
(vendor_id,vendor_name,vendor_address1,vendor_address2,vendor_city,vendor_state,vendor_zip_code,vendor_phone,vendor_contact_last_name,vendor_contact_first_name,default_terms_id,default_account_number) 
VALUES (123,'Federal Express Corporation','P.O. Box 1140','Dept A','Memphis','TN','38101','(800) 555-4091','Bucket','Charlie',3,553);

-- INSERT INTO vendor_contacts 
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(5,'Davison','Michelle');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(12,'Mayteh','Kendall');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(17,'Onandonga','Bruce');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(44,'Antavius','Anthony');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(76,'Bradlee','Danny');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(94,'Suscipe','Reynaldo');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(101,'O''Sullivan','Geraldine');
INSERT INTO vendor_contacts (vendor_id,last_name,first_name) VALUES 
(123,'Bucket','Charles');

-- INSERT INTO invoices 
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(1,34,'QP58872',TO_DATE('25-FEB-14','DD-MON-RR'),116.54,116.54,0,4,TO_DATE('22-APR-14','DD-MON-RR'),TO_DATE('11-APR-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(2,34,'Q545443',TO_DATE('14-MAR-14','DD-MON-RR'),1083.58,1083.58,0,4,TO_DATE('23-MAY-14','DD-MON-RR'),TO_DATE('14-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(3,110,'P-0608',TO_DATE('11-APR-14','DD-MON-RR'),20551.18,0,1200,5,TO_DATE('30-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(4,110,'P-0259',TO_DATE('16-APR-14','DD-MON-RR'),26881.4,26881.4,0,3,TO_DATE('16-MAY-14','DD-MON-RR'),TO_DATE('12-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(5,81,'MABO1489',TO_DATE('16-APR-14','DD-MON-RR'),936.93,936.93,0,3,TO_DATE('16-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(6,122,'989319-497',TO_DATE('17-APR-14','DD-MON-RR'),2312.2,0,0,4,TO_DATE('26-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(7,82,'C73-24',TO_DATE('17-APR-14','DD-MON-RR'),600,600,0,2,TO_DATE('10-MAY-14','DD-MON-RR'),TO_DATE('05-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(8,122,'989319-487',TO_DATE('18-APR-14','DD-MON-RR'),1927.54,0,0,4,TO_DATE('19-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(9,122,'989319-477',TO_DATE('19-APR-14','DD-MON-RR'),2184.11,2184.11,0,4,TO_DATE('12-JUN-14','DD-MON-RR'),TO_DATE('07-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(10,122,'989319-467',TO_DATE('24-APR-14','DD-MON-RR'),2318.03,2318.03,0,4,TO_DATE('05-JUN-14','DD-MON-RR'),TO_DATE('29-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(11,122,'989319-457',TO_DATE('24-APR-14','DD-MON-RR'),3813.33,3813.33,0,3,TO_DATE('29-MAY-14','DD-MON-RR'),TO_DATE('20-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(12,122,'989319-447',TO_DATE('24-APR-14','DD-MON-RR'),3689.99,3689.99,0,3,TO_DATE('22-MAY-14','DD-MON-RR'),TO_DATE('12-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(13,122,'989319-437',TO_DATE('24-APR-14','DD-MON-RR'),2765.36,2765.36,0,2,TO_DATE('15-MAY-14','DD-MON-RR'),TO_DATE('03-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(14,122,'989319-427',TO_DATE('25-APR-14','DD-MON-RR'),2115.81,2115.81,0,1,TO_DATE('08-MAY-14','DD-MON-RR'),TO_DATE('01-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(15,121,'97/553B',TO_DATE('26-APR-14','DD-MON-RR'),313.55,0,0,4,TO_DATE('09-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(16,122,'989319-417',TO_DATE('26-APR-14','DD-MON-RR'),2051.59,2051.59,0,1,TO_DATE('01-MAY-14','DD-MON-RR'),TO_DATE('28-APR-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(17,90,'97-1024A',TO_DATE('26-APR-14','DD-MON-RR'),356.48,356.48,0,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(18,121,'97/553',TO_DATE('27-APR-14','DD-MON-RR'),904.14,0,0,4,TO_DATE('09-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(19,121,'97/522',TO_DATE('30-APR-14','DD-MON-RR'),1962.13,0,200,4,TO_DATE('10-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(20,121,'97/503',TO_DATE('30-APR-14','DD-MON-RR'),639.77,639.77,0,4,TO_DATE('11-JUN-14','DD-MON-RR'),TO_DATE('05-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(21,121,'97/488',TO_DATE('30-APR-14','DD-MON-RR'),601.95,601.95,0,3,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(22,121,'97/486',TO_DATE('30-APR-14','DD-MON-RR'),953.1,953.1,0,2,TO_DATE('21-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(23,121,'97/465',TO_DATE('01-MAY-14','DD-MON-RR'),565.15,565.15,0,1,TO_DATE('14-MAY-14','DD-MON-RR'),TO_DATE('05-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(24,121,'97/222',TO_DATE('01-MAY-14','DD-MON-RR'),1000.46,1000.46,0,3,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('25-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(25,123,'4-342-8069',TO_DATE('01-MAY-14','DD-MON-RR'),10,10,0,4,TO_DATE('10-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(26,123,'4-327-7357',TO_DATE('01-MAY-14','DD-MON-RR'),162.75,162.75,0,3,TO_DATE('27-MAY-14','DD-MON-RR'),TO_DATE('21-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(27,123,'4-321-2596',TO_DATE('01-MAY-14','DD-MON-RR'),10,10,0,2,TO_DATE('20-MAY-14','DD-MON-RR'),TO_DATE('11-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(28,123,'7548906-20',TO_DATE('01-MAY-14','DD-MON-RR'),27,27,0,3,TO_DATE('06-JUN-14','DD-MON-RR'),TO_DATE('26-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(29,123,'4-314-3057',TO_DATE('02-MAY-14','DD-MON-RR'),13.75,13.75,0,1,TO_DATE('13-MAY-14','DD-MON-RR'),TO_DATE('07-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(30,94,'203339-13',TO_DATE('02-MAY-14','DD-MON-RR'),17.5,0,0,3,TO_DATE('13-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(31,123,'2-000-2993',TO_DATE('03-MAY-14','DD-MON-RR'),144.7,144.7,0,1,TO_DATE('06-MAY-14','DD-MON-RR'),TO_DATE('04-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(32,89,'125520-1',TO_DATE('05-MAY-14','DD-MON-RR'),95,95,0,3,TO_DATE('08-JUN-14','DD-MON-RR'),TO_DATE('22-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(33,123,'1-202-2978',TO_DATE('06-MAY-14','DD-MON-RR'),33,33,0,1,TO_DATE('20-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(34,110,'0-2436',TO_DATE('07-MAY-14','DD-MON-RR'),10976.06,0,0,4,TO_DATE('17-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(35,123,'1-200-5164',TO_DATE('07-MAY-14','DD-MON-RR'),63.4,63.4,0,1,TO_DATE('13-MAY-14','DD-MON-RR'),TO_DATE('10-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(36,110,'0-2060',TO_DATE('08-MAY-14','DD-MON-RR'),23517.58,21221.63,2295.95,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('10-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(37,110,'0-2058',TO_DATE('08-MAY-14','DD-MON-RR'),37966.19,37966.19,0,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('31-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(38,123,'963253272',TO_DATE('09-MAY-14','DD-MON-RR'),61.5,0,0,4,TO_DATE('29-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(39,123,'963253271',TO_DATE('09-MAY-14','DD-MON-RR'),158,0,0,4,TO_DATE('28-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(40,123,'963253269',TO_DATE('09-MAY-14','DD-MON-RR'),26.75,0,0,4,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(41,123,'963253267',TO_DATE('09-MAY-14','DD-MON-RR'),23.5,0,0,4,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(42,97,'21-4748363',TO_DATE('09-MAY-14','DD-MON-RR'),9.95,0,0,4,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(43,97,'21-4923721',TO_DATE('09-MAY-14','DD-MON-RR'),9.95,9.95,0,1,TO_DATE('21-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(44,123,'963253264',TO_DATE('10-MAY-14','DD-MON-RR'),52.25,0,0,4,TO_DATE('23-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(45,123,'963253263',TO_DATE('10-MAY-14','DD-MON-RR'),109.5,0,0,4,TO_DATE('22-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(46,123,'963253261',TO_DATE('10-MAY-14','DD-MON-RR'),42.75,42.75,0,3,TO_DATE('16-JUN-14','DD-MON-RR'),TO_DATE('10-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(47,123,'963253260',TO_DATE('10-MAY-14','DD-MON-RR'),36,36,0,3,TO_DATE('15-JUN-14','DD-MON-RR'),TO_DATE('06-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(48,123,'963253258',TO_DATE('10-MAY-14','DD-MON-RR'),111,111,0,3,TO_DATE('11-JUN-14','DD-MON-RR'),TO_DATE('31-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(49,123,'963253256',TO_DATE('10-MAY-14','DD-MON-RR'),53.25,53.25,0,3,TO_DATE('10-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(50,123,'963253255',TO_DATE('11-MAY-14','DD-MON-RR'),53.75,53.75,0,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('03-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(51,123,'963253254',TO_DATE('11-MAY-14','DD-MON-RR'),108.5,108.5,0,3,TO_DATE('08-JUN-14','DD-MON-RR'),TO_DATE('30-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(52,123,'963253252',TO_DATE('11-MAY-14','DD-MON-RR'),38.75,38.75,0,3,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(53,123,'963253251',TO_DATE('11-MAY-14','DD-MON-RR'),15.5,15.5,0,3,TO_DATE('04-JUN-14','DD-MON-RR'),TO_DATE('21-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(54,123,'963253249',TO_DATE('12-MAY-14','DD-MON-RR'),127.75,127.75,0,2,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(55,123,'963253248',TO_DATE('13-MAY-14','DD-MON-RR'),241,241,0,2,TO_DATE('02-JUN-14','DD-MON-RR'),TO_DATE('24-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(56,123,'963253246',TO_DATE('13-MAY-14','DD-MON-RR'),129,129,0,2,TO_DATE('31-MAY-14','DD-MON-RR'),TO_DATE('20-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(57,123,'963253245',TO_DATE('13-MAY-14','DD-MON-RR'),40.75,40.75,0,2,TO_DATE('28-MAY-14','DD-MON-RR'),TO_DATE('14-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(58,123,'963253244',TO_DATE('13-MAY-14','DD-MON-RR'),60,60,0,2,TO_DATE('27-MAY-14','DD-MON-RR'),TO_DATE('21-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(59,123,'963253242',TO_DATE('13-MAY-14','DD-MON-RR'),104,104,0,2,TO_DATE('26-MAY-14','DD-MON-RR'),TO_DATE('17-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(60,123,'963253240',TO_DATE('23-MAY-14','DD-MON-RR'),67,67,0,1,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(61,123,'963253239',TO_DATE('23-MAY-14','DD-MON-RR'),147.25,147.25,0,1,TO_DATE('02-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(62,123,'963253237',TO_DATE('23-MAY-14','DD-MON-RR'),172.5,172.5,0,1,TO_DATE('30-MAY-14','DD-MON-RR'),TO_DATE('24-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(63,123,'963253235',TO_DATE('14-MAY-14','DD-MON-RR'),108.25,108.25,0,1,TO_DATE('20-MAY-14','DD-MON-RR'),TO_DATE('17-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(64,123,'963253234',TO_DATE('14-MAY-14','DD-MON-RR'),138.75,138.75,0,1,TO_DATE('19-MAY-14','DD-MON-RR'),TO_DATE('16-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(65,123,'963253232',TO_DATE('14-MAY-14','DD-MON-RR'),127.75,127.75,0,1,TO_DATE('18-MAY-14','DD-MON-RR'),TO_DATE('16-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(66,123,'963253230',TO_DATE('15-MAY-14','DD-MON-RR'),739.2,739.2,0,1,TO_DATE('17-MAY-14','DD-MON-RR'),TO_DATE('16-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(67,123,'43966316',TO_DATE('17-MAY-14','DD-MON-RR'),10,0,0,3,TO_DATE('19-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(68,123,'263253273',TO_DATE('17-MAY-14','DD-MON-RR'),30.75,0,0,4,TO_DATE('29-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(69,37,'547479217',TO_DATE('17-MAY-14','DD-MON-RR'),116,0,0,3,TO_DATE('22-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(70,123,'263253270',TO_DATE('18-MAY-14','DD-MON-RR'),67.92,0,0,3,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(71,123,'263253268',TO_DATE('18-MAY-14','DD-MON-RR'),59.97,0,0,3,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(72,123,'263253265',TO_DATE('18-MAY-14','DD-MON-RR'),26.25,0,0,3,TO_DATE('23-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(73,123,'263253257',TO_DATE('18-MAY-14','DD-MON-RR'),22.57,22.57,0,2,TO_DATE('10-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(74,123,'263253253',TO_DATE('18-MAY-14','DD-MON-RR'),31.95,31.95,0,2,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('01-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(75,123,'263253250',TO_DATE('19-MAY-14','DD-MON-RR'),42.67,42.67,0,2,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('25-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(76,123,'263253243',TO_DATE('20-MAY-14','DD-MON-RR'),44.44,44.44,0,1,TO_DATE('26-MAY-14','DD-MON-RR'),TO_DATE('23-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(77,123,'263253241',TO_DATE('20-MAY-14','DD-MON-RR'),40.2,40.2,0,1,TO_DATE('25-MAY-14','DD-MON-RR'),TO_DATE('22-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(78,123,'94007069',TO_DATE('22-MAY-14','DD-MON-RR'),400,400,0,3,TO_DATE('01-JUL-14','DD-MON-RR'),TO_DATE('25-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(79,123,'963253262',TO_DATE('22-MAY-14','DD-MON-RR'),42.5,0,0,3,TO_DATE('21-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(80,105,'94007005',TO_DATE('23-MAY-14','DD-MON-RR'),220,220,0,1,TO_DATE('30-MAY-14','DD-MON-RR'),TO_DATE('26-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(81,83,'31359783',TO_DATE('23-MAY-14','DD-MON-RR'),1575,0,0,2,TO_DATE('09-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(82,115,'25022117',TO_DATE('24-MAY-14','DD-MON-RR'),6,0,0,3,TO_DATE('21-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(83,115,'24946731',TO_DATE('25-MAY-14','DD-MON-RR'),25.67,25.67,0,2,TO_DATE('14-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(84,115,'24863706',TO_DATE('27-MAY-14','DD-MON-RR'),6,6,0,1,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('01-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(85,115,'24780512',TO_DATE('29-MAY-14','DD-MON-RR'),6,6,0,1,TO_DATE('31-MAY-14','DD-MON-RR'),TO_DATE('30-MAY-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(86,88,'972110',TO_DATE('30-MAY-14','DD-MON-RR'),207.78,207.78,0,1,TO_DATE('06-JUN-14','DD-MON-RR'),TO_DATE('02-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(87,100,'587056',TO_DATE('31-MAY-14','DD-MON-RR'),2184.5,2184.5,0,3,TO_DATE('28-JUN-14','DD-MON-RR'),TO_DATE('22-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(88,86,'367447',TO_DATE('31-MAY-14','DD-MON-RR'),2433,0,0,3,TO_DATE('30-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(89,99,'509786',TO_DATE('31-MAY-14','DD-MON-RR'),6940.25,6940.25,0,2,TO_DATE('16-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(90,108,'121897',TO_DATE('01-JUN-14','DD-MON-RR'),450,450,0,2,TO_DATE('19-JUN-14','DD-MON-RR'),TO_DATE('14-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(91,80,'134116',TO_DATE('01-JUN-14','DD-MON-RR'),90.36,0,0,3,TO_DATE('02-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(92,80,'133560',TO_DATE('01-JUN-14','DD-MON-RR'),175,175,0,2,TO_DATE('20-JUN-14','DD-MON-RR'),TO_DATE('03-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(93,104,'P02-3772',TO_DATE('03-JUN-14','DD-MON-RR'),7125.34,7125.34,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(94,106,'9982771',TO_DATE('03-JUN-14','DD-MON-RR'),503.2,0,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(95,107,'RTR-72-3662-X',TO_DATE('04-JUN-14','DD-MON-RR'),1600,1600,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('11-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(96,113,'77290',TO_DATE('04-JUN-14','DD-MON-RR'),1750,1750,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(97,119,'10843',TO_DATE('04-JUN-14','DD-MON-RR'),4901.26,4901.26,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('11-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(98,95,'111-92R-10092',TO_DATE('04-JUN-14','DD-MON-RR'),46.21,0,0,1,TO_DATE('29-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(99,95,'111-92R-10093',TO_DATE('05-JUN-14','DD-MON-RR'),39.77,0,0,2,TO_DATE('28-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(100,96,'I77271-O01',TO_DATE('05-JUN-14','DD-MON-RR'),662,0,0,2,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(101,103,'75C-90227',TO_DATE('06-JUN-14','DD-MON-RR'),1367.5,1367.5,0,1,TO_DATE('13-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(102,48,'P02-88D77S7',TO_DATE('06-JUN-14','DD-MON-RR'),856.92,856.92,0,1,TO_DATE('13-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(103,95,'111-92R-10094',TO_DATE('06-JUN-14','DD-MON-RR'),19.67,0,0,1,TO_DATE('27-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(104,114,'CBM9920-M-T77109',TO_DATE('07-JUN-14','DD-MON-RR'),290,290,0,1,TO_DATE('12-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(105,95,'111-92R-10095',TO_DATE('07-JUN-14','DD-MON-RR'),32.7,0,0,3,TO_DATE('26-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(106,95,'111-92R-10096',TO_DATE('08-JUN-14','DD-MON-RR'),16.33,0,0,2,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(107,95,'111-92R-10097',TO_DATE('08-JUN-14','DD-MON-RR'),16.33,0,0,1,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(108,117,'111897',TO_DATE('11-JUN-14','DD-MON-RR'),16.62,16.62,0,1,TO_DATE('14-JUN-14','DD-MON-RR'),TO_DATE('12-JUN-14','DD-MON-RR'));
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(109,102,'109596',TO_DATE('14-JUN-14','DD-MON-RR'),41.8,0,0,3,TO_DATE('11-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(110,72,'39104',TO_DATE('20-JUN-14','DD-MON-RR'),85.31,0,0,3,TO_DATE('20-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(111,37,'547480102',TO_DATE('19-MAY-14','DD-MON-RR'),224,0,0,3,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(112,37,'547481328',TO_DATE('20-MAY-14','DD-MON-RR'),224,0,0,3,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(113,72,'40318',TO_DATE('18-JUL-14','DD-MON-RR'),21842,0,0,3,TO_DATE('20-JUL-14','DD-MON-RR'),null);
INSERT INTO invoices 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(114,83,'31361833',TO_DATE('23-MAY-14','DD-MON-RR'),579.42,0,0,2,TO_DATE('09-JUN-14','DD-MON-RR'),null);

-- INSERTING into INVOICE_LINE_ITEMS
INSERT INTO invoice_line_items 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (1,1,572,116.54,'MVS Online Library');
INSERT INTO invoice_line_items 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (2,1,572,1083.58,'MSDN');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (3,1,120,20551.18,'CICS Part 2');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (4,1,120,26881.4,'MVS JCL');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (5,1,527,936.93,'Quarterly Maintenance');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (6,1,553,2312.2,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (7,1,541,600,'Trade advertising');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (8,1,553,1927.54,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (9,1,553,2184.11,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (10,1,553,2318.03,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (11,1,553,3813.33,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (12,1,553,3689.99,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (13,1,553,2765.36,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (14,1,553,2115.81,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (15,1,540,313.55,'Card revision');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (16,1,553,2051.59,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (17,1,523,356.48,'Network wiring');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (18,1,540,904.14,'DB2 Card decks');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (19,1,536,1197,'MC Bouncebacks');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (19,2,540,765.13,'SCMD Flyer');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (20,1,536,639.77,'Card deck');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (21,1,536,601.95,'Card deck revision');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (22,1,536,953.1,'Crash Course revision');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (23,1,541,565.15,'Crash Course Ad');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (24,1,540,1000.46,'Crash Course Cover');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (25,1,553,10,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (26,1,553,162.75,'International shipment');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (27,1,553,10,'Address correction');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (28,1,553,27,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (29,1,553,13.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (30,1,570,17.5,'Supplies');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (31,1,553,144.7,'Int''l shipment');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (32,1,523,95,'Telephone service');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (33,1,553,33,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (34,1,120,10976.06,'VSAM for the Cobol Programmer');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (35,1,553,63.4,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (36,1,120,23517.58,'DB2 Part 1');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (37,1,120,37966.19,'CICS Desk Reference');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (38,1,553,61.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (39,1,553,158,'Int''l shipment');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (40,1,553,26.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (41,1,553,23.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (42,1,572,9.95,'Monthly access fee');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (43,1,572,9.95,'Monthly access fee');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (44,1,553,52.25,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (45,1,553,109.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (46,1,553,42.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (47,1,553,36,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (48,1,553,111,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (49,1,553,53.25,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (50,1,553,53.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (51,1,553,108.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (52,1,553,38.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (53,1,553,15.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (54,1,553,127.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (55,1,553,241,'Int''l shipment');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (56,1,553,129,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (57,1,553,40.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (58,1,553,60,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (59,1,553,104,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (60,1,553,67,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (61,1,553,147.25,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (62,1,553,172.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (63,1,553,108.25,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (64,1,553,138.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (65,1,553,127.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (66,1,553,739.2,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (67,1,553,10,'Address correction');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (68,1,553,30.75,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (69,1,510,116,'Health Insurance');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (70,1,553,67.92,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (71,1,553,59.97,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (72,1,553,26.25,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (73,1,553,22.57,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (74,1,553,31.95,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (75,1,553,42.67,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (76,1,553,44.44,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (77,1,553,40.2,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (78,1,553,400,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (79,1,553,42.5,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (80,1,591,220,'Form 571-L');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (81,1,541,1575,'Catalog ad');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (82,1,553,6,'Freight out');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (83,1,553,25.67,'Freight out');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (84,1,552,6,'Freight out');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (85,1,553,6,'Freight');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (86,1,540,207.78,'Prospect list');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (87,1,536,2184.5,'PC card deck');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (88,1,536,2433,'Card deck');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (89,1,120,6940.25,'OS Utilities');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (90,1,523,450,'Back office additions');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (91,1,536,90.36,'Card deck advertising');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (92,1,536,175,'Card deck advertising');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (93,1,548,7125.34,'Web site design');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (94,1,569,503.2,'Bronco lease');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (95,1,235,1600,'Income Tax');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (96,1,520,1750,'Warehouse lease');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (97,1,520,4901.26,'Office lease');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (98,1,522,46.21,'Telephone (Line 1)');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (99,1,522,39.77,'Telephone (Line 2)');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (100,1,580,50,'DiCicco''s');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (100,2,540,75.6,'Kinko''s');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (100,3,570,58.4,'Office Max');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (100,4,546,478,'Publishers Marketing');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (101,1,221,1367.5,'401K Contributions');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (102,1,574,856.92,'Property Taxes');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (103,1,522,19.67,'Telephone (Line 3)');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (104,1,552,290,'International pkg.');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (105,1,522,32.7,'Telephone (line 4)');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (106,1,522,16.33,'Telephone (line 5)');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (107,1,522,16.33,'Telephone (line 6)');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (108,1,589,16.62,'Propane-forklift');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (109,1,580,41.8,'Coffee');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (110,1,540,85.31,'Book copy');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (111,1,510,224,'Health Insurance');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (112,1,510,224,'Health Insurance');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (113,1,540,21842,'Book repro');
Insert into INVOICE_LINE_ITEMS 
(invoice_id,invoice_sequence,account_number,line_item_amt,line_item_description) 
VALUES (114,1,541,579.42,'Catalog ad');

COMMIT;