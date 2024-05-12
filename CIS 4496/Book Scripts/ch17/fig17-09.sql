-- use the EX connection
CONNECT ex/ex;

-- Part 1 examples
SELECT SYSTIMESTAMP FROM dual;
SELECT CURRENT_TIMESTAMP FROM dual;
SELECT LOCALTIMESTAMP FROM dual;

SELECT SYSTIMESTAMP(2) FROM dual;

SELECT FROM_TZ(LOCALTIMESTAMP, 'EST') FROM dual;

SELECT SYS_EXTRACT_UTC(SYSTIMESTAMP) FROM dual;
SELECT SYS_EXTRACT_UTC(CURRENT_TIMESTAMP) FROM dual;

-- text examples
SELECT EXTRACT(YEAR FROM download_timestamp) AS download_year
FROM downloads;

SELECT EXTRACT(TIMEZONE_HOUR FROM download_timestamp) AS tz_hour
FROM downloads_tz;

-- Part 2 examples
SELECT TO_TIMESTAMP('15-AUG-14 4:20:47.123456 PM')
FROM dual;

SELECT TO_TIMESTAMP('2014-08-15 4:20:47.123456 PM', 
                    'YYYY-MM-DD HH:MI:SS.FF6 AM')
FROM dual;

SELECT TO_TIMESTAMP_TZ('15-AUG-14 4:20:47.123456 PM PST')
FROM dual;

SELECT TO_TIMESTAMP_TZ('2014-14-15 16:20:47.123456 PST', 
                       'YYYY-MM-DD HH24:MI:SS.FF6 TZR') 
FROM dual;

SELECT TO_CHAR(CURRENT_TIMESTAMP, 'DD-MON-RR HH:MI:SS.FF9 AM TZD') 
  AS time_zone_test
FROM dual;

SELECT TO_CHAR(download_timestamp, 'DD-MON-RR HH:MI:SS.FF AM TZD') 
  AS download_timestamp
FROM downloads_tz;