--Wk2
--In Class Practice for Murach-Ch3

--Covered topics:
----WHERE, ORDER BY clauses
----Basic comparison, logical operators
----ROWNUM, ||, column alias
----LIKE, wildcard characters
----Dual table, scalar function

--Run the statements using user AP unless otherwise indicated.

--1.
--print names, dept numbers of employees supervised by manager with id 7839
--  in the increasing order of employee names
SELECT ENAME, EMPNO
FROM EMP
WHERE MGR = 7839
ORDER BY ENAME ASC;


--2.
--For the above query, limit the query result to be at most 2 rows
SELECT ENAME, EMPNO
FROM EMP
WHERE MGR = 7839 AND ROWNUM <= 2
ORDER BY ENAME ASC;

--3.
--print all employees' work information and 
--display the heading of the query result to be Work Info
--Sample Output:
---- Work Info
---- KING works in Dept 10
---- BLAKE works in Dept 30
SELECT ENAME || ' works in Dept ' || DEPTNO AS "Work Info"
FROM EMP;


--4.
--use the tables in user EX
--print the first names, last names of customers whose first name start with Jo
SELECT CUSTOMER_FIRST_NAME, CUSTOMER_LAST_NAME
FROM CUSTOMERS_EX
WHERE CUSTOMER_FIRST_NAME LIKE 'Jo%';


--5.
--car loan: 
-- Simplified and do not consider compound interest
-- loan amount: $20000,  loan interest rate: 6%, 
-- Print the car loan principal amount, total interest amount, 
--      the total amount you would pay after the principal is paid off,
--      and the current date in the default date format.
-- Display the headings of query result like this:
-- Principal    Interest Amount      Total Payment    Today
--   20000        1200                 21200          29-JAN-19
SELECT 20000 AS Principal, 20000 * 0.06 AS "Interest Amount", 20000 * 1.06 AS "Total Payment", SYSDATE AS Today
FROM dual;


--6. 
-- Print the date and time when the query is executed.
-- Print the date and time in the format below ( time in 24 hour notation)
-- Display the heading for the query result as System Date
---Sample Output
-----System Date
-----28-jan-2020 13:46:05
SELECT TO_CHAR(SYSDATE, 'DD-mon-YYYY hh12:mm:ss') AS "System Date"
FROM dual;