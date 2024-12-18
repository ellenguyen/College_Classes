--Week 3, Part 2 
--Murach Ch4, In Class Practice

--Covered topics: Self Join, OUTER JOIN

--Continued from Lec 5.


--4
--Print the names of employees in department 30 and the names of their managers. 
-- 2 tables: dept, emp
SELECT e.ename "ENAME", m.ename "MgrNAME"
FROM emp e LEFT JOIN emp m ON (e.mgr = m.empno) --AND (e.empno <> m.empno) optional
WHERE e.deptno = 30;

--5
--Print all general ledger accounts' numbers, descriptions, the invoice ids of invoices 
--where the accounts were used.
--The query result also includes accounts that were not used in any purchase. 

-- 2 tables: general_ledge_accounts, invoice_line_items
SELECT g.account_number, g.account_description, i.invoice_id
FROM general_ledger_accounts g LEFT JOIN invoice_line_items i
    ON (g.account_number = i.account_number);


--6.
--Print the account numbers and descriptions of general ledger accounts 
--   that were not used in any purchase
SELECT gla.account_number, gla.account_description
FROM general_ledger_accounts gla LEFT JOIN invoice_line_items ili
    ON (gla.account_number = ili.account_number)
WHERE invoice_id IS NULL;
