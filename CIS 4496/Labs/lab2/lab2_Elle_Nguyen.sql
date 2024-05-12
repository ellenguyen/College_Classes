--Lab 2
--Elle Nguyen


--Q1
--Print the product ids, product names, and discount percentages of all products. 
--Sort the result first in the increasing order of discount percentages, then the increasing order of product ids.
SELECT product_id, product_name, discount_percent
FROM products_mgs
ORDER BY discount_percent, product_id;


--Q2
--Print the full names of all customers whose last names begin with letters from 'B' to 'T' in the decreasing order of last names.
--Display the query result in the following format:
--Heading of the query result: Customer Name
--Data format: last name, then a comma and a space, then first name, like below: Trump, Donald
SELECT last_name || ', ' || first_name AS "Customer Name"
FROM customers_mgs
WHERE last_name BETWEEN 'B' AND 'T'
ORDER BY last_name DESC;


--Q3
--Print the product codes, discount percentages, and dates when the products were added for products whose discount percentages are at least 20% and at most 30%.
--Print the products added last (i.e. the latest product) first, the products added earliest (i.e. the oldest product) last.
SELECT product_code, discount_percent, date_added
FROM products_mgs
WHERE discount_percent BETWEEN 20 AND 30
ORDER BY date_added DESC;


--Q4
--Print at most 3 products’ names, listing prices, the actual prices after discounts in the decreasing order of the actual prices in the format below.
--These 3 products are NOT necessarily the 3 most expensive products.
SELECT product_name || ' was $' || list_price || ', now is $' || (list_price - list_price * discount_percent / 100)
    AS "Product Price Info"
FROM products_mgs
WHERE ROWNUM <= 3
ORDER BY list_price DESC;


--Q5
--For each item with a total discount amount more than $600, print this item’s item id, unit price before
--discount, unit discount amount, total price before discount, and total discount amount.
--Display the total price before discount as TOTAL_PRICE_BEFORE_DISCOUNT, the total discount amount as TOTAL_DISCOUNT_AMOUNT.
--Sort the query result in the decreasing order of the total discount amounts.
SELECT * FROM (SELECT item_id, item_price, discount_amount,
                (item_price * quantity) AS total_price_before_discount,
                (discount_amount * quantity) AS total_discount_amount FROM order_items_mgs)
WHERE total_discount_amount > 600
ORDER BY total_discount_amount DESC;


--Q6
--Print the order ids, customer ids, dates when orders were placed, and the shipping amounts for all orders whose shipping dates are unknown.
SELECT order_id, customer_id, order_date, ship_amount
FROM orders_mgs
WHERE ship_date IS NULL;


--Q7
--Print a greeting message like below. You must print the heading as is and print the date value as the date
--when the query is executed. It means that if you run the query on different dates, then the date value in
--the query result will change. So the date value in the output below is for reference purpose.
SELECT 'Hello! Today is ' || TO_CHAR(SYSDATE, 'Mon-DD-YYYY') AS GREETING
FROM dual;


--Q8
--Given an ipad at $799.99, the tax rate 8%, print the price before tax, tax rate, tax amount, the price after
--tax like below. Your query must use the computer to calculate the tax amount and price after tax.
SELECT 799.99 AS price_before_tax, 0.08 AS tax_rate, 
        (799.99 * 0.08) AS tax_amount, (799.99 + 799.99 * 0.08) AS price_after_tax
FROM dual;


--Q9
--Print the product id, the unit price before the discount, and the discount amount of each product that was ordered. 
--If a product was ordered more than once, print its information only once.
--Sort the result in the decreasing order of the unit price before the discount.
SELECT DISTINCT product_id, item_price, discount_amount
FROM order_items_mgs
ORDER BY item_price DESC;