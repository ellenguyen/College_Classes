-- use the EX connection
CONNECT ex/ex;

DROP TABLE downloads_tz;

CREATE TABLE downloads_tz
(
  download_id         NUMBER                    PRIMARY KEY,
  download_timestamp  TIMESTAMP WITH TIME ZONE
);

INSERT INTO downloads_tz
VALUES (1, TIMESTAMP '2014-08-15 16:20:47.123456789 PST');

INSERT INTO downloads_tz
VALUES (2, TIMESTAMP '2014-08-15 16:20:47.123456 US/Pacific');

INSERT INTO downloads_tz
VALUES (3, TIMESTAMP '2014-08-15 16:20:47.123456 -7:00');

INSERT INTO downloads_tz
VALUES (4, TIMESTAMP '2014-08-15 16:20:47.123456 EST');

INSERT INTO downloads_tz
VALUES (5, CURRENT_TIMESTAMP);

COMMIT;

SELECT * FROM downloads_tz;