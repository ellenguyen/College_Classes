SELECT department_name, last_name, 
    project_number AS proj_no
FROM departments d
    FULL JOIN employees e
        ON d.department_number = 
           e.department_number
    FULL JOIN projects p
        ON e.employee_id = 
           p.employee_id
ORDER BY department_name
