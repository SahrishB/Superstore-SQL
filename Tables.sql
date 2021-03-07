CREATE TABLE tmpx
  (
     transaction_id SERIAL PRIMARY KEY,
     order_id       VARCHAR (50),
     order_date     DATE,
     ship_date      DATE,
     ship_mode      VARCHAR (50),
     customer_id    VARCHAR (50),
     customer_name  VARCHAR (50),
     segment        VARCHAR (50),
     country        VARCHAR (50),
     city           VARCHAR (50),
     state          VARCHAR (50),
     postal_code    VARCHAR (50),
     region         VARCHAR (50),
     product_id     VARCHAR (50),
     category       VARCHAR (50),
     sub_category   VARCHAR (50),
     product_name   VARCHAR (500),
     sales          NUMERIC,
     quantity       INTEGER,
     discount       NUMERIC,
     profit         NUMERIC
  ); 


CREATE TABLE product
  (
     product_id     VARCHAR (300) PRIMARY KEY,
     product_name   VARCHAR (500),
     segment        VARCHAR (300),
     category       VARCHAR (300),
     sub_category   VARCHAR (300)
  );

CREATE TABLE customer
  (
     customer_id    VARCHAR (50) PRIMARY KEY,
     customer_name  VARCHAR (50),
     country        VARCHAR (50),
     city           VARCHAR (50),
     state          VARCHAR (50),
     postal_code    VARCHAR (50),
     region         VARCHAR (50)
  );

CREATE TABLE transactions
  (
     transaction_id SERIAL PRIMARY KEY,
     product_id     VARCHAR (50) REFERENCES product (product_id),
     customer_id    VARCHAR (50) REFERENCES customer (customer_id),
     order_id       VARCHAR (50),
     order_date     DATE,
     ship_date      DATE,
     ship_mode      VARCHAR (50),
     sales          NUMERIC,
     discount       NUMERIC,
     profit         NUMERIC,
     quantity       INTEGER
  ); 
  
