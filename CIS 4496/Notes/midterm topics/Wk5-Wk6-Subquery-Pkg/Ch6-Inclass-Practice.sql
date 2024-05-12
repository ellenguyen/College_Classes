--Murach Ch6 In class practice

--Q1 
--convert query below to a query containing a subquery.
SELECT DISTINCT vendor_name
FROM vendors v  JOIN invoices i ON (v.vendor_id = i.vendor_id)
ORDER BY vendor_name;

SELECT vendor_name
FROM vendors
WHERE vendor_id in 
    (SELECT vendor_id
     FROM invoices)
ORDER BY vendor_name;


--Q2
--print invoice numbers, invoice amounts of invoices with a payemnt amount more than
--   the average payment amount of all paid invoices.
--  paid invoice: customer made a payment.
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total > 
    (SELECT AVG(payment_total)
     FROM invoices
     WHERE payment_date IS NOT NULL);


--3.
--For each invoice that has more than one item, print its vendor name, invoice id, 
--  invoice number, and the item amount of each item in this invoice. 
--Do this using a subquery.
 


--4.
--Print the name, city, and state of each vendor that's located in a unique city and state.
-- i.e. exclude vendors that have a city and state in common with another vendor.
--Do this using a subquery.



--5.
--For the top 5 largest outstanding invoices with most balance due amounts, 
--  print their invoice ids, invoice numbers, vendor ids and balance dues.
--Do this using an inline view.
-- outstanding invoices: invoices whose balance dues are positive




--6.
--Redo Q5 using subquery factoring.


