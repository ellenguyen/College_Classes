SELECT department_name AS dept_name, 
    d.department_number AS d_dept_no,
    e.department_number AS e_dept_no, 
    last_name
FROM departments d 
    FULL JOIN employees e
    ON d.department_number =
       e.department_number
ORDER BY department_name