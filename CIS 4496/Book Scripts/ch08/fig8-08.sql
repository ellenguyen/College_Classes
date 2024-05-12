-- Examples for dates
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS')) 
  AS "(none specified)"
FROM dual;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'DD-MON-YY') AS "DD-MON-YY"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'DD-MON-RR') AS "DD-MON-RR"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'DD-Mon-YY') AS "DD-Mon-YY"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'MM/DD/YY') AS "MM/DD/YY"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'YYYY-MM-DD') AS "YYYY-MM-DD"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'Dy Mon DD, YY') AS "Dy Mon DD, YY"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'MONTH DD, YYYY BC') AS "MONTH DD, YYYY BC"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'Month DD, YYYY B.C.') AS "Month DD, YYYY B.C."
FROM DUAL;

-- Examples for times
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'HH:MI') AS "HH:MI"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'HH24:MI') AS "HH24:MI"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'HH:MI AM') AS "HH:MI AM"
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'HH:MI A.M.') AS "HH:MI A.M."
FROM DUAL;
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'HH:MI:SS') AS "HH:MI:SS"
FROM DUAL;
SELECT
  TO_CHAR(TO_TIMESTAMP('19-AUG-2014 16:20:36.12345', 'DD-MON-YYYY HH24:MI:SS.FF5'),  
    'HH:MI:SS.FF5') AS "HH:MI:SS.FF5"
FROM DUAL;
SELECT
  TO_CHAR(TO_TIMESTAMP('19-AUG-2014 16:20:36.12345', 'DD-MON-YYYY HH24:MI:SS.FF5'),  
    'HH:MI:SS.FF4') AS "HH:MI:SS.FF4"
FROM DUAL;

-- An example for a date and time
SELECT
  TO_CHAR(TO_DATE('19-AUG-2014 16:20:36', 'DD-MON-YYYY HH24:MI:SS'),  
    'YYYY-MM-DD HH:MI:SS AM') AS "YYYY-MM-DD HH:MI:SS AM"
FROM DUAL;