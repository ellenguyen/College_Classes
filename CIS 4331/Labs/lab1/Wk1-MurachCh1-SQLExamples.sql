--4331
--SQL Examples Related to Chapter 1 in Murach's book

-- Lec 1

-- print the information about all vendors
-- run as user ap
SELECT  *
FROM    vendors;

-- Lec 2

--as user ex
-- print the names of all employees in department 2
SELECT first_name, last_name
FROM   employees
WHERE  department_number = 2;


--Run following commands as user system

--Drop user avatar and all its database objects
/* DROP USER avatar CASCADE;

--create user with account name: avatar and password avatar,
-- set tablespace users to be the default place for storing avatar's tables
CREATE USER avatar
IDENTIFIED BY avatar
DEFAULT TABLESPACE users;

--grant to avatar the permission to connect to the database server
GRANT CREATE SESSION TO avatar;

--grant all system priviledges to avatar;
GRANT ALL PRIVILEGES to avatar;

--grant to avatar the permission to get data from terms table in ap user
GRANT SELECT ON ap.terms TO avatar;


--Run the following SQL statements as user avatar

--get all data from table terms in user ap
SELECT *
FROM ap.terms;

drop table friends; */

--Create a table named friends that has 3 columns
CREATE TABLE friends
( name VARCHAR(20) PRIMARY KEY, 
  phone VARCHAR(10), 
  trust NUMBER(2)
);

--Try to add a friend Anna to table friends
INSERT INTO friends
VALUES ('Jake', '111-111-1111', 10);

--Modify table friends and enlarge the length of column phone
ALTER TABLE friends
MODIFY phone VARCHAR(12);

--Try to add a friend to table friends
INSERT INTO friends
VALUES ('Jake', '111-111-1111', 10);

--Insert Spider to table friends
INSERT INTO friends
VALUES ('Spider', '222-222-2222', 9);

--Print the names of all friends
SELECT name
FROM friends;

--Print all information about all friends
SELECT *
FROM friends;

--Change the phone number of Jake
UPDATE friends
SET phone = '333-333-3333'
WHERE name = 'Jake';

--Delete friends whose trust scores are lower than 10
DELETE FROM friends
WHERE trust < 10;

--Insert Jake's information again
INSERT INTO friends
VALUES ('Spider', '222-222-2222', 9);

--Cancel the data changes made in the current transaction.
--Here: cancel the changes made via the DML statements between 'ALTER TABLE...' and 'ROLLBACK'.
ROLLBACK;

--Make the data changes made in the current transaction permanent
COMMIT;