SELECT ROW_NUMBER() OVER(ORDER BY vendor_name) AS row_number, vendor_name
FROM vendors