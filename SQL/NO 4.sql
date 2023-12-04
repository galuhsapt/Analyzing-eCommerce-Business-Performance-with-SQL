-- NO 1
SELECT 
	payment_type, 
	COUNT(order_id) AS total_order 
FROM order_payments_dataset
GROUP BY payment_type
ORDER BY total_order DESC;

-- NO 2
SELECT
  payment_type,
  SUM(CASE WHEN year = 2016 THEN total ELSE 0 END) AS "2016",
  SUM(CASE WHEN year = 2017 THEN total ELSE 0 END) AS "2017",
  SUM(CASE WHEN year = 2018 THEN total ELSE 0 END) AS "2018",
  SUM(total) AS total_order
FROM (
  SELECT 
	EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
  	op.payment_type,
  	COUNT(op.payment_type) AS total
  FROM orders_dataset AS od
  JOIN order_payments_dataset AS op ON od.order_id = op.order_id
  GROUP BY year, payment_type
  ) AS payment
GROUP BY payment_type
ORDER BY total_order DESC;