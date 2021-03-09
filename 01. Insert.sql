--->Inserted data through a CSV file in the tmpx table (temporary) and populated the product, customer, and transactions table data from tmpx table.

INSERT INTO product
SELECT product_id,
       product_name,
       segmen,
       category,
       sub_category
FROM   tmpx
GROUP  BY product_id;



INSERT INTO customer
SELECT customer_id,
       customer_name,
       country,
       city,
       state,
       postal_code,
       region
FROM   tmpx
GROUP  BY customer_id,
          customer_name,
          country
ORDER  BY customer_id;



INSERT INTO transactions
SELECT transaction_id,
       product_id,
       customer_id,
       order_id,
       order_date,
       ship_date,
       ship_mode,
       sales,
       discount,
       profit,
       quantity
FROM   tmpx
GROUP  BY transaction_id,
          product_id,
          customer_id,
          order_id,
          order_date,
          ship_date,
          ship_mode,
          sales,
          discount,
          profit,
          quantity; 
          
DROP TABLE tmpx;

