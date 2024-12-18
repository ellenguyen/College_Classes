--Murach Ch4 SQL Examples in Class
--Week 3, Lec 6 

--Topics covered: OUTER JOIN, INNER JOIN
--1. OUTER JOIN of 2 tables, explict syntax
----1.1 LEFT OUTER JOIN
----1.2 RIGHT OUTER JOIN
----1.3 FULL OUTER JOIN


--1. OUTER JOIN of 2 tables, explicit syntax

--1.1 LEFT OUTER JOIN

-- run as user ap the following queries involving tables: vendors, invoices

--connect ap/ap;

--LEFT OUTER JOIN
--Print for each vendor, the vendor name, the invoice number and invoice total of every invoice of that vendor.
--   Also print the vendors that don't have any invoice.
-- Sort the result in increasing order of vendor names.
SELECT vendor_name, invoice_number, invoice_total
FROM   vendors LEFT JOIN invoices
            ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendor_name;

--INNER JOIN query related to the query above.
--Prints only the information of vendors that have at least 1 invoice.
SELECT vendors.vendor_id, vendor_name, invoice_number, invoice_total
FROM   vendors JOIN invoices
          ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendors.vendor_id;

--Query related to OUTER JOIN above
--Print the ids of vendors that have at least 1 invoice
SELECT DISTINCT vendor_id
FROM invoices
ORDER BY vendor_id;

-- RUN AS USER EX ALL QUERIES BELOW.

--connect ex/ex;

-- LEFT outer join
-- Print each deparment's name, department number, and the last name of each employee in that department.
--   Print also the information of departments that currently don't have any employee.
--  Sort the result in increasing order of department names.
SELECT department_name AS dept_name, d.department_number AS dept_no, last_name
FROM   departments d LEFT JOIN employees e
          ON d.department_number = e.department_number
ORDER BY department_name;

--INNER JOIN related to the above query
-- For each department that has at least one employee, print the department's name,
--    department number, and the last name of each employee in that department.
--  Sort the result in increasing order of department names.
-- This query does not print information of departments without any employee.
SELECT department_name AS dept_name, d.department_number AS dept_no, last_name
FROM   departments d JOIN employees e
           ON d.department_number = e.department_number
ORDER BY department_name;


--1.2  RIGHT OUTER JOIN 

-- RIGHT OUTER JOIN
-- Print each employee's department name, department number, and last name.
--   Print also the information of employees who don't belong to any department
--        or belong to nonexisting departments.
--  Sort the result in increasing order of department names.
--For comparison, department numbers from both tables are printed.
SELECT department_name AS dept_name, d.department_number AS d_dept_no,
       e.department_number AS e_dept_no, last_name
FROM   departments d  RIGHT JOIN employees e
          ON d.department_number =  e.department_number
ORDER BY department_name;

--1.3 FULL OUTER JOIN

-- FULL outer join
-- Print each deparment's name, department number, and the last name of each employee in that department.
--   Print also the information of departments that currently don't have any employee.
--   Print also the information of employees who don't belong to any department
--        or belong to nonexisting departments.
--  Sort the result in increasing order of department names.
--For comparison, department numbers from both tables are printed.
SELECT department_name AS dept_name,  d.department_number AS d_dept_no,
       e.department_number AS e_dept_no, last_name
FROM   departments d FULL JOIN employees e
         ON d.department_number = e.department_number
ORDER BY department_name;
