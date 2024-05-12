SELECT departments.department_number, department_name, employee_id, 
    last_name
FROM departments, employees
ORDER BY departments.department_number