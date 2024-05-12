--Week 4, Murach Ch4, In Class Practice

--Covered topics: OUTER JOIN, Set operators in SQL

--continued from Lec 6
  

--RUN all queries in 7, 8, 9 as user uv

--7.
--Print ids, names of students who took CS-101 or CS-190.
--Must use a SQL set operator.
    SELECT s.id, s.name
    FROM student s JOIN takes t
        ON (s.id = t.id)
    WHERE course_id = 'CS-101' 
UNION
    SELECT s.id, s.name
    FROM student s JOIN takes t
        ON (s.id = t.id)
    WHERE course_id = 'CS-190';

--8.
--Print ids, names of students who took both CS-101 and CS-190.
--Must use a SQL set operator.
    SELECT s.id, s.name
    FROM student s JOIN takes t
        ON (s.id = t.id)
    WHERE course_id = 'CS-101'
INTERSECT
    SELECT s.id, s.name
    FROM student s JOIN takes t
        ON (s.id = t.id)
    WHERE course_id = 'CS-190';

  
--9.
--print ids, names of students who took CS-101 but not CS-190.
--Must use a SQL set operator.
    SELECT s.id, s.name
    FROM student s JOIN takes t
        ON (s.id = t.id)
    WHERE course_id = 'CS-101'
MINUS
    SELECT s.id, s.name
    FROM student s JOIN takes t
        ON (s.id = t.id)
    WHERE course_id = 'CS-190';
 

  
--10.
--Use a SQL set operator to print names and states of all vendors.
--Print the state name of vendors not in California as Outside CA.
--Sorted in increasing order of vendor states.
--
--VENDOR_NAME                   VENDOR_STATE
-------------------------------------------------
--ASC Signs	                CA
--AT&T	Outside                 CA
--Abbey Office Furnishings	CA
--American Booksellers Assoc	Outside CA
--COSTCO FL                     Outside CA
--......
    SELECT vendor_name, 'CA' AS vendor_state
    FROM vendors
    WHERE vendor_state = 'CA'
UNION
    SELECT vendor_name, 'Outside CA' AS vendor_state
    FROM vendors
    WHERE vendor_state <> 'CA'
ORDER BY vendor_state;


--11.
--Rewrite the outer join in Question 6 using a SQL set operator.



