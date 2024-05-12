CONNECT ap/ap;

GRANT CREATE ANY VIEW TO ap_developer;
REVOKE DROP ANY VIEW FROM ap_developer;

GRANT ALL ON invoices TO ap_user;
REVOKE SELECT ON invoices FROM ap_user;
REVOKE INSERT, UPDATE, DELETE ON invoices FROM ap_user;

GRANT ALL ON invoices TO ap_user;
REVOKE ALL ON invoices FROM ap_user;

GRANT ap_user TO john, jane;
REVOKE ap_user FROM john, jane;

GRANT ap_user TO ap_developer;
REVOKE ap_user FROM ap_developer;