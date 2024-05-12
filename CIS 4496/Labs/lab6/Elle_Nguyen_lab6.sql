--Lab 6
--Elle Nguyen


--Q1
--Write a SELECT statement that is equivalent to the SELECT statement below, but don’t use a join.
--Instead, use a SUBQUERY in a WHERE clause that uses the IN operator.

--SELECT DISTINCT category_name
--FROM categories c JOIN products p
--ON c.category_id = p.category_id
--ORDER BY category_name;

SELECT category_name
FROM categories_mgs
WHERE category_id IN 
    (SELECT DISTINCT category_id
     FROM products_mgs)
ORDER BY category_name;


--Q2
--Print product name & actual price that is above the average actual price of all products.
--Actual price = price after discount with heading ACTUAL_PRICE.
--Sort with highest actual price first, use subquery.
SELECT product_name, (list_price - list_price * discount_percent / 100) AS actual_price
FROM products_mgs
WHERE (list_price - list_price * discount_percent / 100) > 
    (SELECT AVG(list_price - list_price * discount_percent / 100)
     FROM products_mgs)
ORDER BY actual_price DESC;


--Q3
--Print ids & names of all categories that currently don’t have any product, use subquery and NOT IN.
SELECT category_id, category_name
FROM categories_mgs
WHERE category_id NOT IN
    (SELECT category_id
     FROM products_mgs);
     
    
--Q4
--Print ids, codes, product names & actual prices of top 3 most expensive products
--based on actual price (price after discount) as ACTUAL_PRICE, use SUBQUERY in FROM clause.
SELECT *
FROM 
    (SELECT product_id, product_code, product_name, (list_price - list_price * discount_percent / 100) AS actual_price
     FROM products_mgs
     ORDER BY actual_price DESC)
WHERE ROWNUM <= 3;


--Q5
--Print ids, codes, product names, category names & actual prices of top 3 most expensive products
--based on actual price (price after discount) as ACTUAL_PRICE, use JOIN & SUBQUERY in FROM clause
SELECT *
FROM 
    (SELECT product_id, product_code, product_name, category_name, (list_price - list_price * discount_percent / 100) AS actual_price
     FROM categories_mgs c JOIN products_mgs p ON (c.category_id = p.category_id)
     ORDER BY actual_price DESC)
WHERE ROWNUM <= 3;


--Q6
--Print category ids & product counts of top 3 categories w most products.
--Use SUBQUERY in FROM clause, aggregation function for number of products in each category.
SELECT *
FROM 
    (SELECT category_id, COUNT(*) as product_count
     FROM products_mgs
     GROUP BY category_id
     ORDER BY product_count DESC)
WHERE ROWNUM <= 3;


--Q7
--Print name & discount percent of each product with unique discount percent.
--Don’t include products with same discount percent as another product.
--Sort in increasing alphabetical order of product names
--Use SUBQUERY in main WHERE clause
--aggregation function in subquery -> number of products in each discount percentage 
--                                 -> return those discount percentages w product count = 1
SELECT product_name, discount_percent
FROM products_mgs
WHERE discount_percent IN
    (SELECT discount_percent
     FROM products_mgs
     GROUP BY discount_percent
     HAVING COUNT(*) = 1)
ORDER BY product_name;


--Q8a
--Print email_address of each customer who placed an order, order_id & order total of each order placed by this customer.
--Sort in increasing alphabetical order of email addresses.
--Order total = total actual prices of all items in an order, actual price = price after discount. Email addresses are unique.
SELECT email_address, o.order_id, SUM((item_price - discount_amount) * quantity) as order_total
FROM customers_mgs c JOIN orders_mgs o ON (c.customer_id = o.customer_id)
    JOIN order_items_mgs i ON (o.order_id = i.order_id)
GROUP BY email_address, o.order_id
ORDER BY email_address;


--Q8b
--Use 1st query in FROM clause
--Main query returns email address of each customer and largest order total among all orders placed by this customer.
--Use MAX_ORDER_TOTAL for largest order totals in the result.
--Sort in increasing alphabetical order of email addresses.
SELECT email_address, MAX(order_total) as max_order_total
FROM 
    (SELECT email_address, o.order_id, SUM((item_price - discount_amount) * quantity) as order_total
     FROM customers_mgs c JOIN orders_mgs o ON (c.customer_id = o.customer_id)
        JOIN order_items_mgs i ON (o.order_id = i.order_id)
     GROUP BY email_address, o.order_id)
GROUP BY email_address
ORDER BY email_address;