SELECT * FROM date_sample
WHERE TO_CHAR(start_date, 'HH24:MI:SS') >= '09:00:00'
  AND TO_CHAR(start_date, 'HH24:MI:SS')  < '12:59:59'
