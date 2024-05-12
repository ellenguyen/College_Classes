SELECT * FROM date_sample
WHERE start_date >= TO_DATE('09:00:00', 'HH24:MI:SS')
  AND start_date  < TO_DATE('12:59:59', 'HH24:MI:SS')
