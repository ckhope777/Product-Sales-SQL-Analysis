/*-- QUESTIONS RELATED TO CUSTOMERS. 
     [Q1] What is the distribution of customers across states?

SELECT 
      state, 
      COUNT(*) as no_of_customers
FROM customer_t
GROUP BY state
ORDER BY no_of_customers DESC;

-- EXPLANATION:	
-- The above code is to get the distributions of customers from all states, hence in order to get that I used * i.e. get every row and column then COUNT it 
-- as the number of customers then grouped by the state wise.
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

WITH feed_bucket AS
(
    SELECT 
	CASE 
			WHEN customer_feedback = 'Very Good' THEN 5
			WHEN customer_feedback = 'Good' THEN 4
            WHEN customer_feedback = 'Average' THEN 3
            WHEN customer_feedback = 'Poor' THEN 2
            WHEN customer_feedback = 'Very Poor' THEN 1
            ELSE 0
			END AS feedback_count,
            quarter_number
	FROM order_t 
) 
SELECT 
      quarter_number,
      AVG(feedback_count) avg_feedback
FROM feed_bucket
GROUP BY quarter_number
ORDER BY 1;

/* [Q3] Are customers getting more dissatisfied over time?      

WITH cust_feedback AS
(
	SELECT 
		quarter_number,
		SUM(CASE WHEN customer_feedback = 'Very Good' THEN 1 ELSE 0 END) AS very_good,
		SUM(CASE WHEN customer_feedback = 'Good'THEN 1 ELSE 0 END) AS good,
        SUM(CASE WHEN customer_feedback = 'Average' THEN 1 ELSE 0 END) AS average,
        SUM(CASE WHEN customer_feedback = 'Poor' THEN 1 ELSE 0 END) AS poor,
        SUM(CASE WHEN customer_feedback = 'VERY Poor' THEN 1 ELSE 0 END) AS very_poor,
		COUNT(customer_feedback) AS total_feedbacks
	FROM order_t
	GROUP BY quarter_number
)
SELECT quarter_number,
        (very_good/total_feedbacks)*100 perc_very_good,
        (good/total_feedbacks)*100 perc_good,
        (average/total_feedbacks)*100 perc_average,
        (poor/total_feedbacks)*100 perc_poor,
        (very_poor/total_feedbacks)*100 perc_very_poor
FROM cust_feedback
ORDER BY 1;

-- Explanation:
-- Got the sum of customers with different feedback category such as 'VERY GOOD' OR 'VERY POOR. After that divided each of these customers by total customers. Common Table Expression was used. 
-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

SELECT
      vehicle_maker,
      COUNT(distinct cust.customer_id) AS number_of_customers
FROM product_t pro 
	INNER JOIN order_t ord
	    ON pro.product_id = ord.product_id
	INNER JOIN customer_t cust
	    ON ord.customer_id = cust.customer_id
GROUP BY vehicle_maker
ORDER BY 2 desc
LIMIT 5;  

-- Explanation:
-- First total customers were counted. As 'product_id' is a primary key, it was used to inner join to form joined table  
-- Same was done for 'customer_id' and this is then grouped by vehicle brands(vehicle_maker).
-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

SELECT state, vehicle_maker FROM (
	SELECT
		  state,
		  vehicle_maker,
		  COUNT(DISTINCT cust.customer_id) AS no_of_cust,
		  RANK() OVER (PARTITION BY cust.state ORDER BY COUNT(DISTINCT cust.customer_id) DESC) AS rnk
FROM product_t pro 
	 INNER JOIN order_t ord
	    ON pro.product_id = ord.product_id
	INNER JOIN customer_t cust
	    ON ord.customer_id = cust.customer_id
	GROUP BY cust.state, pro.vehicle_maker) tbl
WHERE rnk = 1;

-- Explanation:
-- I used RANK() function to partition by state and then order it by customer_id, then inner join using 'product_id' and 'customer_id' 
-- to get joined table. At the end grouped it together by state and vehicle_maker.
-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

SELECT 
	  quarter_number, 
	  COUNT(order_id) as total_orders
FROM order_t
GROUP BY quarter_number
ORDER BY quarter_number ASC;

-- Explanation:
-- Count all the orders, then grouped and order by each quarter number.
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

WITH QoQ AS 
(
	SELECT
		  quarter_number,
		  SUM((vehicle_price * quantity) * (1 - discount / 100)) AS revenue
	FROM order_t
	GROUP BY quarter_number
)
SELECT
      quarter_number,
  	  revenue,
      LAG(revenue) OVER (ORDER BY quarter_number) AS previous_revenue,
      ROUND(((revenue - LAG(revenue) OVER (ORDER BY quarter_number)) / LAG(revenue) OVER (ORDER BY quarter_number)) * 100,2) AS qoq_perc_change
FROM QoQ; 

-- Explanation:
-- Calculated revenue considering 'vehicle_price', 'quantity' and ''discount'. Then using LAG() fuction I calculated revenue from previous quarter
-- Then calculated change in revenue by quarter over quarter.
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

SELECT  
      quarter_number,
	  SUM((vehicle_price * quantity) * (1 - discount / 100)) AS revenue,
      COUNT(order_id) AS total_orders
FROM order_t
GROUP BY quarter_number
ORDER BY 1;

-- Explanation:
-- Calulate the revenue and counted the total orders using COUNT() function.
-- Then grouped it by quarter_number and order it by quarter_number.
-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

SELECT 
     credit_card_type, 
     AVG(discount) AS average_discount
FROM order_t ord 
INNER JOIN customer_t cust
	ON ord.customer_id = cust.customer_id
GROUP BY credit_card_type
ORDER BY 2 DESC;

-- Explanation:
-- Calculated avg() of discount. Then using 'customer_id' to get joined table, and then grouped this data with credit_card_type. 
-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
	
SELECT 
      quarter_number, 
	  AVG(datediff(ship_date, order_date)) AS average_shipping_time
FROM order_t
GROUP BY quarter_number
ORDER BY 1;

-- Explanation:
-- Calculated avg() of date diference by using 'datediff' of 'ship_date' and 'order_date'. Then grouped the data by quarter number 
-- and order it by quarter number.




