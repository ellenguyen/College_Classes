--Exercise 7
--return entire column VENDOR_NAME from table VENDORS
SELECT vendor_name FROM vendors;

--Exercise 8
--return 5 columns below from table VENDORS arranged in alphabetical order
SELECT vendor_name, vendor_address1, vendor_city, vendor_state, vendor_zip_code
FROM vendors

--Exercise 9
--comment then uncomment ORDER BY
ORDER BY vendor_name;

--Exercise 10
--delete the e in vendor_zip_code -> cause invalid identifier

--Exercise 11
--return total number of invoices & the sum of total invoices
SELECT COUNT(*) AS number_of_invoices,
    SUM(invoice_total) AS grand_invoice_total
FROM invoices;

