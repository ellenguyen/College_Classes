SELECT terms_description, 
    NTILE(2) OVER (ORDER BY terms_id) AS tile2, 
    NTILE(3) OVER (ORDER BY terms_id) AS tile3, 
    NTILE(4) OVER (ORDER BY terms_id) AS tile4 
FROM terms
