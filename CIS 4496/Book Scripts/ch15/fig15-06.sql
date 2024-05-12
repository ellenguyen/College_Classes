CREATE OR REPLACE PROCEDURE drop_table
(
  table_name VARCHAR2
)
AS
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE ' || table_name;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

CALL drop_table('test1');

CREATE TABLE test1 (test_id NUMBER);