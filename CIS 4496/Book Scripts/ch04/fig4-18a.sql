-- use the EX connection
    SELECT customer_first_name, customer_last_name
    FROM customers
MINUS
    SELECT first_name, last_name
    FROM employees
ORDER BY customer_last_name