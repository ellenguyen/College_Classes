--CONNECT om/om;

SET DEFINE OFF;

-- Begin an anonymous PL/SQL script that 
-- drops all tables in the EX schema and
-- suppresses the error messages that are displayed if the tables don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE order_details';
  EXECUTE IMMEDIATE 'DROP TABLE orders';
  EXECUTE IMMEDIATE 'DROP TABLE items';
  EXECUTE IMMEDIATE 'DROP TABLE customers';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/

CREATE TABLE customers
(
  customer_id           NUMBER          NOT NULL,
  customer_first_name   VARCHAR2(50),
  customer_last_name    VARCHAR2(50)    NOT NULL,
  customer_address      VARCHAR2(255)   NOT NULL,
  customer_city         VARCHAR2(50)    NOT NULL,
  customer_state        CHAR(2)         NOT NULL,
  customer_zip          VARCHAR2(20)    NOT NULL,
  customer_phone        VARCHAR2(30)    NOT NULL,
  customer_fax          VARCHAR2(30),
  CONSTRAINT customers_pk 
    PRIMARY KEY (customer_id)
);

CREATE TABLE items
(
  item_id       NUMBER		NOT NULL,
  title         VARCHAR2(50)	NOT NULL,
  artist        VARCHAR2(50)	NOT NULL,
  unit_price    NUMBER		NOT NULL,
  CONSTRAINT items_pk 
    PRIMARY KEY (item_id),
  CONSTRAINT title_artist_unq
    UNIQUE (title, artist)
);

CREATE TABLE orders
(
  order_id          NUMBER      NOT NULL,
  customer_id       NUMBER      NOT NULL,
  order_date        DATE        NOT NULL,
  shipped_date      DATE,
  CONSTRAINT orders_pk
    PRIMARY KEY (order_id),
  CONSTRAINT orders_fk_customers
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);

CREATE TABLE order_details
(
  order_id      NUMBER        NOT NULL,
  item_id       NUMBER        NOT NULL,
  order_qty     NUMBER        NOT NULL,
  CONSTRAINT order_details_pk 
    PRIMARY KEY (order_id, item_id),
  CONSTRAINT order_details_fk_orders
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id),
  CONSTRAINT order_details_fk_items
    FOREIGN KEY (item_id)
    REFERENCES items (item_id)
);

-- INSERT INTO customers 
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (1,'Korah','Blanca','1555 W Lane Ave','Columbus','OH','43221','6145554435','6145553928');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (2,'Yash','Randall','11 E Rancho Madera Rd','Madison','WI','53707','2095551205','2095552262');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (3,'Johnathon','Millerton','60 Madison Ave','New York','NY','10010','2125554800','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (4,'Mikayla','Damion','2021 K Street Nw','Washington','DC','20006','2025555561','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (5,'Kendall','Mayte','4775 E Miami River Rd','Cleves','OH','45002','5135553043','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (6,'Kaitlin','Hostlery','3250 Spring Grove Ave','Cincinnati','OH','45225','8005551957','8005552826');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (7,'Derek','Chaddick','9022 E Merchant Wy','Fairfield','IA','52556','5155556130','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (8,'Deborah','Damien','415 E Olive Ave','Fresno','CA','93728','5595558060','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (9,'Karina','Lacy','882 W Easton Wy','Los Angeles','CA','90084','8005557000','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (10,'Kurt','Nickalus','28210 N Avenue Stanford','Valencia','CA','91355','8055550584','8055556689');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (11,'Kelsey','Eulalia','7833 N Ridge Rd','Sacramento','CA','95887','2095557500','2095551302');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (12,'Anders','Rohansen','12345 E 67th Ave NW','Takoma Park','MD','24512','3385556772','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (13,'Thalia','Neftaly','2508 W Shaw Ave','Fresno','CA','93711','5595556245','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (14,'Gonzalo','Keeton','12 Daniel Road','Fairfield','NJ','07004','2015559742','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (15,'Ania','Irvin','1099 N Farcourt St','Orange','CA','92807','7145559000','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (16,'Dakota','Baylee','1033 N Sycamore Ave.','Los Angeles','CA','90038','2135554322','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (17,'Samuel','Jacobsen','3433 E Widget Ave','Palo Alto','CA','92711','4155553434','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (18,'Justin','Javen','828 S Broadway','Tarrytown','NY','10591','8005550037','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (19,'Kyle','Marissa','789 E Mercy Ave','Phoenix','AZ','85038','9475553900','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (20,'Erick','Kaleigh','Five Lakepointe Plaza, Ste 500','Charlotte','NC','28217','7045553500','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (21,'Marvin','Quintin','2677 Industrial Circle Dr','Columbus','OH','43260','6145558600','6145557580');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (22,'Rashad','Holbrooke','3467 W Shaw Ave #103','Fresno','CA','93711','5595558625','5595558495');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (23,'Trisha','Anum','627 Aviation Way','Manhatttan Beach','CA','90266','3105552732','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (24,'Julian','Carson','372 San Quentin','San Francisco','CA','94161','6175550700','NULL');
INSERT INTO customers 
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax) 
VALUES (25,'Kirsten','Story','2401 Wisconsin Ave NW','Washington','DC','20559','2065559115','NULL');

-- INSERT INTO items 
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(1,'Umami In Concert','Umami',17.95);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(2,'Race Car Sounds','The Ubernerds',13);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(3,'No Rest For The Weary','No Rest For The Weary',16.95);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(4,'More Songs About Structures and Comestibles','No Rest For The Weary',17.95);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(5,'On The Road With Burt Ruggles','Burt Ruggles',17.5);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(6,'No Fixed Address','Sewed the Vest Pocket',16.95);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(7,'Rude Noises','Jess & Odie',13);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(8,'Burt Ruggles: An Intimate Portrait','Burt Ruggles',17.95);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(9,'Zone Out With Umami','Umami',16.95);
INSERT INTO items (item_id,title,artist,unit_price) VALUES 
(10,'Etcetera','Onn & Onn',17);

-- INSERT INTO orders 
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(19,1,TO_DATE('23-OCT-12','DD-MON-RR'),TO_DATE('28-OCT-12','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(29,8,TO_DATE('05-NOV-12','DD-MON-RR'),TO_DATE('11-NOV-12','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(32,11,TO_DATE('10-NOV-12','DD-MON-RR'),TO_DATE('13-NOV-12','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(45,2,TO_DATE('25-NOV-12','DD-MON-RR'),TO_DATE('30-NOV-12','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(70,10,TO_DATE('28-DEC-12','DD-MON-RR'),TO_DATE('07-JAN-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(89,22,TO_DATE('20-JAN-13','DD-MON-RR'),TO_DATE('22-JAN-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(97,20,TO_DATE('29-JAN-13','DD-MON-RR'),TO_DATE('02-FEB-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(118,3,TO_DATE('24-FEB-13','DD-MON-RR'),TO_DATE('28-FEB-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(144,17,TO_DATE('21-MAR-13','DD-MON-RR'),TO_DATE('29-MAR-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(158,9,TO_DATE('04-APR-13','DD-MON-RR'),TO_DATE('20-APR-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(165,14,TO_DATE('11-APR-13','DD-MON-RR'),TO_DATE('13-APR-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(180,24,TO_DATE('25-APR-13','DD-MON-RR'),TO_DATE('30-MAY-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(231,15,TO_DATE('14-JUN-13','DD-MON-RR'),TO_DATE('22-JUN-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(242,23,TO_DATE('24-JUN-13','DD-MON-RR'),TO_DATE('06-JUL-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(264,9,TO_DATE('15-JUL-13','DD-MON-RR'),TO_DATE('18-JUL-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(298,18,TO_DATE('18-AUG-13','DD-MON-RR'),TO_DATE('22-SEP-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(321,2,TO_DATE('09-SEP-13','DD-MON-RR'),TO_DATE('05-OCT-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(381,7,TO_DATE('08-NOV-13','DD-MON-RR'),TO_DATE('16-NOV-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(392,19,TO_DATE('16-NOV-13','DD-MON-RR'),TO_DATE('23-NOV-13','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(413,17,TO_DATE('05-DEC-13','DD-MON-RR'),TO_DATE('11-JAN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(442,5,TO_DATE('28-DEC-13','DD-MON-RR'),TO_DATE('03-JAN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(479,1,TO_DATE('30-JAN-14','DD-MON-RR'),TO_DATE('03-MAR-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(491,16,TO_DATE('08-FEB-14','DD-MON-RR'),TO_DATE('14-FEB-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(494,4,TO_DATE('10-FEB-14','DD-MON-RR'),TO_DATE('14-FEB-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(523,3,TO_DATE('07-MAR-14','DD-MON-RR'),TO_DATE('15-MAR-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(548,2,TO_DATE('22-MAR-14','DD-MON-RR'),TO_DATE('18-APR-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(550,17,TO_DATE('23-MAR-14','DD-MON-RR'),TO_DATE('03-APR-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(601,16,TO_DATE('21-APR-14','DD-MON-RR'),TO_DATE('27-APR-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(606,6,TO_DATE('25-APR-14','DD-MON-RR'),TO_DATE('02-MAY-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(607,20,TO_DATE('25-APR-14','DD-MON-RR'),TO_DATE('04-MAY-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(624,2,TO_DATE('04-MAY-14','DD-MON-RR'),TO_DATE('09-MAY-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(627,17,TO_DATE('05-MAY-14','DD-MON-RR'),TO_DATE('10-MAY-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(630,20,TO_DATE('08-MAY-14','DD-MON-RR'),TO_DATE('18-MAY-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(631,21,TO_DATE('09-MAY-14','DD-MON-RR'),TO_DATE('11-MAY-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(651,12,TO_DATE('19-MAY-14','DD-MON-RR'),TO_DATE('02-JUN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(658,12,TO_DATE('23-MAY-14','DD-MON-RR'),TO_DATE('02-JUN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(687,17,TO_DATE('05-JUN-14','DD-MON-RR'),TO_DATE('08-JUN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(693,9,TO_DATE('07-JUN-14','DD-MON-RR'),TO_DATE('19-JUN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(703,19,TO_DATE('12-JUN-14','DD-MON-RR'),TO_DATE('19-JUN-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(773,25,TO_DATE('11-JUL-14','DD-MON-RR'),TO_DATE('13-JUL-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(778,13,TO_DATE('12-JUL-14','DD-MON-RR'),TO_DATE('21-JUL-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(796,17,TO_DATE('19-JUL-14','DD-MON-RR'),TO_DATE('26-JUL-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(800,19,TO_DATE('21-JUL-14','DD-MON-RR'),TO_DATE('28-JUL-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(802,2,TO_DATE('21-JUL-14','DD-MON-RR'),TO_DATE('31-JUL-14','DD-MON-RR'));
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(824,1,TO_DATE('01-AUG-14','DD-MON-RR'),null);
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(827,18,TO_DATE('02-AUG-14','DD-MON-RR'),null);
INSERT INTO orders (order_id,customer_id,order_date,shipped_date) VALUES 
(829,9,TO_DATE('02-AUG-14','DD-MON-RR'),null);

-- INSERTING into ORDER_DETAILS
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (381,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (601,9,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (442,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (523,9,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (630,5,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (778,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (693,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (118,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (264,7,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (607,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (624,7,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (658,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (800,5,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (158,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (321,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (687,6,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (827,6,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (144,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (264,8,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (479,1,2);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (630,6,2);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (796,5,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (97,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (601,5,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (773,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (800,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (29,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (70,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (97,8,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (165,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (180,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (231,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (392,8,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (413,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (491,6,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (494,2,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (606,8,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (607,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (651,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (703,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (796,2,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (802,2,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (802,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (824,7,2);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (829,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (550,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (796,7,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (829,2,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (693,6,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (29,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (32,7,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (242,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (298,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (479,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (548,9,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (627,9,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (778,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (687,8,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (19,5,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (89,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (242,6,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (264,4,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (550,1,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (631,10,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (693,7,3);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (824,3,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (829,5,1);
INSERT INTO order_details (order_id,item_id,order_qty) VALUES (829,9,1);

COMMIT;