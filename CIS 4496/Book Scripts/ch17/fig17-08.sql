SELECT TO_CHAR(download_timestamp, 'HH:MI:SS.FF AM') FROM downloads_tz WHERE download_id = 1;
SELECT TO_CHAR(download_timestamp, 'HH:MI:SS.FF3 AM') FROM downloads_tz WHERE download_id = 1;
SELECT TO_CHAR(download_timestamp, 'HH:MI:SS.FF9 AM TZH:TZM') FROM downloads_tz WHERE download_id = 1;
SELECT TO_CHAR(download_timestamp, 'HH:MI:SS.FF9 AM TZR') FROM downloads_tz WHERE download_id = 1;
SELECT TO_CHAR(download_timestamp, 'HH:MI:SS.FF9 AM TZD') FROM downloads_tz WHERE download_id = 1;
