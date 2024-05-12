CONNECT ap/ap;

DROP USER john CASCADE;
DROP USER jane CASCADE;
DROP USER jim CASCADE;

DROP ROLE ap_user;
DROP ROLE ap_developer;

-- use the PUBLIC keyword to grant a privilege to all users
GRANT CREATE SESSION TO PUBLIC;
REVOKE CREATE SESSION FROM PUBLIC;

-- create the roles
CREATE ROLE ap_user;
CREATE ROLE ap_developer;

GRANT CREATE SESSION TO ap_user;
GRANT CREATE TABLE TO ap_user;
GRANT SELECT ON vendors TO ap_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON invoices TO ap_user;
GRANT ALL ON invoices TO ap_user;

-- create the users
CREATE USER john IDENTIFIED BY sesame;
CREATE USER jane IDENTIFIED BY sesame;
CREATE USER jim IDENTIFIED BY sesame;

GRANT ap_user TO john, jane;

GRANT ap_user TO ap_developer;
GRANT CREATE SESSION TO ap_developer WITH ADMIN OPTION;
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO ap_developer;
GRANT DROP ANY TABLE, DROP ANY VIEW TO ap_developer;

GRANT ap_developer TO jim;