SELECT ROW_NUMBER() 
       OVER(PARTITION BY vendor_state ORDER BY vendor_name) 
       AS row_number, vendor_name, vendor_state
FROM vendors