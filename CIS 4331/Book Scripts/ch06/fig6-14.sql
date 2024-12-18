-- use the EX connection
SELECT employee_id,
   first_name || ' ' || last_name AS employee_name,
   LEVEL
FROM employees
START WITH employee_id = 1
CONNECT BY PRIOR employee_id = manager_id
ORDER BY LEVEL, employee_id