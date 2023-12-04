-- No 1
WITH monthly_active_user AS (
    SELECT
        EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
        EXTRACT(MONTH FROM od.order_purchase_timestamp) AS month,
        COUNT(DISTINCT cd.customer_unique_id) AS mau_per_month
    FROM orders_dataset AS od
    LEFT JOIN customers_dataset AS cd ON od.customer_id = cd.customer_id
    GROUP BY year, month
),
total_month_per_year AS (
    SELECT
        year,
        COUNT(DISTINCT month) AS total_month
    FROM monthly_active_user
    GROUP BY year
)
SELECT 
    t.year,
	t.total_month,
    ROUND(SUM(ma.mau_per_month) / t.total_month) AS avg_mau_per_month
FROM monthly_active_user AS ma
JOIN total_month_per_year AS t ON ma.year = t.year
GROUP BY t.year, t.total_month 
ORDER BY t.year;

-- No 2
WITH first_order_per_customer AS (
    SELECT
        cd.customer_unique_id,
        MIN(EXTRACT(YEAR FROM od.order_purchase_timestamp)) AS year
    FROM customers_dataset AS cd
    INNER JOIN orders_dataset AS od ON cd.customer_id = od.customer_id
    GROUP BY cd.customer_unique_id
	HAVING COUNT(od.order_id) = 1
)
SELECT
    year,
    COUNT(customer_unique_id) AS total_new_customer
FROM first_order_per_customer
GROUP BY year
ORDER BY year;

-- No 3
WITH repeat_customers AS (
    SELECT
        cd.customer_unique_id,
        EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
        COUNT(od.order_id) AS total_orders
    FROM customers_dataset AS cd
    LEFT JOIN orders_dataset AS od ON cd.customer_id = od.customer_id
    GROUP BY cd.customer_unique_id, year
    HAVING COUNT(od.order_id) > 1
)
SELECT
    year,
    COUNT(DISTINCT customer_unique_id) AS total_repeat_customers
FROM repeat_customers
GROUP BY year
ORDER BY year;

-- No 4
WITH customer_order_frequencies AS (
    SELECT
        cd.customer_unique_id,
        EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
        COUNT(od.order_id) AS total_order
    FROM customers_dataset AS cd
    INNER JOIN orders_dataset AS od ON cd.customer_id = od.customer_id
    GROUP BY cd.customer_unique_id, year
)
SELECT 
	year,
    AVG(total_order) AS avg_order_count
FROM customer_order_frequencies
GROUP BY year
ORDER BY year;

-- No 5
WITH monthly_active_user AS (
  SELECT
    EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM od.order_purchase_timestamp) AS month,
    COUNT(DISTINCT cd.customer_unique_id) AS mau_per_month
  FROM orders_dataset AS od
  LEFT JOIN customers_dataset AS cd ON od.customer_id = cd.customer_id
  GROUP BY year, month
),
total_month_per_year AS (
  SELECT
    year,
    COUNT(DISTINCT month) AS total_month
  FROM (
    SELECT
      DISTINCT year,
      month
    FROM monthly_active_user
  ) AS t
  GROUP BY year
),
first_order_per_customer AS (
  SELECT
    cd.customer_unique_id,
    MIN(EXTRACT(YEAR FROM od.order_purchase_timestamp)) AS year
  FROM customers_dataset AS cd
  INNER JOIN orders_dataset AS od ON cd.customer_id = od.customer_id
  GROUP BY cd.customer_unique_id
  HAVING COUNT(od.order_id) = 1
),
repeat_customers AS (
  SELECT
    cd.customer_unique_id,
    EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
    COUNT(od.order_id) AS total_orders
  FROM customers_dataset AS cd
  LEFT JOIN orders_dataset AS od ON cd.customer_id = od.customer_id
  GROUP BY cd.customer_unique_id, year
  HAVING COUNT(od.order_id) > 1
),
customer_order_frequencies AS (
  SELECT
    cd.customer_unique_id,
    EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
    COUNT(od.order_id) AS total_order
  FROM customers_dataset AS cd
  INNER JOIN orders_dataset AS od ON cd.customer_id = od.customer_id
  GROUP BY cd.customer_unique_id, year
)
SELECT
  t.year,
  t.total_month,
  ROUND(SUM(ma.mau_per_month) / t.total_month) AS avg_mau_per_month,
  (
    SELECT COUNT(customer_unique_id)
    FROM first_order_per_customer AS fc
    WHERE fc.year = t.year
  ) AS total_new_customer,
  (
    SELECT COUNT(DISTINCT customer_unique_id)
    FROM repeat_customers AS rc
    WHERE rc.year = t.year
  ) AS total_repeat_customers,
  (
    SELECT AVG(cof.total_order)
    FROM customer_order_frequencies AS cof
    WHERE cof.year = t.year 
  ) AS avg_order_count
FROM monthly_active_user AS ma
JOIN total_month_per_year AS t ON ma.year = t.year
GROUP BY t.year, t.total_month
ORDER BY t.year;