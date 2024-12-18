--CONNECT ex/ex;

SET DEFINE OFF;

-- Begin an anonymous PL/SQL script that 
-- drops all tables in the EX schema and
-- suppresses the error messages that are displayed if the tables don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE active_invoices';
  EXECUTE IMMEDIATE 'DROP TABLE color_sample';
  EXECUTE IMMEDIATE 'DROP TABLE customers_ex';
  EXECUTE IMMEDIATE 'DROP TABLE date_sample';
  EXECUTE IMMEDIATE 'DROP TABLE departments_ex';
  EXECUTE IMMEDIATE 'DROP TABLE employees';
  EXECUTE IMMEDIATE 'DROP TABLE float_sample';
  EXECUTE IMMEDIATE 'DROP TABLE null_sample';
  EXECUTE IMMEDIATE 'DROP TABLE paid_invoices';
  EXECUTE IMMEDIATE 'DROP TABLE projects';
  EXECUTE IMMEDIATE 'DROP TABLE string_sample';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

CREATE TABLE active_invoices
(
  invoice_id        NUMBER        NOT NULL,
  vendor_id         NUMBER        NOT NULL,
  invoice_number    VARCHAR2(50)  NOT NULL,
  invoice_date      DATE          NOT NULL,
  invoice_total     NUMBER(9,2)   NOT NULL,
  payment_total     NUMBER(9,2)   NOT NULL,
  credit_total      NUMBER(9,2)   NOT NULL,
  terms_id          NUMBER        NOT NULL,
  invoice_due_date  DATE          NOT NULL,
  payment_date      DATE
);

CREATE TABLE color_sample
(
  color_id      NUMBER                        NOT NULL,
  color_number  NUMBER            DEFAULT 0   NOT NULL,
  color_name    VARCHAR2(10)
);


CREATE TABLE customers_ex
(
  customer_id          NUMBER            NOT NULL,
  customer_last_name   VARCHAR2(30),
  customer_first_name  VARCHAR2(30),
  customer_address     VARCHAR2(60),
  customer_city        VARCHAR2(15),
  customer_state       VARCHAR2(15),
  customer_zip         VARCHAR2(10),
  customer_phone       VARCHAR2(24)
);


CREATE TABLE date_sample
(
  date_id       NUMBER   NOT NULL,
  start_date    DATE
);

CREATE TABLE departments_ex
(
  department_number   NUMBER        NOT NULL,
  department_name     VARCHAR2(50)  NOT NULL,
  CONSTRAINT department_number_unq  
    UNIQUE (department_number)
);

CREATE TABLE employees
(
  employee_id         NUMBER            NOT NULL,
  last_name           VARCHAR2 (35)     NOT NULL,
  first_name          VARCHAR2 (35)     NOT NULL,
  department_number   NUMBER            NOT NULL,
  manager_id          NUMBER
);

CREATE TABLE float_sample
(
  float_id       NUMBER,
  float_value    BINARY_DOUBLE
);

CREATE TABLE null_sample
(
  invoice_id      NUMBER            NOT NULL,
  invoice_total   NUMBER(9,2),
  CONSTRAINT invoice_id_unq 
    UNIQUE (invoice_id)
);

CREATE TABLE paid_invoices
(
  invoice_id            NUMBER          NOT NULL,
  vendor_id             NUMBER          NOT NULL,
  invoice_number        VARCHAR2(50)    NOT NULL,
  invoice_date          DATE            NOT NULL,
  invoice_total         NUMBER(9,2)     NOT NULL,
  payment_total         NUMBER(9,2)     NOT NULL,
  credit_total          NUMBER(9,2)     NOT NULL,
  terms_id              NUMBER          NOT NULL,
  invoice_due_date      DATE            NOT NULL,
  payment_date          DATE
);

CREATE TABLE projects
(
  project_number    VARCHAR2(5)   NOT NULL,
  employee_id       NUMBER        NOT NULL
);

CREATE TABLE string_sample
(
  id        VARCHAR2(3),
  name      VARCHAR2(25)
);

-- INSERT INTO active_invoices

INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(3,110,'P-0608',TO_DATE('11-APR-14','DD-MON-RR'),20551.18,0,1200,5,TO_DATE('30-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(6,122,'989319-497',TO_DATE('17-APR-14','DD-MON-RR'),2312.2,0,0,4,TO_DATE('26-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(8,122,'989319-487',TO_DATE('18-APR-14','DD-MON-RR'),1927.54,0,0,4,TO_DATE('19-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(15,121,'97/553B',TO_DATE('26-APR-14','DD-MON-RR'),313.55,0,0,4,TO_DATE('09-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(18,121,'97/553',TO_DATE('27-APR-14','DD-MON-RR'),904.14,0,0,4,TO_DATE('09-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(19,121,'97/522',TO_DATE('30-APR-14','DD-MON-RR'),1962.13,0,200,4,TO_DATE('10-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(30,94,'203339-13',TO_DATE('02-MAY-14','DD-MON-RR'),17.5,0,0,3,TO_DATE('13-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(34,110,'0-2436',TO_DATE('07-MAY-14','DD-MON-RR'),10976.06,0,0,4,TO_DATE('17-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(38,123,'963253272',TO_DATE('09-MAY-14','DD-MON-RR'),61.5,0,0,4,TO_DATE('29-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(39,123,'963253271',TO_DATE('09-MAY-14','DD-MON-RR'),158,0,0,4,TO_DATE('28-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(40,123,'963253269',TO_DATE('09-MAY-14','DD-MON-RR'),26.75,0,0,4,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(41,123,'963253267',TO_DATE('09-MAY-14','DD-MON-RR'),23.5,0,0,4,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(42,97,'21-4748363',TO_DATE('09-MAY-14','DD-MON-RR'),9.95,0,0,4,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(44,123,'963253264',TO_DATE('10-MAY-14','DD-MON-RR'),52.25,0,0,4,TO_DATE('23-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(45,123,'963253263',TO_DATE('10-MAY-14','DD-MON-RR'),109.5,0,0,4,TO_DATE('22-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(67,123,'43966316',TO_DATE('17-MAY-14','DD-MON-RR'),10,0,0,3,TO_DATE('19-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(68,123,'263253273',TO_DATE('17-MAY-14','DD-MON-RR'),30.75,0,0,4,TO_DATE('29-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(69,37,'547479217',TO_DATE('17-MAY-14','DD-MON-RR'),116,0,0,3,TO_DATE('22-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(70,123,'263253270',TO_DATE('18-MAY-14','DD-MON-RR'),67.92,0,0,3,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(71,123,'263253268',TO_DATE('18-MAY-14','DD-MON-RR'),59.97,0,0,3,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(72,123,'263253265',TO_DATE('18-MAY-14','DD-MON-RR'),26.25,0,0,3,TO_DATE('23-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(79,123,'963253262',TO_DATE('22-MAY-14','DD-MON-RR'),42.5,0,0,3,TO_DATE('21-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(81,83,'31359783',TO_DATE('23-MAY-14','DD-MON-RR'),1575,0,0,2,TO_DATE('09-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(82,115,'25022117',TO_DATE('24-MAY-14','DD-MON-RR'),6,0,0,3,TO_DATE('21-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(88,86,'367447',TO_DATE('31-MAY-14','DD-MON-RR'),2433,0,0,3,TO_DATE('30-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(91,80,'134116',TO_DATE('01-JUN-14','DD-MON-RR'),90.36,0,0,3,TO_DATE('02-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(94,106,'9982771',TO_DATE('03-JUN-14','DD-MON-RR'),503.2,0,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(98,95,'111-92R-10092',TO_DATE('04-JUN-14','DD-MON-RR'),46.21,0,0,1,TO_DATE('29-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(99,95,'111-92R-10093',TO_DATE('05-JUN-14','DD-MON-RR'),39.77,0,0,2,TO_DATE('28-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(100,96,'I77271-O01',TO_DATE('05-JUN-14','DD-MON-RR'),662,0,0,2,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(103,95,'111-92R-10094',TO_DATE('06-JUN-14','DD-MON-RR'),19.67,0,0,1,TO_DATE('27-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(105,95,'111-92R-10095',TO_DATE('07-JUN-14','DD-MON-RR'),32.7,0,0,3,TO_DATE('26-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(106,95,'111-92R-10096',TO_DATE('08-JUN-14','DD-MON-RR'),16.33,0,0,2,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(107,95,'111-92R-10097',TO_DATE('08-JUN-14','DD-MON-RR'),16.33,0,0,1,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(109,102,'109596',TO_DATE('14-JUN-14','DD-MON-RR'),41.8,0,0,3,TO_DATE('11-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(110,72,'39104',TO_DATE('20-JUN-14','DD-MON-RR'),85.31,0,0,3,TO_DATE('20-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(111,37,'547480102',TO_DATE('19-MAY-14','DD-MON-RR'),224,0,0,3,TO_DATE('24-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(112,37,'547481328',TO_DATE('20-MAY-14','DD-MON-RR'),224,0,0,3,TO_DATE('25-JUN-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(113,72,'40318',TO_DATE('18-JUL-14','DD-MON-RR'),21842,0,0,3,TO_DATE('20-JUL-14','DD-MON-RR'),null);
INSERT INTO active_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(114,83,'31361833',TO_DATE('23-MAY-14','DD-MON-RR'),579.42,0,0,2,TO_DATE('09-JUN-14','DD-MON-RR'),null);


-- INSERT INTO customers_ex

INSERT INTO customers_ex VALUES (1, 'Anders', 'Maria', '345 Winchell Pl', 'Anderson', 'IN', '46014', '(765) 555-7878');
INSERT INTO customers_ex VALUES (2, 'Trujillo', 'Ana', '1298 E Smathers St', 'Benton', 'AR', '72018', '(501) 555-7733');
INSERT INTO customers_ex VALUES (3, 'Moreno', 'Antonio', '6925 N Parkland Ave', 'Puyallup', 'WA', '98373', '(253) 555-8332');
INSERT INTO customers_ex VALUES (4, 'Hardy', 'Thomas', '83 d''Urberville Ln', 'Casterbridge', 'GA', '31209', '(478) 555-1139');
INSERT INTO customers_ex VALUES (5, 'Berglund', 'Christina', '22717 E 73rd Ave', 'Dubuque', 'IA', '52004', '(319) 555-1139');
INSERT INTO customers_ex VALUES (6, 'Moos', 'Hanna', '1778 N Bovine Ave', 'Peoria', 'IL', '61638', '(309) 555-8755');
INSERT INTO customers_ex VALUES (7, 'Citeaux', 'Fred', '1234 Main St', 'Normal', 'IL', '61761', '(309) 555-1914');
INSERT INTO customers_ex VALUES (8, 'Summer', 'Martin', '1877 Ete Ct', 'Frogtown', 'LA', '70563', '(337) 555-9441');
INSERT INTO customers_ex VALUES (9, 'Lebihan', 'Laurence', '717 E Michigan Ave', 'Chicago', 'IL', '60611', '(312) 555-9441');
INSERT INTO customers_ex VALUES (10, 'Lincoln', 'Elizabeth', '4562 Rt 78 E', 'Vancouver', 'WA', '98684', '(360) 555-2680');
INSERT INTO customers_ex VALUES (11, 'Snyder', 'Howard', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', '(503) 555-7555');
INSERT INTO customers_ex VALUES (12, 'Latimer', 'Yoshi', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', '(503) 555-6874');
INSERT INTO customers_ex VALUES (13, 'Steel', 'John', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', '(509) 555-7969');
INSERT INTO customers_ex VALUES (14, 'Yorres', 'Jaime', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', '(415) 555-5938');
INSERT INTO customers_ex VALUES (15, 'Wilson', 'Fran', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', '(503) 555-9573');
INSERT INTO customers_ex VALUES (16, 'Phillips', 'Rene', '2743 Bering St.', 'Anchorage', 'AK', '99508', '(907) 555-7584');
INSERT INTO customers_ex VALUES (17, 'Wilson', 'Paula', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', '(505) 555-5939');
INSERT INTO customers_ex VALUES (18, 'Pavarotti', 'Jose', '187 Suffolk Ln.', 'Boise', 'ID', '83720', '(208) 555-8097');
INSERT INTO customers_ex VALUES (19, 'Braunschweiger', 'Art', 'P.O. Box 555', 'Lander', 'WY', '82520', '(307) 555-4680');
INSERT INTO customers_ex VALUES (20, 'Nixon', 'Liz', '89 Jefferson Way Suite 2', 'Providence', 'RI', '02909', '(401) 555-3612');
INSERT INTO customers_ex VALUES (21, 'Wong', 'Liu', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', '(406) 555-5834');
INSERT INTO customers_ex VALUES (22, 'Nagy', 'Helvetius', '722 DaVinci Blvd.', 'Concord', 'MA', '01742', '(351) 555-1219');
INSERT INTO customers_ex VALUES (23, 'Jablonski', 'Karl', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', '(206) 555-4112');
INSERT INTO customers_ex VALUES (24, 'Chelan', 'Donna', '2299 E Baylor Dr', 'Dallas', 'TX', '75224', '(469) 555-8828');

-- INSERT INTO date_sample

INSERT INTO date_sample VALUES (1, TO_DATE('1979-03-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO date_sample VALUES (2, TO_DATE('1999-02-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO date_sample VALUES (3, TO_DATE('2003-10-31 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO date_sample VALUES (4, TO_DATE('2005-02-28 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO date_sample VALUES (5, TO_DATE('2006-02-28 13:58:32', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO date_sample VALUES (6, TO_DATE('2006-03-01 09:02:25', 'YYYY-MM-DD HH24:MI:SS'));

-- INSERT INTO departments_ex 

INSERT INTO departments_ex (department_number,department_name) VALUES
(1,'Accounting');
INSERT INTO departments_ex (department_number,department_name) VALUES
(2,'Payroll');
INSERT INTO departments_ex (department_number,department_name) VALUES
(3,'Operations');
INSERT INTO departments_ex (department_number,department_name) VALUES
(4,'Personnel');
INSERT INTO departments_ex (department_number,department_name) VALUES
(5,'Maintenance');

-- INSERT INTO employees

INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(1,'Smith','Cindy',2,null);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(2,'Jones','Elmer',4,1);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(3,'Simonian','Ralph',2,2);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(4,'Hernandez','Olivia',1,9);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(5,'Aaronsen','Robert',2,4);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(6,'Watson','Denise',6,8);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(7,'Hardy','Thomas',5,2);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(8,'O''Leary','Rhea',4,9);
INSERT INTO employees
(employee_id,last_name,first_name,department_number,manager_id) VALUES
(9,'Locario','Paulo',6,1);

-- INSERT INTO float_sample 

INSERT INTO float_sample VALUES (1, 0.999999999999999);
INSERT INTO float_sample VALUES (2, 1);
INSERT INTO float_sample VALUES (3, 1.000000000000001);
INSERT INTO float_sample VALUES (4, 1234.56789012345);
INSERT INTO float_sample VALUES (5, 999.04440209348);
INSERT INTO float_sample VALUES (6, 24.04849);


-- INSERT INTO null_sample 

INSERT INTO null_sample (invoice_id,invoice_total) VALUES (1,125);
INSERT INTO null_sample (invoice_id,invoice_total) VALUES (2,0);
INSERT INTO null_sample (invoice_id,invoice_total) VALUES (3,null);
INSERT INTO null_sample (invoice_id,invoice_total) VALUES (4,2199.99);
INSERT INTO null_sample (invoice_id,invoice_total) VALUES (5,0);

-- INSERT INTO paid_invoices

INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(2,34,'Q545443',TO_DATE('14-MAR-14','DD-MON-RR'),1083.58,1083.58,0,4,TO_DATE('23-MAY-14','DD-MON-RR'),TO_DATE('14-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(4,110,'P-0259',TO_DATE('16-APR-14','DD-MON-RR'),26881.4,26881.4,0,3,TO_DATE('16-MAY-14','DD-MON-RR'),TO_DATE('12-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(5,81,'MABO1489',TO_DATE('16-APR-14','DD-MON-RR'),936.93,936.93,0,3,TO_DATE('16-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(7,82,'C73-24',TO_DATE('17-APR-14','DD-MON-RR'),600,600,0,2,TO_DATE('10-MAY-14','DD-MON-RR'),TO_DATE('05-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(9,122,'989319-477',TO_DATE('19-APR-14','DD-MON-RR'),2184.11,2184.11,0,4,TO_DATE('12-JUN-14','DD-MON-RR'),TO_DATE('07-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(10,122,'989319-467',TO_DATE('24-APR-14','DD-MON-RR'),2318.03,2318.03,0,4,TO_DATE('05-JUN-14','DD-MON-RR'),TO_DATE('29-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(11,122,'989319-457',TO_DATE('24-APR-14','DD-MON-RR'),3813.33,3813.33,0,3,TO_DATE('29-MAY-14','DD-MON-RR'),TO_DATE('20-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(12,122,'989319-447',TO_DATE('24-APR-14','DD-MON-RR'),3689.99,3689.99,0,3,TO_DATE('22-MAY-14','DD-MON-RR'),TO_DATE('12-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(13,122,'989319-437',TO_DATE('24-APR-14','DD-MON-RR'),2765.36,2765.36,0,2,TO_DATE('15-MAY-14','DD-MON-RR'),TO_DATE('03-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(14,122,'989319-427',TO_DATE('25-APR-14','DD-MON-RR'),2115.81,2115.81,0,1,TO_DATE('08-MAY-14','DD-MON-RR'),TO_DATE('01-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(16,122,'989319-417',TO_DATE('26-APR-14','DD-MON-RR'),2051.59,2051.59,0,1,TO_DATE('01-MAY-14','DD-MON-RR'),TO_DATE('28-APR-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(17,90,'97-1024A',TO_DATE('26-APR-14','DD-MON-RR'),356.48,356.48,0,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(20,121,'97/503',TO_DATE('30-APR-14','DD-MON-RR'),639.77,639.77,0,4,TO_DATE('11-JUN-14','DD-MON-RR'),TO_DATE('05-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(21,121,'97/488',TO_DATE('30-APR-14','DD-MON-RR'),601.95,601.95,0,3,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(22,121,'97/486',TO_DATE('30-APR-14','DD-MON-RR'),953.1,953.1,0,2,TO_DATE('21-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(23,121,'97/465',TO_DATE('01-MAY-14','DD-MON-RR'),565.15,565.15,0,1,TO_DATE('14-MAY-14','DD-MON-RR'),TO_DATE('05-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(24,121,'97/222',TO_DATE('01-MAY-14','DD-MON-RR'),1000.46,1000.46,0,3,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('25-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(25,123,'4-342-8069',TO_DATE('01-MAY-14','DD-MON-RR'),10,10,0,4,TO_DATE('10-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(26,123,'4-327-7357',TO_DATE('01-MAY-14','DD-MON-RR'),162.75,162.75,0,3,TO_DATE('27-MAY-14','DD-MON-RR'),TO_DATE('21-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(27,123,'4-321-2596',TO_DATE('01-MAY-14','DD-MON-RR'),10,10,0,2,TO_DATE('20-MAY-14','DD-MON-RR'),TO_DATE('11-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(28,123,'7548906-20',TO_DATE('01-MAY-14','DD-MON-RR'),27,27,0,3,TO_DATE('06-JUN-14','DD-MON-RR'),TO_DATE('26-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(29,123,'4-314-3057',TO_DATE('02-MAY-14','DD-MON-RR'),13.75,13.75,0,1,TO_DATE('13-MAY-14','DD-MON-RR'),TO_DATE('07-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(31,123,'2-000-2993',TO_DATE('03-MAY-14','DD-MON-RR'),144.7,144.7,0,1,TO_DATE('06-MAY-14','DD-MON-RR'),TO_DATE('04-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(32,89,'125520-1',TO_DATE('05-MAY-14','DD-MON-RR'),95,95,0,3,TO_DATE('08-JUN-14','DD-MON-RR'),TO_DATE('22-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(33,123,'1-202-2978',TO_DATE('06-MAY-14','DD-MON-RR'),33,33,0,1,TO_DATE('20-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(35,123,'1-200-5164',TO_DATE('07-MAY-14','DD-MON-RR'),63.4,63.4,0,1,TO_DATE('13-MAY-14','DD-MON-RR'),TO_DATE('10-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(36,110,'0-2060',TO_DATE('08-MAY-14','DD-MON-RR'),23517.58,21221.63,2295.95,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('10-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(37,110,'0-2058',TO_DATE('08-MAY-14','DD-MON-RR'),37966.19,37966.19,0,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('31-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(43,97,'21-4923721',TO_DATE('09-MAY-14','DD-MON-RR'),9.95,9.95,0,1,TO_DATE('21-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(46,123,'963253261',TO_DATE('10-MAY-14','DD-MON-RR'),42.75,42.75,0,3,TO_DATE('16-JUN-14','DD-MON-RR'),TO_DATE('10-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(47,123,'963253260',TO_DATE('10-MAY-14','DD-MON-RR'),36,36,0,3,TO_DATE('15-JUN-14','DD-MON-RR'),TO_DATE('06-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(48,123,'963253258',TO_DATE('10-MAY-14','DD-MON-RR'),111,111,0,3,TO_DATE('11-JUN-14','DD-MON-RR'),TO_DATE('31-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(49,123,'963253256',TO_DATE('10-MAY-14','DD-MON-RR'),53.25,53.25,0,3,TO_DATE('10-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(50,123,'963253255',TO_DATE('11-MAY-14','DD-MON-RR'),53.75,53.75,0,3,TO_DATE('09-JUN-14','DD-MON-RR'),TO_DATE('03-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(51,123,'963253254',TO_DATE('11-MAY-14','DD-MON-RR'),108.5,108.5,0,3,TO_DATE('08-JUN-14','DD-MON-RR'),TO_DATE('30-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(52,123,'963253252',TO_DATE('11-MAY-14','DD-MON-RR'),38.75,38.75,0,3,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(53,123,'963253251',TO_DATE('11-MAY-14','DD-MON-RR'),15.5,15.5,0,3,TO_DATE('04-JUN-14','DD-MON-RR'),TO_DATE('21-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(54,123,'963253249',TO_DATE('12-MAY-14','DD-MON-RR'),127.75,127.75,0,2,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(55,123,'963253248',TO_DATE('13-MAY-14','DD-MON-RR'),241,241,0,2,TO_DATE('02-JUN-14','DD-MON-RR'),TO_DATE('24-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(56,123,'963253246',TO_DATE('13-MAY-14','DD-MON-RR'),129,129,0,2,TO_DATE('31-MAY-14','DD-MON-RR'),TO_DATE('20-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(57,123,'963253245',TO_DATE('13-MAY-14','DD-MON-RR'),40.75,40.75,0,2,TO_DATE('28-MAY-14','DD-MON-RR'),TO_DATE('14-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(58,123,'963253244',TO_DATE('13-MAY-14','DD-MON-RR'),60,60,0,2,TO_DATE('27-MAY-14','DD-MON-RR'),TO_DATE('21-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(59,123,'963253242',TO_DATE('13-MAY-14','DD-MON-RR'),104,104,0,2,TO_DATE('26-MAY-14','DD-MON-RR'),TO_DATE('17-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(60,123,'963253240',TO_DATE('23-MAY-14','DD-MON-RR'),67,67,0,1,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(61,123,'963253239',TO_DATE('23-MAY-14','DD-MON-RR'),147.25,147.25,0,1,TO_DATE('02-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(62,123,'963253237',TO_DATE('23-MAY-14','DD-MON-RR'),172.5,172.5,0,1,TO_DATE('30-MAY-14','DD-MON-RR'),TO_DATE('24-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(63,123,'963253235',TO_DATE('14-MAY-14','DD-MON-RR'),108.25,108.25,0,1,TO_DATE('20-MAY-14','DD-MON-RR'),TO_DATE('17-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(64,123,'963253234',TO_DATE('14-MAY-14','DD-MON-RR'),138.75,138.75,0,1,TO_DATE('19-MAY-14','DD-MON-RR'),TO_DATE('16-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(65,123,'963253232',TO_DATE('14-MAY-14','DD-MON-RR'),127.75,127.75,0,1,TO_DATE('18-MAY-14','DD-MON-RR'),TO_DATE('16-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(66,123,'963253230',TO_DATE('15-MAY-14','DD-MON-RR'),739.2,739.2,0,1,TO_DATE('17-MAY-14','DD-MON-RR'),TO_DATE('16-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(73,123,'263253257',TO_DATE('18-MAY-14','DD-MON-RR'),22.57,22.57,0,2,TO_DATE('10-JUN-14','DD-MON-RR'),TO_DATE('27-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(74,123,'263253253',TO_DATE('18-MAY-14','DD-MON-RR'),31.95,31.95,0,2,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('01-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(75,123,'263253250',TO_DATE('19-MAY-14','DD-MON-RR'),42.67,42.67,0,2,TO_DATE('03-JUN-14','DD-MON-RR'),TO_DATE('25-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(76,123,'263253243',TO_DATE('20-MAY-14','DD-MON-RR'),44.44,44.44,0,1,TO_DATE('26-MAY-14','DD-MON-RR'),TO_DATE('23-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(77,123,'263253241',TO_DATE('20-MAY-14','DD-MON-RR'),40.2,40.2,0,1,TO_DATE('25-MAY-14','DD-MON-RR'),TO_DATE('22-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(78,123,'94007069',TO_DATE('22-MAY-14','DD-MON-RR'),400,400,0,3,TO_DATE('01-JUL-14','DD-MON-RR'),TO_DATE('25-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(80,105,'94007005',TO_DATE('23-MAY-14','DD-MON-RR'),220,220,0,1,TO_DATE('30-MAY-14','DD-MON-RR'),TO_DATE('26-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(83,115,'24946731',TO_DATE('25-MAY-14','DD-MON-RR'),25.67,25.67,0,2,TO_DATE('14-JUN-14','DD-MON-RR'),TO_DATE('28-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(84,115,'24863706',TO_DATE('27-MAY-14','DD-MON-RR'),6,6,0,1,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('01-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(85,115,'24780512',TO_DATE('29-MAY-14','DD-MON-RR'),6,6,0,1,TO_DATE('31-MAY-14','DD-MON-RR'),TO_DATE('30-MAY-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(86,88,'972110',TO_DATE('30-MAY-14','DD-MON-RR'),207.78,207.78,0,1,TO_DATE('06-JUN-14','DD-MON-RR'),TO_DATE('02-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(87,100,'587056',TO_DATE('31-MAY-14','DD-MON-RR'),2184.5,2184.5,0,3,TO_DATE('28-JUN-14','DD-MON-RR'),TO_DATE('22-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(89,99,'509786',TO_DATE('31-MAY-14','DD-MON-RR'),6940.25,6940.25,0,2,TO_DATE('16-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(90,108,'121897',TO_DATE('01-JUN-14','DD-MON-RR'),450,450,0,2,TO_DATE('19-JUN-14','DD-MON-RR'),TO_DATE('14-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(92,80,'133560',TO_DATE('01-JUN-14','DD-MON-RR'),175,175,0,2,TO_DATE('20-JUN-14','DD-MON-RR'),TO_DATE('03-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(93,104,'P02-3772',TO_DATE('03-JUN-14','DD-MON-RR'),7125.34,7125.34,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(95,107,'RTR-72-3662-X',TO_DATE('04-JUN-14','DD-MON-RR'),1600,1600,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('11-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(96,113,'77290',TO_DATE('04-JUN-14','DD-MON-RR'),1750,1750,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(97,119,'10843',TO_DATE('04-JUN-14','DD-MON-RR'),4901.26,4901.26,0,2,TO_DATE('18-JUN-14','DD-MON-RR'),TO_DATE('11-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(101,103,'75C-90227',TO_DATE('06-JUN-14','DD-MON-RR'),1367.5,1367.5,0,1,TO_DATE('13-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(102,48,'P02-88D77S7',TO_DATE('06-JUN-14','DD-MON-RR'),856.92,856.92,0,1,TO_DATE('13-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(104,114,'CBM9920-M-T77109',TO_DATE('07-JUN-14','DD-MON-RR'),290,290,0,1,TO_DATE('12-JUN-14','DD-MON-RR'),TO_DATE('09-JUN-14','DD-MON-RR'));
INSERT INTO paid_invoices
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date)
VALUES
(108,117,'111897',TO_DATE('11-JUN-14','DD-MON-RR'),16.62,16.62,0,1,TO_DATE('14-JUN-14','DD-MON-RR'),TO_DATE('12-JUN-14','DD-MON-RR'));

-- INSERTING into PROJECTS

INSERT INTO projects (project_number,employee_id) VALUES ('P1011',8);
INSERT INTO projects (project_number,employee_id) VALUES ('P1011',4);
INSERT INTO projects (project_number,employee_id) VALUES ('P1012',3);
INSERT INTO projects (project_number,employee_id) VALUES ('P1012',1);
INSERT INTO projects (project_number,employee_id) VALUES ('P1012',5);
INSERT INTO projects (project_number,employee_id) VALUES ('P1013',6);
INSERT INTO projects (project_number,employee_id) VALUES ('P1013',9);
INSERT INTO projects (project_number,employee_id) VALUES ('P1014',10);

-- INSERTING into STRING_SAMPLE

INSERT INTO string_sample VALUES ('1', 'Lizbeth Darien');
INSERT INTO string_sample VALUES ('2', 'Darnell O''Sullivan');
INSERT INTO string_sample VALUES ('17', 'Lance Pinos-Potter');
INSERT INTO string_sample VALUES ('20', 'Jean Paul Renard');
INSERT INTO string_sample VALUES ('3', 'Alisha von Strump');

COMMIT;