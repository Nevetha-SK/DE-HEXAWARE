
--1. How many burgers were ordered?
-- Total number of burger rows (not distinct orders)
SELECT COUNT(*) AS total_burgers_ordered
FROM customer_orders;

--2. How many unique customer orders were made?
-- Unique customer orders = unique order_id from customer_orders
SELECT COUNT(DISTINCT order_id) AS unique_customer_orders
FROM customer_orders;

--3. How many successful orders were delivered by each runner?
-- Successful = pickup_time IS NOT NULL
SELECT runner_id, COUNT(*) AS successful_deliveries
FROM runner_orders
WHERE pickup_time IS NOT NULL
GROUP BY runner_id;

--4. How many of each type of burger was delivered?
-- Only include delivered orders (pickup_time IS NOT NULL)
SELECT bn.burger_name, COUNT(*) AS total_delivered
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
JOIN burger_names bn ON co.burger_id = bn.burger_id
WHERE ro.pickup_time IS NOT NULL
GROUP BY bn.burger_name;

--5. How many Vegetarian and Meatlovers were ordered by each customer?
--How many Vegetarian and Meatlovers were ordered by each customer?
SELECT 
  customer_id,
  SUM(CASE WHEN bn.burger_name = 'Vegetarian' THEN 1 ELSE 0 END) AS vegetarian_count,
  SUM(CASE WHEN bn.burger_name = 'Meatlovers' THEN 1 ELSE 0 END) AS meatlovers_count
FROM customer_orders co
JOIN burger_names bn ON co.burger_id = bn.burger_id
GROUP BY customer_id;

--6. What was the maximum number of burgers delivered in a single order?
-- Only include delivered orders
SELECT TOP 1 co.order_id, COUNT(*) AS burger_count
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE ro.pickup_time IS NOT NULL
GROUP BY co.order_id
ORDER BY burger_count DESC;

--7. For each customer, how many delivered burgers had at least 1 change and how many had no changes?
SELECT 
  customer_id,
  SUM(CASE 
      WHEN (exclusions IS NOT NULL AND exclusions <> '') 
         OR (extras IS NOT NULL AND extras <> '') 
      THEN 1 ELSE 0 END) AS with_changes,
  SUM(CASE 
      WHEN (exclusions IS NULL OR exclusions = '') 
         AND (extras IS NULL OR extras = '') 
      THEN 1 ELSE 0 END) AS no_changes
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE ro.pickup_time IS NOT NULL
GROUP BY customer_id;

--8. What was the total volume of burgers ordered for each
SELECT 
  DATEPART(HOUR, order_time) AS order_hour,
  COUNT(*) AS total_burgers
FROM customer_orders
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_hour;

--9. How many runners signed up for each 1-week period?
-- Group runners by registration week starting from Jan 1, 2021
SELECT 
  DATEPART(WEEK, registration_date) AS week_number,
  COUNT(*) AS runners_joined
FROM burger_runner
GROUP BY DATEPART(WEEK, registration_date)
ORDER BY week_number;

--10. What was the average distance travelled for each customer?
-- Convert distance to float after removing 'km' if present
SELECT 
  co.customer_id,
  AVG(CAST(REPLACE(ro.distance, 'km', '') AS FLOAT)) AS avg_distance_km
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE ro.distance IS NOT NULL AND ro.pickup_time IS NOT NULL
GROUP BY co.customer_id;




