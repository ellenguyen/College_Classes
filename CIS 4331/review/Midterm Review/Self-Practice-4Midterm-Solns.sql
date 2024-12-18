--Solution to Self-Practice for Midterm Preparation

--Run these queries as user UV

--Q1.
SELECT id || ' ' || name  biology_instructors
FROM   instructor
WHERE  dept_name = 'Biology';

--Q2.
SELECT title "3-Credit CS Courses"
FROM   course
WHERE dept_name = 'Comp. Sci.' AND credits = 3;

--Q3.
SELECT  c.course_id, title
FROM    takes t JOIN course c ON (t.course_id = c.course_id) 
WHERE   id = '12345';

--Q4.
SELECT  SUM(credits) total_credits
FROM    takes t JOIN course c ON (t.course_id = c.course_id) 
WHERE   id = '12345';

--Q5
SELECT  id, SUM(credits) total_credits
FROM    takes t JOIN course c ON (t.course_id = c.course_id) 
GROUP BY id;

--Q6
SELECT DISTINCT s.name
FROM   takes t JOIN student s ON (t.id = s.id)
	    JOIN course c ON (t.course_id = c.course_id)
WHERE  c.dept_name = 'Comp. Sci.';

SELECT DISTINCT s.name, s.dept_name
FROM   takes t JOIN student s ON (t.id = s.id)
	    JOIN course c ON (t.course_id = c.course_id)
WHERE  c.dept_name = 'Comp. Sci.';

--Q7
SELECT i.id, name, course_id
FROM instructor i LEFT JOIN teaches t 
       ON (i.id = t.id)
WHERE dept_name = 'Physics';

--Q8a
SELECT i.id, name
FROM instructor i LEFT JOIN teaches t 
       ON (i.id = t.id)
WHERE t.course_id IS NULL;
 
--Q8b
  (SELECT id, name
   FROM  instructor)
MINUS
  (SELECT i.id, i.name  
   FROM teaches t JOIN instructor i
       ON (t.id = i.id)
  );
 
--Q9
SELECT name, COUNT(*) how_many_courses
FROM instructor i JOIN teaches t
       ON (i.id = t.id)
GROUP BY name --or GROUP BY i.id, name
ORDER BY name;

--Q10
SELECT name, COUNT(*) how_many_courses
FROM instructor i JOIN teaches t
       ON (i.id = t.id)
GROUP BY name
HAVING COUNT(*) >= 2
ORDER BY name;

--Run this query as user ap

--Q11
SELECT DISTINCT gl.account_number, account_description 
FROM  general_ledger_accounts gl JOIN invoice_line_items il 
       ON (gl.account_number = il.account_number)
WHERE account_description LIKE '%Advertising'
ORDER BY gl.account_number;
