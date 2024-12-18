SELECT department_name AS dept_name, 
    emp.department_number AS dept_no,
    last_name
FROM departments dpt, employees emp
WHERE dpt.department_number (+) = emp.department_number
ORDER BY department_name 
