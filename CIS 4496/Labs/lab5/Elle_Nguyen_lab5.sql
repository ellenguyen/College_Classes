--Lab 5
--Elle Nguyen


--Q1
--Print the total number of orders and their total tax amount.
--Use the headings ORDER_COUNT, TOTAL_TAX in the query result.
SELECT COUNT(*) AS order_count, SUM(tax_amount) AS total_tax
FROM orders_mgs;


--Q2
--How many orders are paid by Visa cards, and what is the total tax amount of these orders?
--Use a single query to get both answers.
--Use the headings VISA_ORDER_COUNT, VISA_TOTAL_TAX in the query result.
SELECT COUNT(*) AS visa_order_count, SUM(tax_amount) AS visa_total_tax
FROM orders_mgs
WHERE card_type = 'Visa';


--Q3
--For each type of credit cards, print the card type, the total number of orders paid by credit cards of this
--type, and the total tax amount of such orders for this card type.
--Use the headings CARD_TYPE, CARD_ORDER_COUNT, CARD_TOTAL_TAX in the query result.
SELECT card_type, COUNT(*) AS card_order_count, SUM(tax_amount) AS card_total_tax
FROM orders_mgs
GROUP BY card_type;


--Q4
--For each product category, print the category name, the number of products in this category, the highest
--listing price of products in this category, and the lowest listing price of products in this category.
--Use the headings CATEGORY_NAME, PRODUCT_COUNT, HIGHEST_LISTING_PRICE, and LOWEST_LISTING_PRICE in the query result.
SELECT category_name, COUNT(*) AS product_count, 
        MAX(list_price) AS highest_listing_price,
        MIN(list_price) AS lowest_listing_price
FROM products_mgs p JOIN categories_mgs c ON (p.category_id = c.category_id)
GROUP BY p.category_id, category_name;


--Q5
--Rewrite the query in Question 4 such that only products with listing prices more than $400 are included in the query result.
--In another word, for each product category, print the category name, the number of products in this
--category with listing prices more than $400, the highest listing price of such products in this category, and
--the lowest listing price of such products in this category.
--Use the headings CATEGORY_NAME, PRODUCT_COUNT_OVER$400, HIGHEST_LISTING_PRICE_OVER$400,
--and LOWEST_LISTING_PRICE_OVER$400 in the query result.
SELECT category_name, COUNT(*) AS product_count_over$400, 
        MAX(list_price) AS highest_listing_price_over$400,
        MIN(list_price) AS lowest_listing_price_over$400
FROM products_mgs p JOIN categories_mgs c ON (p.category_id = c.category_id)
WHERE p.list_price > 400
GROUP BY p.category_id, category_name;


--Q6
--Rewrite the query in Question 3 such that only credit card types with at least 2 orders are printed.
--In another word, for each type of credit cards with at least 2 orders, print the card type, the total number
--of orders paid by credit cards of this type, and the total tax amount of such orders for this card type.
--Use the headings CARD_TYPE, HOT_CARD_ORDER_COUNT, and HOT_CARD_TOTAL_TAX in the query result.
SELECT card_type, COUNT(*) AS hot_card_order_count, SUM(tax_amount) AS hot_card_total_tax
FROM orders_mgs
GROUP BY card_type
HAVING COUNT(*) >= 2;


--Q7
--Rewrite the query in Question 4 such that only categories with at least 3 products are included in the query result.
--In another word, for each category with at least 3 products, print the category name, the number of
--products in this category, the highest listing price of products in this category, and the lowest listing price
--of products in this category. Use the headings CATEGORY_NAME, HOT_CAT_PRODUCT_COUNT, HOT_CAT_HIGHEST_LISTING_PRICE,
--and HOT_CAT_LOWEST_LISTING_PRICE in the query result.
SELECT category_name, COUNT(*) AS hot_cat_product_count, 
        MAX(list_price) AS hot_cat_highest_listing_price,
        MIN(list_price) AS hot_cat_lowest_listing_price
FROM products_mgs p JOIN categories_mgs c ON (p.category_id = c.category_id)
GROUP BY p.category_id, category_name
HAVING COUNT(*) >= 3;


--Q8
--Rewrite the query in Question 3 such that only orders dated after March 30 2012 are included in the query result.
--In another word, for each type of credit cards with at least 2 orders dated after March 30 2012 and paid by
--credit cards of this card type, print the card type, the count of such orders, and the total tax amount of
--such orders for this credit card type. Use headings CARD_TYPE, HOT_CARD_ORDER_COUNT, HOT_CARD_ TOTAL_TAX in the query result.
SELECT card_type, COUNT(*) AS hot_card_order_count, SUM(tax_amount) AS hot_card_total_tax
FROM orders_mgs
WHERE order_date > '30-MAR-12'
GROUP BY card_type
HAVING COUNT(*) >= 2;