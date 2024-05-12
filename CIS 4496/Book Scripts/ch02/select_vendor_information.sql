--Exercise 16
--after running 1st statement: return 2 columns below from table VENDORS restricting vendor_id as 34
SELECT vendor_name, vendor_city
FROM vendors
WHERE vendor_id = 34;

--after running 2nd statement: return 2 columns storing total number of invoices 
--and the sum of remaining amount restricting vendor_id as 34
SELECT COUNT(*) AS number_of_invoices,
    SUM(invoice_total - payment_total - credit_total) AS total_due
FROM invoices
WHERE vendor_id = 34;