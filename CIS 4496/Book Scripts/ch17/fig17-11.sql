-- use the EX connection
CONNECT ex/ex;

DROP TABLE interval_ym_sample;

CREATE TABLE interval_ym_sample
(
  interval_id            NUMBER                       PRIMARY KEY, 
  interval_value         INTERVAL YEAR(3) TO MONTH
);

INSERT INTO interval_ym_sample
VALUES (1, INTERVAL '1' YEAR);

INSERT INTO interval_ym_sample
VALUES (2, INTERVAL '3' MONTH);

INSERT INTO interval_ym_sample
VALUES (3, INTERVAL '15' MONTH);

INSERT INTO interval_ym_sample
VALUES (4, INTERVAL '1-3' YEAR TO MONTH);

INSERT INTO interval_ym_sample
VALUES (5, INTERVAL '-1-3' YEAR TO MONTH);

INSERT INTO interval_ym_sample
VALUES (6, INTERVAL '100' YEAR(3));

COMMIT;

SELECT * FROM interval_ym_sample;