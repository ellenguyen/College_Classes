-- use the EX connection
CONNECT ex/ex;

SELECT * FROM v$timezone_names;

SELECT SESSIONTIMEZONE FROM dual;
SELECT DBTIMEZONE FROM dual;

