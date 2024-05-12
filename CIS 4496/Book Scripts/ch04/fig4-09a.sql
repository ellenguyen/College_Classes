-- Use the EX connection to run this statement
SELECT department_name AS dept_name, 
    d.department_number AS dept_no,
    last_name
FROM departments d 
    LEFT JOIN employees e
    ON d.department_number =
       e.department_number
ORDER BY department_name