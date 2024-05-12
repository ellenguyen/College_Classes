--Question 4
--For each vendor whose city name starts with the upper case letter A, 
--print its name, city, and total invoice amount (in terms of money). 
--Prin all vendors. If a vendor has no invoices, then report the invoice information as null. 
--Use the heading TOTAL_INVOICE_AMOUNT in the result. Sort the result in the increasing order of the vendors' cities.
--Your answer is required to use a join.
SELECT vendor_name, vendor_city, SUM(invoice_total) AS total_invoice_amount
FROM vendors v LEFT JOIN invoices i
    ON (v.vendor_id = i.vendor_id)
WHERE vendor_city LIKE 'A%'
GROUP BY vendor_name, vendor_city
ORDER BY vendor_city;


--Question 5
--For the items in the invoice with id 100,
--print the descriptions, costs, and general ledger accounts used in the following format. 
SELECT 'Item: ' || line_item_description || ' , Cost: ' || line_item_amt || ', Paid From Account: ' || account_number AS "Invoice 100 Items"
FROM invoice_line_items
WHERE invoice_id = 100;


--Question 6
--Print the ids, states, and vendor contact last names of vendors in Wisconsin
--or vendors in California that have vendor contact last names ending with the lower case letter sequence: ren.
--Your query is required to use a SQL set operator.
    (SELECT vendor_id, vendor_state, vendor_contact_last_name
     FROM vendors
     WHERE vendor_state = 'WI')
UNION
    (SELECT vendor_id, vendor_state, vendor_contact_last_name
     FROM vendors
     WHERE vendor_state = 'CA' AND vendor_contact_last_name LIKE '%ren');


--Testing
--Question 17
SELECT line_item_description
FROM invoice_line_items
WHERE line_item_description LIKE '%C%';


--Question 18
SELECT sal + NULL
FROM emp
WHERE empno = 7566;


--Question 22
SELECT COUNT(product_name) FROM products_mgs;


--Question 29
SELECT COUNT(*) FROM student GROUP BY name
WHERE COUNT(*) > 2;


--Question 34
SELECT v.vendor_id, i.vendor_id
FROM vendors v RIGHT OUTER JOIN invoices i 
    ON (v.vendor_id = i.invoice_total);
    

--Question 30
select employee_id from employees, (select 1 from dual) t; --no error
select empno, avg(sal) from emp group by empno; --no error
select avg(sal) from emp group by empno; --no error
select empno, job, avg(sal) from emp group by empno; --ERROR
select empno from emp where salary > avg(sal); --ERROR


--Question 1
SELECT vendor_id
FROM vendors
WHERE NOT (vendor_id > 2000) AND (vendor_id >= 0);


--Question 12
SELECT last_name
FROM employees
WHERE last_name LIKE '_';


--Question 26
    (SELECT vendor_id FROM vendors)
MINUS
    (SELECT v.vendor_id
     FROM vendors v JOIN invoices i
     ON (v.vendor_id = i.vendor_id)); -- return 88
     
SELECT vendor_id FROM vendors
WHERE vendor_id NOT IN
    (SELECT vendor_id FROM invoices);
     
SELECT DISTINCT vendor_id FROM invoices; --34
SELECT DISTINCT vendor_id FROM vendors; --122


--Question 25
SELECT vendor_id, vendor_name
FROM vendors
WHERE vendor_name LIKE '%B%'
ORDER BY vendor_id;