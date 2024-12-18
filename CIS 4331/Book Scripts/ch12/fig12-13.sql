-- grant some privileges directly to John
CONNECT ap/ap;
GRANT CREATE PROCEDURE TO john;
GRANT SELECT ON vendors TO john;

-- view privileges
CONNECT john/sesame;
SELECT * FROM user_sys_privs;

SELECT * FROM user_tab_privs;
SELECT * FROM user_tab_privs WHERE grantee = 'JOHN';

SELECT * FROM user_role_privs;

SELECT * FROM role_sys_privs;
SELECT * FROM role_sys_privs WHERE role = 'AP_USER';

SELECT * FROM role_tab_privs;
SELECT * FROM role_tab_privs WHERE role = 'AP_USER';