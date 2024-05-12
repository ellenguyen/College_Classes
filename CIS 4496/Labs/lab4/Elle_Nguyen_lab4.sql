
--Lab 4
--Elle Nguyen


--Q1
--For each category that has at least one product, print its id, name, 
--and the id and name of each product in that category.
--Sort the result in the increasing order of category ids.
SELECT c.category_id, c.category_name, p.product_id, p.product_name
FROM categories_mgs c JOIN products_mgs p
    ON (c.category_id = p.category_id)
ORDER BY c.category_id;


--Q2
--For each product category, print its id, name, and the id and name of each product in that category.
--The query result includes ALL categories (those with some products and those without any product).
--Sort the result in the increasing order of category ids.
SELECT c.category_id, c.category_name, p.product_id, p.product_name
FROM categories_mgs c FULL OUTER JOIN products_mgs p
    ON (c.category_id = p.category_id)
ORDER BY c.category_id;


--Q3
--Print the id and name of each category to which NO product currently belongs.
--Sort the result in the increasing order of category ids.
SELECT c.category_id, c.category_name
FROM categories_mgs c LEFT OUTER JOIN products_mgs p
    ON (c.category_id = p.category_id)
WHERE p.category_id IS NULL
ORDER BY c.category_id;


--Q4
--Print the id, first name, and last name of each customer who has a gmail account
--and uses one address for both shipping and billing.
--Sort the result in the increasing order of customer ids.
    SELECT customer_id, first_name, last_name
    FROM customers_mgs
    WHERE email_address LIKE '%_@gmail.com'
INTERSECT
    SELECT customer_id, first_name, last_name
    FROM customers_mgs
    WHERE shipping_address_id = billing_address_id
ORDER BY customer_id;


--Q5
--Print the id, first name, and last name of each customer who uses one address
--for both shipping and billing but does not have a gmail account.
--Sort the result in increasing order of customer ids.
    SELECT customer_id, first_name, last_name
    FROM customers_mgs
    WHERE email_address NOT LIKE '%_@gmail.com'
INTERSECT
    SELECT customer_id, first_name, last_name
    FROM customers_mgs
    WHERE shipping_address_id = billing_address_id
ORDER BY customer_id;


--Q6
--Print the id, first name, and last name of each customer who has a gmail account
--or (meaning inclusive or) uses one address for both shipping and billing.
--Sort the result in the increasing order of customer ids.
    SELECT customer_id, first_name, last_name
    FROM customers_mgs
    WHERE email_address LIKE '%_@gmail.com'
UNION
    SELECT customer_id, first_name, last_name
    FROM customers_mgs
    WHERE shipping_address_id = billing_address_id
ORDER BY customer_id;


--Q7
--Print the order id, customer id, shipping status, and order date of each order.
--If an order has a specific ship date, display the shipping status as Shipped.
--Otherwise, display the shipping status as NOT Shipped.
--Sort the result in the increasing order of order dates.
    SELECT order_id, customer_id, 'Shipped' AS ship_status, order_date
    FROM orders_mgs
    WHERE ship_date IS NOT NULL
UNION
    SELECT order_id, customer_id, 'NOT Shipped' AS ship_status, order_date
    FROM orders_mgs
    WHERE ship_date IS NULL
ORDER BY order_date;