-- use the EX connection
CONNECT ex/ex;

DROP TABLE product_images;

CREATE TABLE product_images
(
  product_id     NUMBER    PRIMARY KEY,
  product_image  BLOB
)
TABLESPACE users
LOB (product_image)
STORE AS product_image_lob_seg
(
  -- NOTE: The users_lobs tablespace must be created before you can use it.
  -- TABLESPACE users_lobs
  TABLESPACE users
  CHUNK 32768
  DISABLE STORAGE IN ROW
  CACHE READS LOGGING
  PCTVERSION 20
);

INSERT INTO product_images VALUES 
(1, TO_BLOB('1010101010101010101010101010101010'));

INSERT INTO product_images VALUES 
(2, EMPTY_BLOB());

INSERT INTO product_images VALUES 
(3, NULL);

COMMIT;

SELECT product_id, product_image, 
       LENGTH(product_image) AS byte_count
FROM product_images;

-- clean up
DELETE FROM product_images;