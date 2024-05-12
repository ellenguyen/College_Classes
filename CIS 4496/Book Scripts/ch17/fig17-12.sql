-- use the EX connection
CONNECT ex/ex;

DROP TABLE interval_ds_sample;

CREATE TABLE interval_ds_sample
(
  interval_id            NUMBER                         PRIMARY KEY, 
  interval_value         INTERVAL DAY(3) TO SECOND(2)
);

INSERT INTO interval_ds_sample
VALUES (1, INTERVAL '1' DAY);

INSERT INTO interval_ds_sample
VALUES (2, INTERVAL '4' HOUR);

INSERT INTO interval_ds_sample
VALUES (3, INTERVAL '20' MINUTE);

INSERT INTO interval_ds_sample
VALUES (4, INTERVAL '31' SECOND);

INSERT INTO interval_ds_sample
VALUES (5, INTERVAL '31.45' SECOND);

INSERT INTO interval_ds_sample
VALUES (6, INTERVAL '1 4:20:31.45' DAY TO SECOND);

INSERT INTO interval_ds_sample
VALUES (7, INTERVAL '-1 4:20:31.45' DAY TO SECOND);

INSERT INTO interval_ds_sample
VALUES (8, INTERVAL '100 4:20:31.45' DAY(3) TO SECOND);

COMMIT;

SELECT * FROM interval_ds_sample;