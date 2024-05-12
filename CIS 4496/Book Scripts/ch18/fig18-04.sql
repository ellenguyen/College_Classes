-- use the EX connection
CONNECT ex/ex;

DROP TABLE product_images_2;
DROP DIRECTORY product_dir;

CREATE TABLE product_images_2
(
  product_id     NUMBER    PRIMARY KEY,
  product_image  BFILE
);

CREATE DIRECTORY product_dir AS 'C:/murach/oracle_sql/java/ch18files';

INSERT INTO product_images_2 VALUES 
(1, BFILENAME('product_dir', '8601_cover.jpg'));

INSERT INTO product_images_2 VALUES 
(2, BFILENAME('product_dir', 'jr01_cover.jpg'));

INSERT INTO product_images_2 VALUES 
(3, NULL);

COMMIT;

SELECT product_id, product_image
FROM product_images_2;