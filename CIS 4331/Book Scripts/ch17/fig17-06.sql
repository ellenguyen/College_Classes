-- use the EX connection
CONNECT ex/ex;

DROP TABLE downloads_ltz;

CREATE TABLE downloads_ltz
(
  download_id         NUMBER                            PRIMARY KEY,
  download_timestamp  TIMESTAMP WITH LOCAL TIME ZONE
);

INSERT INTO downloads_ltz
VALUES (1, TIMESTAMP '2014-08-15 16:20:47.123456 PST');

INSERT INTO downloads_ltz
VALUES (2, TIMESTAMP '2014-08-15 16:20:47.123456 EST');

INSERT INTO downloads_ltz
VALUES (3, TIMESTAMP '2014-08-15 16:20:47.123456 -7:00');

INSERT INTO downloads_ltz
VALUES (4, CURRENT_TIMESTAMP);

COMMIT;

SELECT * FROM downloads_ltz;