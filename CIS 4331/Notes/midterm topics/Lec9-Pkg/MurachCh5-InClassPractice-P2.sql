--Murach Ch5 in class practice 
--Part 2

--Continued
--Covered topics: GROUP BY, HAVING, WHERE in summary queries

--Run all queries as user AP

--5.
--Revise Q4 query so that only accounts used in invoices dated in the second quarter 
--of 2014 are printed.
SELECT account_description, COUNT(*) AS line_item_count, SUM(line_item_amt) AS total_line_item_amt
FROM general_ledger_accounts gla JOIN invoice_line_items ili ON (gla.account_number = ili.account_number)
    JOIN invoices i ON (ili.invoice_id = i.invoice_id)
WHERE invoice_date BETWEEN '01-APR-14' AND '30-JUN-14'
GROUP BY gla.account_number, account_description
HAVING COUNT(*) >= 2
ORDER BY total_line_item_amt DESC;


--6.
--For each vendor being paid from at least 2 different general ledger accounts,
--  print its name, and how many different accounts are applied to this vendor's invoices.

-- need distinct keyword inside to count different account nums
SELECT vendor_name, COUNT(DISTINCT account_number) AS diff_acct_count
FROM vendors v JOIN invoices i ON (v.vendor_id = i.vendor_id)
    JOIN invoice_line_items ili ON (i.invoice_id = ili.invoice_id)
GROUP BY v.vendor_id, vendor_name
HAVING COUNT(DISTINCT account_number) >= 2;