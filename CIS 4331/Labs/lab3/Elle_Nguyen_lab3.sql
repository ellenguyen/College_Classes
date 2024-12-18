--Lab 3
--Elle Nguyen


--Q1
--Print the IDs, street addresses (including apartment number and suite number),
--cities, and states of customers whose street addresses contains “wood”.
--Sort the query result first in the increasing order of states, then increasing order of cities.
SELECT customer_id, line1, line2, city, state
FROM addresses_mgs
WHERE line1 LIKE 'Wood%' OR line1 LIKE '%wood%' or line1 LIKE '%_wood'
ORDER BY state, city;


--Q2
--Print the first names, last names, and email addresses of customers who have r
--as the third letter in their first names. Sort the result in the increasing order of first names.
SELECT first_name, last_name, email_address
FROM customers_mgs
WHERE first_name LIKE '%__r_%'
ORDER BY first_name;


--Q3
--Print the names, listing prices, and category names of all products.
--Sort the result first in the increasing order of category name,
--and then in the increasing order of product names.
SELECT p.product_name, p.list_price, c.category_name
FROM products_mgs p INNER JOIN categories_mgs c
    ON (p.category_id = c.category_id)
ORDER BY c.category_name, p.product_name;


--Q4
--Print the first name, last name, and all the postal addresses of the customer whose email address is
--heatheresway@mac.com. Print all components of an address: street address (including apartment
--number and suite number), city, state, and zip code.
SELECT c.first_name, c.last_name, a.line1, a.line2, a.city, a.state, a.zip_code
FROM addresses_mgs a LEFT JOIN customers_mgs c
    ON (a.address_id = c.shipping_address_id)
    OR (a.address_id = c.billing_address_id)
WHERE c.email_address LIKE '%heatheresway@mac.com%';


--Q5
--Print the first names, last names, billing addresses of all customers.
--Sort the result first in the increasing order of states, then in the increasing order of cities.
--Print all components of an address: street address
--(including apartment number and suite number), city, state, and zip code.
SELECT c.first_name, c.last_name, a.line1, a.line2, a.city, a.state, a.zip_code
FROM addresses_mgs a RIGHT JOIN customers_mgs c
    ON (a.address_id = c.billing_address_id)
ORDER BY a.state, a.city;


--Q6
--Print all customers’ first names, last names, the dates when they placed their orders, and the dates when
--their orders were shipped. Print the heading for the dates as SHIP_DATE, ORDER_DATE.
--Print all dates in the following format: 03/31/2012.
SELECT c.first_name, c.last_name,
        TO_CHAR(o.order_date, 'MM/DD/YYYY') AS ship_date,
        TO_CHAR(o.ship_date, 'MM/DD/YYYY') AS order_date
FROM customers_mgs c JOIN orders_mgs o
    ON (c.customer_id = o.customer_id);
   
 
--Q7
--Print customers’ email addresses, the dates when their orders were shipped, the product id and the actual
--price (after the discount) of each product they ordered. Print the heading for the actual price as ACTUAL_PRICE.
SELECT c.email_address, o.ship_date, i.product_id,
        (i.item_price - i.discount_amount) AS actual_price
FROM customers_mgs c JOIN orders_mgs o ON (c.customer_id = o.customer_id)
    JOIN order_items_mgs i ON (o.order_id = i.order_id);
    

--Q8
--Print the product code, name, and discount percentage of each product that has the same discount
--percentage as another product. Do not print a product more than once.
--Sort the query result in the increasing order of product codes.
SELECT DISTINCT p1.product_code, p1.product_name, p1.discount_percent
FROM products_mgs p1 JOIN products_mgs p2
    ON (p1.product_id <> p2.product_id)
    AND (p1.discount_percent = p2.discount_percent)
ORDER BY p1.product_code;