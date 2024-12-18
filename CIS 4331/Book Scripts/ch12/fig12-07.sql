CONNECT ap/ap;

DROP ROLE ap_user;
DROP ROLE ap_admin;

CREATE ROLE ap_user;
CREATE ROLE ap_admin IDENTIFIED BY secret;

-- test the role
GRANT CREATE SESSION TO ap_user;
GRANT ap_user TO john;