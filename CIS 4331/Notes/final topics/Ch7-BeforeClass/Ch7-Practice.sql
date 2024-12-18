--Ch7 Practice

--Q1
--For vendors with default terms id 2, 
-- change the terms ids of their invoices to 2.
UPDATE invoices
SET terms_id = 2
WHERE vendor_id IN
    (SELECT vendor_id
     FROM vendors
     WHERE default_terms_id = 2);


--Q2
--Undo the changes made in Q1
ROLLBACK;

--Q3
--Make the changes in Q1 permanent 
UPDATE invoices
SET terms_id = 2
WHERE vendor_id IN
    (SELECT vendor_id
     FROM vendors
     WHERE default_terms_id = 2);
    
COMMIT;

