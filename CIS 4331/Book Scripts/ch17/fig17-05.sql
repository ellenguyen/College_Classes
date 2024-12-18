-- use the EX connection
CONNECT ex/ex;

DROP TABLE downloads;

CREATE TABLE downloads
(
  download_id         NUMBER        PRIMARY KEY,
  download_timestamp  TIMESTAMP(6)
);

INSERT INTO downloads
VALUES (1, TIMESTAMP '2014-08-15 16:20:47.123456');

INSERT INTO downloads
VALUES (2, TIMESTAMP '2014-08-15 16:20:47.1234567');

INSERT INTO downloads
VALUES (3, CURRENT_TIMESTAMP(6));

COMMIT;

SELECT * FROM downloads;