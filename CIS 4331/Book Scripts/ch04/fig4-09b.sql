SELECT department_name AS dept_name, 
    e.department_number AS dept_no,
    last_name
FROM departments d 
    RIGHT JOIN employees e
    ON d.department_number = 
       e.department_number
ORDER BY department_name