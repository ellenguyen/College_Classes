--Week 3, Murach Ch4
--In Class Practice, Questions & Answers


--Recommended Steps in Solving a query problem increamentally
--1. identify data needed 
--2. determine data source needed, which tables are needed (FROM clause)
--3. write the query including just SELECT clause, FROM clause
--4. determine types of joins if at least 2 tables are in FROM clause
--5. add join condition
--6. add search condition (WHERE clause)
--7. add presentation style:
--     new column heading in query result, 
--     combining columns using ||, etc.
--     sorting (ORDER BY)


--Run all queries as user AP


--INNER JOIN, SELF-JOIN

--1.
--Print the vendor name, invoice number, invoice date, and balance due amount
-- for each vendor and each of its invoices that have a non-zero remaining balance.
-- Display the heading for the remaing balance as REMAINING_BALANCE,
-- Sort the query result in the increasing order of remaining balances.

--soln 1
SELECT vendor_name, invoice_number, invoice_date, 
          invoice_total - payment_total - credit_total  remaining_balance
FROM   vendors  v INNER JOIN invoices i
        ON (v.vendor_id = i.vendor_id)
WHERE invoice_total - payment_total - credit_total <> 0
ORDER BY remaining_balance; 


--soln 2
SELECT vendor_name, invoice_number, invoice_date, 
          invoice_total - payment_total - credit_total  REMAINING_BALANCE
FROM   vendors  v INNER JOIN invoices i
        ON (v.vendor_id = i.vendor_id)
WHERE invoice_total - payment_total - credit_total != 0
ORDER BY invoice_total - payment_total - credit_total;



--2.
--Print all vendors' names, their invoices' invoice dates and invoice numbers, and 
--  the sequence numbers and item amounts of all items in their invoices.
-- Sort the result first by vendor name, then by invoice date, then by invoice number,
--    then by invoice sequence number. All sorting are in increasing orders.

--answer:
SELECT vendor_name, invoice_date, invoice_number, invoice_sequence, line_item_amt
FROM  vendors v JOIN invoices i ON (v.vendor_id = i.vendor_id)
      JOIN invoice_line_items il ON (il.invoice_id = i.invoice_id)
ORDER BY vendor_name, invoice_date, invoice_number, invoice_sequence;


--3.
--Print the vendor ids, vendor names, vendor contact first and last names of vendors that 
--   share the same contact last names as another vendor.
--Print the vendor contact's first and last name in this format:
--    Steve Jobs
--Print the heading for the vendor contact's first and last name as Contact Name.


--answer 1:
SELECT v1.vendor_id, v1.vendor_name, 
       v1.vendor_contact_first_name || ' ' || v1.vendor_contact_last_name "Contact Name"
FROM  vendors v1 JOIN vendors v2 
   ON ( (v1.vendor_contact_last_name = v2.vendor_contact_last_name)
         AND (v1.vendor_id <> v2.vendor_id) );

--answer 2:
--add DISTINCT in SELECT to remove potential duplicates
SELECT DISTINCT v1.vendor_id, v1.vendor_name, 
       v1.vendor_contact_first_name || ' ' || v1.vendor_contact_last_name "Contact Name"
FROM  vendors v1 JOIN vendors v2 
   ON ( (v1.vendor_contact_last_name = v2.vendor_contact_last_name)
         AND (v1.vendor_id <> v2.vendor_id) );


--4
--Print the names of employees in department 30 and the names of their managers. 

--Soln
--Self Join the primary key column empno with the foreign key column mgr
SELECT e.ename, m.ename
FROM  emp e INNER JOIN emp m 
       ON (e.mgr = m.empno)
WHERE e.deptno = 30;

         