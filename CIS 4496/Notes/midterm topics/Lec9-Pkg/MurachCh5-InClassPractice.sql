--Week 5, Murach Ch5 in class practice.

--Covered topics: GROUP BY, HAVING, WHERE in summary queries

--Run all queries as user AP

--1.
--For each vendor that has at least one invoice, print its vendor id, 
--   and total invoice amount of all invoices for this vendor.
SELECT vendor_id, SUM(invoice_total) AS invoice_total_sum
FROM invoices
GROUP BY vendor_id;


--2.
--For each vendor that has at least one invoice, print its name, 
--  the total payment amount of all its invoices.
--Sort the result in decreasing order of the total payment amount.
SELECT vendor_name, SUM(payment_total) AS total_payment_amt
FROM vendors v JOIN invoices i
    ON (v.vendor_id = i.vendor_id)
GROUP BY v.vendor_id, v.vendor_name
ORDER BY total_payment_amt DESC;


--3.
--For each vendor that has at least one invoice, print its name, 
--   invoice quantity, and total invoice amount of all its invoices.
--Sort the query result so that the vendor with most invoices appear first.
--Display headings INVOICE_COUNT, TOTAL_INVOICE_AMT for invoice quantiy, 
--  and total invoice amount.
SELECT vendor_name, COUNT(*) AS invoice_count, SUM(invoice_total) AS total_invoice_amt
FROM vendors v JOIN invoices i
    ON (v.vendor_id = i.vendor_id)
GROUP BY v.vendor_id, v.vendor_name
ORDER BY invoice_count DESC;


--4.
--For each general ledger account that is used by at least 2 invoice items, 
--  print its account description, how many invoice items use this account,
--  and the total item amount of all these items.
--Sort the result so that the account with the largest total item amount appears first.
--Display headins LINE_ITEM_COUNT, TOTAL_LINE_ITEM_AMT for invoice item quantity, 
--   and total item amount.
SELECT account_description, COUNT(*) AS line_item_count, SUM(line_item_amt) AS total_line_item_amt
FROM general_ledger_accounts gla JOIN invoice_line_items ili
    ON (gla.account_number = ili.account_number)
GROUP BY gla.account_number, account_description
HAVING COUNT(*) >= 2
ORDER BY total_line_item_amt DESC;