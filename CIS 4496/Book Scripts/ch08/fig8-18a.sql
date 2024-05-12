-- this statement displays the Date_Sample table
SELECT date_id, 
       TO_CHAR(start_date, 'DD-MON-YYYY HH24:MI:SS') AS start_date
FROM date_sample