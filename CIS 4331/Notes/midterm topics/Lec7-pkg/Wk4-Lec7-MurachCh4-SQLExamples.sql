--Murach Ch4 SQL Examples in Class
--Week 4, Lec 7

--Topics covered:  Overview
--   outer join, explicit/implicit syntax, SQL Set operators

--Topics covered: (continued)
--2. OUTER JOIN of 3 tables  
--3. Mix of INNER JOIN and OUTER JOIN
--4. Implicit syntax for joins
----4.1 Implicit CROSS JOIN
----4.2 implicit inner join
----4.3 implicit outer join
--5. JOIN USING
--6. NATURAL JOIN  
--7. SQL Set Operators

-- Run as user EX any queries involving tables: departments, employees, projects


--2. OUTER JOIN of 3 tables    

--2.1 LEFT OUTER JOIN  of 3 tables
-- Print each deparment's name, department number, the last name of each employee
--    in that department, and the project number of each project to which 
--    that employee is assigned.
-- Print also the information of departments that currently don't have any employee.
-- Print also the information of each employee who is not in any project.
-- Sort the result in increasing order of department names, then last names, and then project numbers.
SELECT department_name,  last_name, project_number AS proj_no
FROM   departments d LEFT JOIN employees e
           ON d.department_number = e.department_number
       LEFT JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name, last_name, project_number;
  
  
--2.2 RIGHT OUTER JOIN  of 3 tables
-- Print each deparment's name, department number, the last name of each employee
--    in that department, and the project number of each project to which 
--    that employee is assigned.
-- The result includes the information about all employees and all projects, including
--    employees who are not assigned to any department,
--    employees who are in non-existing departments, and
--    projects to which no employees were assigned.
-- Print also the information of each employee who is not in any project.
-- Sort the result in increasing order of department names, then last names, and then project numbers.
SELECT department_name,  last_name, project_number AS proj_no
FROM   departments d RIGHT JOIN employees e
           ON d.department_number = e.department_number
       RIGHT JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name, last_name, project_number;  
  
--2.3 FULL JOIN of 3 tables
--Print each department's name, last name of each employee in that department, 
--   and the project number of each project to which that employee is assigned.
--Print the information of all departments, all employees, and all projects, 
--   including departments without employees, employees without department assignments,
--     employees with non-existing departments, 
--     employees without any project assignments, and
--     projects to which no employees are assigned.
SELECT department_name, last_name, project_number AS proj_no
FROM   departments d FULL JOIN employees e
           ON d.department_number = e.department_number
       FULL JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name;

--3. Mix of INNER JOIN and OUTER JOIN           

--For each department that has at least 1 employee, print the department's name,
--   last name of each employee in that department, and 
--   the project number of each project to which that employee is assigned.
--Print also the information of employees in an existing department and 
--   without any project assignment.
SELECT department_name, last_name, project_number AS proj_no
FROM   departments d JOIN employees e
           ON d.department_number = e.department_number
       LEFT JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name, last_name, project_number;


--INNER JOIN related to the query above
--This query does NOT print the information of employees who are in an existing department and 
--   do not have any project assignment.
SELECT department_name, last_name, project_number AS proj_no
FROM   departments d JOIN employees e
           ON d.department_number = e.department_number
       JOIN projects p
           ON e.employee_id = p.employee_id
ORDER BY department_name, last_name, project_number;



--4. Implicit syntax for joins

--4.1 Implicit CROSS JOIN

--preferred: Explict CROSS JOIN
--Print the department number, department name, employee id, last name of 
--  all combinations of a department and an employee.
--Sort the result in increasing order of department numbers.
SELECT departments.department_number, department_name, employee_id, last_name
FROM departments CROSS JOIN employees
ORDER BY departments.department_number;

--Implicit syntax for CROSS JOIN
--Equivalent to above query
--Print the department number, department name, employee id, last name of 
--  all combinations of a department and an employee.
--Sort the result in increasing order of department numbers.
SELECT departments.department_number, department_name, employee_id, last_name
FROM departments, employees
ORDER BY departments.department_number;

--Run as user ap the following queries involving tables: vendors, invoices
--      general ledger accounts, invoice_line_items

--4.2 Implicit syntax for INNER JOIN

--preferred format: explicit INNER JOIN
--Print the invoice number of each invoice and its vendor name in increasing order of invoice numbers.
SELECT invoice_number, vendor_name
FROM vendors JOIN invoices 
      ON vendors.vendor_id = invoices.vendor_id   -- JOIN condition: parent-table.PK value = child-table.FK value
ORDER BY invoice_number;

--Implicit syntax for inner join
--Equivalent to above query
--Print the invoice number of each invoice and its vendor name in increasing order of invoice numbers.
SELECT invoice_number, vendor_name
FROM vendors v, invoices i
WHERE v.vendor_id = i.vendor_id
ORDER BY invoice_number;

--preferred format: explicit INNER JOIN (more complex case)
--Print each vendor's name, each of its invoice's number and date, and the item amount
-- of each item in that invoice, and the description of the general ledger account 
-- used for that item in that invoice.
--Sort result in increasing order of vendor names, then in decreasing order of item amounts.
SELECT vendor_name, invoice_number, invoice_date, line_item_amt, account_description
FROM vendors v
    JOIN invoices i 
        ON v.vendor_id = i.vendor_id
    JOIN invoice_line_items li 
        ON i.invoice_id = li.invoice_id
    JOIN general_ledger_accounts gl 
        ON li.account_number = gl.account_number
WHERE (invoice_total - payment_total - credit_total) > 0
ORDER BY vendor_name, line_item_amt DESC;

--implicit INNER JOIN (more complex case)
--Equivalent to above query
--Print each vendor's name, each of its invoice's number and date, and the item amount
-- of each item in that invoice, and the description of the general ledger account 
-- used for that item in that invoice.
--Sort result in increasing order of vendor names, then in decreasing order of item amounts.
SELECT vendor_name, invoice_number, invoice_date, 
      line_item_amt, account_description
FROM  vendors v, invoices i, 
      invoice_line_items  li, general_ledger_accounts gl
WHERE v.vendor_id = i.vendor_id
     AND i.invoice_id = li.invoice_id
     AND li.account_number = gl.account_number
     AND (invoice_total - payment_total - credit_total) > 0
ORDER BY vendor_name, line_item_amt DESC;


--4.3 Implicit syntax for OUTER JOIN

--Preferred format: explict syntax for LEFT OUTER JOIN
--Print each department's name, number, and the last name of each employee in that department.
--Sort result in increasing order of department names.
--The result includes the information of departments without any employee.
SELECT department_name AS dept_name, 
    dpt.department_number AS dept_no, 
    last_name
FROM departments dpt LEFT JOIN  employees emp
     ON (dpt.department_number = emp.department_number)  -- +: need to add more for a match
ORDER BY department_name;

--Implicit syntax for LEFT OUTER JOIN
-- +: need to add more data to the table on the right for a match in the table on the left.
--Equivalent to above query. Print the same result.
SELECT department_name AS dept_name, 
    dpt.department_number AS dept_no,
    last_name
FROM departments dpt, employees emp
WHERE dpt.department_number = emp.department_number (+)  -- +: employees table has less data, need to add more to employees table.
ORDER BY department_name;

--Preferred format: explict syntax for RIGHT OUTER JOIN
--Print each employee's last name, the name and number of the department where that employee works.
--Sort result in increasing order of department names.
--The result includes the information of employees without any department assignments
--   or whose department numbers are not in table departments.
SELECT department_name AS dept_name, 
    dpt.department_number AS dept_no,
    last_name
FROM departments dpt RIGHT JOIN  employees emp
     ON (dpt.department_number = emp.department_number)  
ORDER BY department_name;


--Implicit syntax for RIGHT OUTER JOIN
-- +: need to add more data to the table on the left for a match in the table on the right.
--Equivalent to above query. Print the same result.
SELECT department_name AS dept_name, 
    emp.department_number AS dept_no,
    last_name
FROM departments dpt, employees emp
WHERE dpt.department_number (+) = emp.department_number  -- +: departments table has less data
ORDER BY department_name;       


--5. JOIN USING

--JOIN USING: JOIN 2 tables based on specified common columns (column with same name)

--Combine a vendor with an invoice based on the same value in the common column vendor_id in both tables.
-- Common column: column with same name.
--Print the invoice number of each invoice and its vendor name in the increasing order of invoice numbers.
SELECT invoice_number, vendor_name
FROM vendors 
    JOIN invoices USING (vendor_id) 
ORDER BY invoice_number;

--Equivalent JOIN ON
--Print same result as above query
SELECT invoice_number, vendor_name
FROM vendors v
    JOIN invoices i ON (v.vendor_id = i.vendor_id)
ORDER BY invoice_number;


--use the EX user to run queries involving tables: departments, employees, customers

--Can use JOIN USING in OUTER JOIN
--Combine a department with an employee based on matching value in common column: department_number in both tables.
--Combine an employee with a project based on matching value in common column: employee_id in both tables.
--For each department with at least one employee, print the department name,
--  each of its employee's last name, and the project number of his/her assigned project.
--Print also the information of employees without any project assignments.
SELECT department_name AS dept_name, last_name, project_number
FROM departments
    JOIN employees USING (department_number)
    LEFT JOIN projects USING (employee_id)
ORDER BY department_name;

--Equivalent JOIN ON
--Print same result as above query
SELECT department_name AS dept_name, last_name, project_number
FROM departments d
    JOIN employees e ON (d.department_number = e.department_number)
    LEFT JOIN projects p ON (e.employee_id = p.employee_id)
ORDER BY department_name;


--6. NATURAL JOIN

--NATURAL JOIN: join 2 tables based on ALL common columns

--use the AP user
--Combine a vendor with an invoice based on the same values in all common columns in both tables.
--Only 1 common column: vendor_id
--Print the invoice number of each invoice and its vendor name in increasing order of invoice numbers.
SELECT invoice_number, vendor_name
FROM vendors 
    NATURAL JOIN invoices
ORDER BY invoice_number;

--Equivalent JOIN ON
--Print same result as above query
SELECT invoice_number, vendor_name
FROM vendors v 
     JOIN invoices i ON (v.vendor_id = i.vendor_id)
ORDER BY invoice_number;


--use the EX user to run queries involving tables: departments, employees, customers

--Can use NATURAL JOIN together with OUTER JOIN, JOIN USING
--Combine a department with an employee based on same values in all common columns in both tables.
--   Only 1 common column: department_number.
--Combine an employee with a project based on same value in common column employee_id in both tables.
--For each department with at least one employee, print the department name,
--  each of its employee's last name, and the project number of his/her assigned project.
--Print also the information of employees without any project assignments.
SELECT department_name AS dept_name, last_name, project_number
FROM departments
    NATURAL JOIN employees 
    LEFT JOIN projects USING (employee_id)
ORDER BY department_name;

--Equivalent JOIN ON
--Print same result as above query
SELECT department_name AS dept_name, last_name, project_number
FROM  departments d
      JOIN employees e ON (d.department_number = e.department_number)
      LEFT JOIN projects p ON (e.employee_id = p.employee_id)
ORDER BY department_name;


---7. SQL Set Operators

--use the EX user to run queries involving tables: departments, employees, customers

--SQL Set operator: UNION
--Print the first names and last names of all people who are customers or employees.
    SELECT customer_first_name, customer_last_name
    FROM customers
UNION
    SELECT first_name, last_name
    FROM employees
ORDER BY customer_last_name;


--SQL Set operator: INTERSECT
--Print the first names and last names of all people who are both customers and employees.
    SELECT customer_first_name, customer_last_name 
    FROM customers
INTERSECT
    SELECT first_name, last_name 
    FROM employees;
    

--SQL Set operator: MINUS
--Print the first names and last names of all people who are customers but NOT employees.
--Sort the result in increasing order of last names.
    SELECT customer_first_name, customer_last_name
    FROM customers
MINUS
    SELECT first_name, last_name
    FROM employees
ORDER BY customer_last_name;


--SQL Set operator: MINUS
--Print the first names and last names of all people who are employees but NOT customers.
--Sort the result in increasing order of last names.
    SELECT first_name, last_name
    FROM employees
MINUS    
    SELECT customer_first_name, customer_last_name
    FROM customers    
ORDER BY last_name;

--Use the EX user to run queries involving tables: active_invoices, paid_invoices

--Print the word Active as source, the invoice number, invoice date, and invoice total 
-- of each active invoice dated on or after June 1, 2014.
--Active invoice: invoice that has not been paid off yet.
    SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM active_invoices
    WHERE invoice_date >= '01-JUN-2014';


--Print the word Paid as source, the invoice number, invoice date, and invoice total 
-- of each paid invoice dated on or after June 1, 2014.
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM paid_invoices
    WHERE invoice_date >= '01-JUN-2014';


--Print the word Active or Paid as source, the invoice number, invoice date, and invoice total 
-- of each active or paid invoice dated on or after June 1, 2014.
--Sort result in decreasing order of invoice totals.
    SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM active_invoices
    WHERE invoice_date >= '01-JUN-2014'
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM paid_invoices
    WHERE invoice_date >= '01-JUN-2014'
ORDER BY invoice_total DESC;

--MUST Run as user AP. Otherwise would get an error.
--Query equivalent to above query but get data from different source tables in user AP
--Print same result.
    SELECT 'Active' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    WHERE (invoice_total - payment_total - credit_total) > 0
UNION
    SELECT 'Paid' AS source, invoice_number, invoice_date, invoice_total
    FROM invoices
    where (invoice_total - payment_total - credit_total) <= 0
ORDER BY invoice_total DESC;
--ORDER BY source;  --This is also allowed.


----Extra SQL Code for SQL Set operators:
----Run the following queries yourself. 

--Run as user AP
--For large invoices with invoice total amounts more than $10000, 
--  print their invoice numbers, vendor names, the words 33% Payment as PAYMENT_TYPE,
--   invoice total amounts as TOTAL, and 33% of the invoice total amount as PAYMENT.
    SELECT invoice_number, vendor_name, '33% Payment' AS payment_type,
        invoice_total AS total, (invoice_total * 0.333) AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total > 10000;

--Run as user AP
--For medium-size invoices with invoice total amounts between $500 and $10000, 
--  print their invoice numbers, vendor names, the words 50% Payment as PAYMENT_TYPE, 
--  invoice total amounts as TOTAL, and 50% of the invoice total amount as PAYMENT. 
    SELECT invoice_number, vendor_name, '50% Payment' AS payment_type,
        invoice_total AS total, (invoice_total * 0.5) AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total BETWEEN 500 AND 10000;

--Run as user AP
--For small invoices with invoice total amounts below $500, 
--  print their invoice numbers, vendor names, the words Full amount as PAYMENT_TYPE, 
--  invoice total amounts as TOTAL, and 100% of the invoice total amount as PAYMENT.
    SELECT invoice_number, vendor_name, 'Full amount' AS payment_type,
        invoice_total AS Total, invoice_total AS Payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total < 500;


--The query uses the SQL Set operator UNION to print all results from the above three queries.
--Then sort the result in the increasing order of payment_types, vendor_names, and invoice_numbers.
    SELECT invoice_number, vendor_name, '33% Payment' AS payment_type,
        invoice_total AS total, (invoice_total * 0.333) AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total > 10000
UNION
    SELECT invoice_number, vendor_name, '50% Payment' AS payment_type,
        invoice_total AS total, (invoice_total * 0.5) AS payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total BETWEEN 500 AND 10000
UNION
    SELECT invoice_number, vendor_name, 'Full amount' AS payment_type,
        invoice_total AS Total, invoice_total AS Payment
    FROM invoices JOIN vendors
        ON invoices.vendor_id = vendors.vendor_id
    WHERE invoice_total < 500
ORDER BY payment_type, vendor_name, invoice_number;