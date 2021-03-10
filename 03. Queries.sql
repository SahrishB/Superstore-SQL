-- (1) Find the customers from different regions who ordered products from different categories 
-- through the first class mode with total sales more than 5000

SELECT customer_name,
       region,
       category,
       order_date,
       Round(Sum(sales)) AS sales
FROM   customer
       INNER JOIN transactions
               ON transactions.customer_id = customer.customer_id
       INNER JOIN product
               ON product.product_id = transactions.product_id
WHERE  ship_mode = 'First Class'
GROUP  BY customer_name,
          region,
          category,
          order_date
HAVING Round(Sum(sales)) > 5000
ORDER  BY order_date; 


-- (2) Write a query to fetch the first name (string before whitespace) from the customer_name column of customer table.

SELECT DISTINCT(Split_part(customer_name, ' ', 1) ) AS first_name
FROM   customer
ORDER  BY first_name;


-- (3) Write a SQL query to find the nth highest sale from transactions table. 
-- Example: Find 4th highest sale from transactions table 

SELECT   transaction_id,
         sales
FROM     transactions
ORDER BY sales DESC OFFSET 3 LIMIT 1;


-- (4) Write a SQL query to count different types of ship_mode sorted in desc order

SELECT ship_mode,
       Count(*) AS count_of_shipping
FROM   transactions
GROUP  BY ship_mode
ORDER  BY count_of_shipping DESC;

-- Alternate solution using CASE statement

SELECT Sum(CASE ship_mode
             WHEN 'Standard Class' THEN 1
             ELSE 0
           END) AS Standard_Class,
       Sum(CASE ship_mode
             WHEN 'Second Class' THEN 1
             ELSE 0
           END) AS Second_Class,
       Sum(CASE ship_mode
             WHEN 'First Class' THEN 1
             ELSE 0
           END) AS First_Class,
       Sum(CASE ship_mode
             WHEN 'Same Day' THEN 1
             ELSE 0
           END) AS Same_Day
FROM   transactions;


-- (5) Find the names and ids of all the products that were ordered in 2019

SELECT product_id,
       product_name
FROM   product
WHERE  product_id IN (SELECT transactions.product_id
                      FROM   transactions
                      WHERE  order_date BETWEEN '2019-01-01' AND '2019-12-31')
ORDER  BY product_id;


-- (6) Find the order_id and sales that are greater than average sales

SELECT order_id,
       Round(sales, 2) AS sales
FROM   transactions
WHERE  sales > (SELECT Round(Avg(sales), 2)
                FROM   transactions)
ORDER  BY sales DESC;


-- (7) In the year 2020, various items were not delivered on time due to COVID. 
-- The company needs to track customer id, order id, product id, customer name, customer city,sub category, 
-- ship date and mode of shipping in category "technology".
-- Note: The company needs to query this information multiple times without having to write complex SQL query.

CREATE VIEW cust_info_2020
AS
  SELECT DISTINCT(customer_name),
                 customer.customer_id,
                 city,
                 order_id,
                 order_date,
                 ship_date,
                 ship_mode,
                 product.product_id,
                 sub_category
  FROM   customer
         inner join transactions
                 ON transactions.customer_id = customer.customer_id
         inner join product
                 ON product.product_id = transactions.product_id
  WHERE  category = 'Technology'
         AND order_date BETWEEN '2020-01-01' AND '2020-12-31'
  ORDER  BY order_date; 

SELECT * FROM cust_info_2020;


-- (8) The company wants to gift coupons worth 70% off for premium customers, 50% off for plus customers and 10% off for others. 
-- Find the customers and categorise them. Premium customers total spending > 10,000 and Plus customers between 5000 and 9999. 
-- The sales made by the company are purchases made by a customer.

SELECT customer_name,
       Round(Sum(sales)) AS customer_purchases,
       CASE
         WHEN (Sum(sales) > 10000) THEN 'Premium Customer'
         WHEN (Sum(sales) BETWEEN 5000 AND 9999) THEN 'Plus Customer'
         ELSE 'normal'
       END  AS customer_category
FROM   customer
       INNER JOIN transactions
               ON customer.customer_id = transactions.customer_id
GROUP  BY customer_name
ORDER BY Sum(sales) DESC;
