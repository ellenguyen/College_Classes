-- if you followed the instructions in appendix A,
-- this table has already been created in the EX schema
CREATE TABLE ex.color_sample
(	
  color_id      NUMBER                        NOT NULL, 
  color_number  NUMBER          DEFAULT 0     NOT NULL, 
  color_name    VARCHAR2(10), 
  CONSTRAINT color_sample_pk PRIMARY KEY (color_id)
);
 