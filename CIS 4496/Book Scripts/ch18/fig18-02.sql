-- use the EX connection
CONNECT ex/ex;

DROP TABLE product_reviews;

CREATE TABLE product_reviews
(
  product_id      NUMBER    PRIMARY KEY,
  product_review  CLOB
);

INSERT INTO product_reviews VALUES 
(1, TO_CLOB('Imagine this is a long string of characters.'));

INSERT INTO product_reviews VALUES 
(2, EMPTY_CLOB());

INSERT INTO product_reviews VALUES 
(3, NULL);

COMMIT;

SELECT product_id, product_review, 
       LENGTH(product_review) AS char_count
FROM product_reviews;