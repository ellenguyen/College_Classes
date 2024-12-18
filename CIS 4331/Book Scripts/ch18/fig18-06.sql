-- use the EX connection
CONNECT ex/ex;

DROP TABLE product_images_3;

CREATE TABLE product_images_3
(
  product_id     NUMBER    PRIMARY KEY,
  product_image  LONG RAW
);

INSERT INTO product_images_3 VALUES 
(1, '1010101010101010101010101010101010');

INSERT INTO product_images_3 VALUES 
(2, '1010101010101010101010101010101010');

COMMIT;

ALTER TABLE product_images_3 MODIFY (product_image BLOB);

SELECT product_id, product_image, 
       LENGTH(product_image) AS byte_count
FROM product_images_3;

-- clean up
-- DELETE FROM product_images_3;