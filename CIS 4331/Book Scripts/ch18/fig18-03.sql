-- use the EX connection
CONNECT ex/ex;

DROP TABLE product_images;

CREATE TABLE product_images
(
  product_id     NUMBER    PRIMARY KEY,
  product_image  BLOB
);

INSERT INTO product_images VALUES 
(1, TO_BLOB('0123456789ABCDEF0123456789ABCDEF'));

INSERT INTO product_images VALUES 
(2, EMPTY_BLOB());

INSERT INTO product_images VALUES 
(3, NULL);

COMMIT;

SELECT product_id, product_image, 
       LENGTH(product_image) AS byte_count
FROM product_images;

-- clean up
-- DELETE FROM product_images;