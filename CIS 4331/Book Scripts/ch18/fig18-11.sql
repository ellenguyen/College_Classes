-- use the EX connection
CONNECT ex/ex;

CREATE OR REPLACE PROCEDURE compare_blobs
(
  blob1           IN OUT NOCOPY  BLOB,
  blob2           IN OUT NOCOPY  BLOB,
  compare_result  OUT            NUMBER
)
AS
  blob1_offset NUMBER := 1;
  blob2_offset NUMBER := 1;
  buffer_size NUMBER := 32768;
BEGIN
  compare_result := DBMS_LOB.COMPARE(blob1, blob2, buffer_size, 
                                     blob1_offset, blob2_offset);  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;

DECLARE
  image1          BLOB;
  image2          BLOB;
  compare_result  NUMBER;
BEGIN
  SELECT product_image
  INTO image1
  FROM product_images
  WHERE product_id = 1;
  
  SELECT product_image
  INTO image2
  FROM product_images
  WHERE product_id = 2;
  
  compare_blobs(image1, image2, compare_result);
  
  IF compare_result = 0 THEN
    DBMS_OUTPUT.PUT_LINE('The two images are the same');
  ELSE
    DBMS_OUTPUT.PUT_LINE('The two images are NOT the same');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/