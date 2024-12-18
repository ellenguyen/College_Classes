--Lab 8
--Elle Nguyen


--Q1
--Write INSERT statement, add to Categories table:
--  category_id: 5
--  category_name: Percussion
--Code the INSERT statement as permanent
INSERT INTO categories_mgs (category_id, category_name)
VALUES (5, 'Percussion');

COMMIT;


--Q2
--Write UPDATE statement, change name of musical instrument category w ID 5 to String.
--NOTES:
--  • For this question, your query must choose the data based on only the data you are given: the ID.
--  • In a typical situation, you don’t know the category name when writing this query unless you run another query to get it.
UPDATE categories_mgs
SET category_name = 'String'
WHERE category_id = 5;


--Q3
--Write DELETE statement, delete String category w/o knowing the category ID. Assume unique category names.
DELETE FROM categories_mgs
WHERE category_name = 'String';


--Q4
--Write INSERT statement (use COLUMN LIST), add new row to Products table:
--  product_id: 11
--  category_id: 4
--  product_code: YDP162R
--  product_name: Yamaha Arius YDP162R Traditional Console Style Digital Piano
--  description: The best keyboard on the market. Offers excellent sound rendering that truly separates it from the rest of the pack.
--  list_price: 1599.99
--  discount_percent: 10
--  date_added: the date and time when this INSERT statement is executed
INSERT INTO products_mgs
    (product_id, category_id, product_code, product_name,
     description, list_price, discount_percent, date_added)
VALUES 
    (11, 4, 'YDP162R', 'Yamaha Arius YDP162R Traditional Console Style Digital Piano',
     'The best keyboard on the market. Offers excellent sound rendering that truly separates it from the rest of the pack.',
     1599.99, 10, SYSDATE);


--Q5
--Another DELETE statement, delete all products in this category.
--Write DELETE statement, delete category w ID 4. 
--2 DELETE statements + 1 TCL to cancel the changes.
DELETE FROM products_mgs
WHERE category_id = 4;

DELETE FROM categories_mgs
WHERE category_id = 4;

ROLLBACK;


--Q6
--Write INSERT statement (use COLUMN LIST), add the row to Customers table:
--  customer_id: 9
--  email_address: john@yahoo.com
--  password: funny
--  first_name: John
--  last_name: Oliver
INSERT INTO customers_mgs
    (customer_id, email_address, password, first_name, last_name)
VALUES 
    (9, 'john@yahoo.com', 'funny', 'John', 'Oliver');
    

--Q7
--Write UPDATE statement, change all passwords to hello.
UPDATE customers_mgs
SET password = 'hello';


--Q8
--Write UPDATE statement (use subquery & aggregation function), change passwords of customers w > 1 order to excellent.
UPDATE customers_mgs
SET password = 'excellent'
WHERE customer_id IN 
    (SELECT customer_id
     FROM orders_mgs
     GROUP BY customer_id
     HAVING COUNT(*) > 1);
     

--Q9
--Code TCL statement, cancel changes made in current transaction.
ROLLBACK;


--Q10
--Run the script create_mgs_tables.sql (done)


--Q11
--Create 2 tables with the following info:
--  Table Event:
--      Each event has unique event ID (123), date, location, menu ID. Exactly 1 menu provided each event.
--  Table Menu:
--      Each menu has unique menu ID (45), description, type.
--Notes:
--  put CREATE TABLE in correct order
--  define necessary constraints (primary key, foreign key, etc.)
--  1 parent table (create before) + 1 child table
CREATE TABLE menu
(
    menu_id             NUMBER          PRIMARY KEY,
    menu_description    VARCHAR2(100)   NOT NULL,
    menu_type           VARCHAR2(50)    NOT NULL
);

CREATE TABLE event
(
    event_id        NUMBER          PRIMARY KEY,
    event_date      DATE            NOT NULL,
    event_location  VARCHAR2(50)    NOT NULL,
    menu_id         NUMBER          REFERENCES menu (menu_id)
);


--Q12
--Write 2 DDL statements, drop 2 tables created in Q11.
--Notes:
--  list DROP TABLE in correct order
--  drop child table before parent table
DROP TABLE event;
DROP TABLE menu;


--Q13
--Write DDL statement, create an index named event_date_ix for event date in EVENT table.
CREATE INDEX event_date_ix
    ON event (event_date);


--Q14
--Write DDL statement, create sequence menu_id_seq. 
--This sequence will be used to auto-generate menu ids in MENU table.
--Note: You can use all default settings when creating the sequence
CREATE SEQUENCE menu_id_seq
    START WITH 1
    INCREMENT BY 1;
    

--Q15
--Use sequence menu_id_seq to insert the row into MENU table.
--  Menu id: next number in the sequence menu_id_seq
--  Description: Menu 1 for vegetarians
--  Type: Vegetarian
INSERT INTO menu
VALUES (menu_id_seq.NEXTVAL, 'Menu 1 for vegetarians', 'Vegetarian');
