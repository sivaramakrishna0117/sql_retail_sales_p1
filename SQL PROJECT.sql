show databases;
CREATE DATABASE P1_retail_sales_db;
use P1_retail_sales_db;
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    age INT,
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT,
    gendet VARCHAR(10),
    category VARCHAR(35)
);

SELECT * FROM retail_sales
LIMIT 10;
SELECT 
    COUNT(*)
FROM
    retail_sales;
    
SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL;

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date IS NULL;
    
    -- DATA CLEANING
    
SELECT * FROM retail_sales
WHERE
transactions_id is null
or
sale_time IS NULL
or
gender IS NULL
or
category IS NULL
or
quantiy IS NULL
or
cogs IS NULL
or
total_sale IS NULL;


delete FROM  retail_sales
WHERE
transactions_id  IS NULL
or
sale_date IS NULL
or
sale_time IS NULL
or
gender IS NULL
or
category IS NULL
or
quantiy IS NULL
or
cogs IS NULL
or
total_sale IS NULL;

-- Data Exploration
-- How many sales we have?
SELECT  count(*) AS total_sales from retail_sales;

-- How many uniqu customers we have?
SELECT count(distinct customer_id) as total_sale FROM retail_sales;

SELECT distinct category from retail_sales;

-- Data Analysis & Business key problems & Answers
-- My analysis &findings
-- Q.1 write a sql query to retrieve all coiumns for sales made on '2022-11-05'
-- Q.2 WRITE A Sql query to retrieve all transactions where the category is 'clothing' and the quantity of the month of NOV-2022.
-- Q.3 Write a sql query to calculate the total sales (total_sale) for each category
-- Q.4 Write a sql query to find the average age of customers who purchased items from the 'Beauty' category
-- Q.5 Write a sql query to find all transactions where the total_sales is greater than  1000
-- Q.6 Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category
-- Q.7 Write a sql query to calculate the average sale for each month find out best selling month in each year.
-- Q.8 Write  a sql auery to find the top 5 customers based on the highest total sales
-- Q.9 Write of a sql query to find the number of unique customers who purchased items from each category
-- Q.10 Write a sql query  to create each shift and numbers of orders(Example morning <=12, Afternoon Between 12 &17, Evening >17)

-- Q.1 write a sql query to retrieve all coiumns for sales made on '2022-11-05'

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
  
-- Q.2 WRITE A Sql query to retrieve all transactions where the category is 'Clothing' and the quantity of the month of NOV-2022.
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND (sale_date, 'YYYY-MM') = '2022-11'
        AND quantiy >= 4;
      
 -- Q.3  Write a sql query to calculate the total sales (total_sale) for each category 
 SELECT  category,
 sum(total_sale) as net_sale,
 count(*) as total_order
 from  retail_sales
  GROUP BY 1;
  
 -- Q.4 Write a sql query to find the average age of customers who purchased items from the 'Beauty' category
 SELECT *
 from retail_sales
 WHERE category = 'Beauty';
 
 SELECT avg(age) as avg_age
from retail_sales
where category = 'Beauty';

-- Q.5 Write a sql query to find all transactions where the total_sales is greater than  1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

SELECT * FROM retail_sales
WHERE total_sale < 1000; 

-- < sign indicates less than

-- Q.6 Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT  
category,
gender,
count(*) as total_transactions
FROM retail_sales
group by category,gender
ORDER BY 1;

-- Q.7 Write a sql query to calculate the average sale for each month find out best selling month in each year.
 
 SELECT 
 extract(YEAR FROM sale_date) as year,
 extract(MONTH FROM sale_date) as month,
 AVG(total_sale) as avg_sale
 FROM retail_sales
 GROUP BY 1,2
 ORDER BY 1,2,3 desc;
 
 SELECT 
 EXTRACT(YEAR FROM sale_date) as year,
 EXTRACT(MONTH FROM sale_date) as month,
 AVG(total_sale) as avg_sale,
 RANK() OVER(partition by extract(YEAR FROM sale_date) order by avg(total_sale) DESC)
 FROM retail_sales
 GROUP BY 1,2;
 
-- Q.8 Write  a sql auery to find the top 5 customers based on the highest total sales
SELECT customer_id,
sum(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write of a sql query to find the number of unique customers who purchased items from each category
SELECT 
category,
COUNT(DISTINCT customer_id) as count_unique_customer_id
FROM retail_sales
GROUP BY category;

-- Q.10 Write a sql query  to create each shift and numbers of orders(Example morning <=12, Afternoon Between 12 &17, Evening >17)
SELECT *,
CASE 
WHEN extract(HOUR FROM sale_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
FROM retail_sales;

-- End of project
