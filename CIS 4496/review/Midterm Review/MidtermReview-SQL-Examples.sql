--SQL Examples in Midterm Review

--Run as user AP until another user name is mentioned.

--literal values, calculated values, operator ||, column alias 
SELECT 'Vendor: ' || ' ' || vendor_name  AS "Vendor Names"
FROM  vendors;

--IS NULL, IS NOT NULL
-- employees don't earn commissions
SELECT *
FROM emp
WHERE comm IS NULL;

--IS NOT NULL
-- employees earn commissions
SELECT *
FROM emp
WHERE comm IS NOT NULL;

--vendor_address2 in table vendors uses a string value 'NULL', which is not a NULL value.
-- So IS NULL operator does not return vendors that don't have second line addresses
SELECT *
FROM  vendors
WHERE vendor_address2 IS NULL;

--Dual table, scalar function
SELECT SYSDATE
FROM dual;


--Run as user EX, until another user name is mentioned

--inner join
--only employees and departments with mataching department_numbers are returned
SELECT last_name, department_name
FROM  employees e JOIN departments d on (e.department_number = d.department_number);

--left outer join
--return all employees (inner join result + extra employees whose department numbers are not matched)
SELECT last_name, department_name
FROM  employees e LEFT JOIN departments d on (e.department_number = d.department_number);

--right outer join
--return all departments (inner join result + extra departments whose department numbers are not matched)
SELECT last_name, department_name
FROM  employees e RIGHT JOIN departments d on (e.department_number = d.department_number);

--full outer join
--return all employees and all departments 
--  (inner join result 
--      + extra employees whose department numbers are not matched
--      + extra departments whose department numbers are not matched)
SELECT last_name, department_name
FROM  employees e FULL JOIN departments d on (e.department_number = d.department_number);

--sql set operator UNION
--This sql statement is equivalent to the above query (a full outer join), returning
--  rows returned by first query (left outer join)
-- or rows returned by second query (right outer join)
    SELECT last_name, department_name
    FROM  employees e LEFT JOIN departments d on (e.department_number = d.department_number)
UNION
    SELECT last_name, department_name
    FROM  employees e RIGHT JOIN departments d on (e.department_number = d.department_number);

--sql set operator INTERSECT
--This sql statement includes ONLY COMMON rows returned
--  by BOTH first query (left outer join) AND by second query (right outer join)
--This sql statement is equivalent to the inner join below.
    SELECT last_name, department_name
    FROM  employees e LEFT JOIN departments d on (e.department_number = d.department_number)
INTERSECT
    SELECT last_name, department_name
    FROM  employees e RIGHT JOIN departments d on (e.department_number = d.department_number);

--This inner join is equivalent to the above query involving INTERSECT.
--only employees and departments with mataching department_numbers are returned
SELECT last_name, department_name
FROM  employees e JOIN departments d on (e.department_number = d.department_number);


--sql set operator MINUS
-- Returns ONLY rows returned by first query but NOT by second query.
--   So only (extra employees whose department numbers are not matched)
    SELECT last_name, department_name
    FROM  employees e LEFT JOIN departments d on (e.department_number = d.department_number)
MINUS
    SELECT last_name, department_name
    FROM  employees e RIGHT JOIN departments d on (e.department_number = d.department_number);

--sql set operator MINUS
-- Returns ONLY rows returned by first query but NOT by second query.
--   So only (extra departments whose department numbers are not matched)
    SELECT last_name, department_name
    FROM  employees e RIGHT JOIN departments d on (e.department_number = d.department_number)
MINUS 
    SELECT last_name, department_name
    FROM  employees e LEFT JOIN departments d on (e.department_number = d.department_number);


--inner join of 3 tables
--only employees, departments and projects with matching department numbers, employee ids are returned
SELECT last_name, department_name, project_number
FROM  employees e JOIN departments d on (e.department_number = d.department_number)
        JOIN projects p ON (e.employee_id = p.employee_id);

--left outer join  of 3 tables
--returns all departments and all employees, but only projects with matching assigned-employee ids
--SELECT last_name, department_name, project_number
SELECT e.department_number, p.employee_id
FROM  employees e LEFT JOIN departments_ex d on (e.department_number = d.department_number)
        LEFT JOIN projects p ON (e.employee_id = p.employee_id);

SELECT e.department_number, p.employee_id
FROM  employees e LEFT OUTER JOIN departments_ex d on (e.department_number = d.department_number)
        INNER JOIN projects p ON (e.employee_id = p.employee_id);

--right outer join of 3 tables
--this query is a little tricky because the second join condition is combining rows 
--    based on a column from the FIRST table employees and a column from the THIRD table projects.
--The FROM clause is equivalent to the next query, which is easier to understand.
SELECT last_name, department_name, project_number
FROM  employees e RIGHT JOIN departments_ex d on (e.department_number = d.department_number)
        RIGHT JOIN projects p ON (e.employee_id = p.employee_id);

--MIXED outer join of 3 tables
--The FROM clause is equivalent to the above query.
--e.employee_id is added to make the query easier to understand.
--The extra data: Operations department does not have an employee. So its employee_id value is NULL.
-- So the NULL value in employee_id makes the condition e.employee_id = p.employee_id evaluates to NULL.
--So Operations department is not included in the query result.
--So the right outer join cancelled the effect of left outer join.
--The ONLY extra data returned by this query are extra projects with non-matched assigned employee ids.
--This query is equivalent to the next query, which is easier to understand than this query.
SELECT department_name, e.employee_id, last_name, project_number
FROM  departments_ex d LEFT JOIN employees e on (d.department_number = e.department_number)
        RIGHT JOIN projects p ON (e.employee_id = p.employee_id);
        
--This query is equivalent to the query above.
SELECT department_name, e.employee_id, last_name, project_number
FROM  departments d JOIN employees e on (d.department_number = e.department_number)
        RIGHT JOIN projects p ON (e.employee_id = p.employee_id);                

--Run as user AP until another user name is mentioned.
--self join
--print the names of each employee and his/her manager
SELECT e.ename, m.ename
FROM  emp e JOIN emp m ON (e.mgr = m.empno);

--Run as user EX until another user name is mentioned.

--JOIN ON vs JOIN USING
--Join rows based on a matching join condition
SELECT last_name, department_name
FROM  employees e JOIN departments d on (e.department_number = d.department_number);

--JOIN ON vs JOIN USING
--Join rows using specified common columns with the same names
--This query is equivalent to the above query.
SELECT last_name, department_name
FROM  employees JOIN departments_ex USING (department_number);


--natural join
--join rows based on matching value combinations in all common columns in two tables that have the same names.
--This query is equivalent to the above two queries if the two tables only have one common column.
SELECT last_name, department_name
FROM  employees NATURAL JOIN departments_ex;

--Run as user UV until another user name is mentioned.

--natural join
--combine a section row with a row in takes based on a matching combination of values in all common columns
SELECT *
FROM  section NATURAL JOIN takes;

--run this query using tables in UV
--equivalent to the query above
SELECT *
FROM  section JOIN takes USING (course_id, sec_id, semester, year);


--run this query using tables in UV
--combine rows in section and takes using matching 3-value combinations in common columns: course_id, sec_id, semester
SELECT *
FROM  section JOIN takes USING (course_id, sec_id, semester);

--Run as user EX until another user name is mentioned.

--implicit syntax of inner join
SELECT last_name, department_name
FROM  employees e, departments d
WHERE e.department_number  = d.department_number;

--explicit syntax of inner join
SELECT last_name, department_name
FROM  employees e JOIN departments d on (e.department_number = d.department_number);

--implicit syntax of left outer join
SELECT last_name, department_name
FROM  employees e, departments d
WHERE e.department_number  = d.department_number (+);

--explicit syntax of left outer join
SELECT last_name, department_name
FROM  employees e LEFT JOIN departments d on (e.department_number = d.department_number);


--implicit syntax of right outer join
SELECT last_name, department_name
FROM  employees e, departments d
WHERE e.department_number (+) = d.department_number;

--explicit syntax of right outer join
SELECT last_name, department_name
FROM  employees e RIGHT JOIN departments d on (e.department_number = d.department_number);
    