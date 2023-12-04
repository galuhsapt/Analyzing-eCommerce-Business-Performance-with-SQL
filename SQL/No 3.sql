-- NO 1
SELECT 
	oi.price,
	oi.freight_value,
	op.payment_value
FROM order_items_dataset AS oi
JOIN order_payments_dataset AS op ON oi.order_id = op.order_id;
-- Disini diketahui bahwa price + freight_value = payment_value
CREATE TABLE orders_dataset_backup AS
SELECT * FROM orders_dataset;

UPDATE orders_dataset_backup
SET order_delivered_customer_date = order_estimated_delivery_date
WHERE order_delivered_customer_date IS NULL;

CREATE TABLE revenue_per_year AS (
SELECT
    year,
    SUM(payment_value) AS total_revenue
FROM (
    SELECT
        od.order_id,
        EXTRACT(YEAR FROM od.order_delivered_customer_date) AS year,
        od.order_status,
        op.payment_value
    FROM orders_dataset_backup AS od
    JOIN order_payments_dataset AS op ON od.order_id = op.order_id
    WHERE order_status IN ('delivered', 'shipped')
) AS combined_data
GROUP BY year
ORDER BY year
)

-- NO 2
CREATE TABLE cancelled_per_year AS (
    SELECT 
        EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
        order_status,
        COUNT(order_id) AS total_canceled
    FROM (
	SELECT *
	FROM orders_dataset
	) AS canceled_order
    WHERE order_status IN ('canceled')
    GROUP BY year, order_status
	ORDER BY year, order_status
)
-- NO 3
CREATE TABLE revenue_category_items AS
SELECT
    product_category_revenue,
    year,
    total_revenue_per_category
FROM (
    SELECT
        pd.product_category_name as product_category_revenue,
        EXTRACT(YEAR FROM od.order_delivered_customer_date) AS year,
        SUM(oi.price + oi.freight_value) AS total_revenue_per_category,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM od.order_delivered_customer_date) ORDER BY SUM(oi.price + oi.freight_value) DESC) AS category_rank
    FROM product_dataset AS pd
    INNER JOIN order_items_dataset AS oi ON pd.product_id = oi.product_id
    INNER JOIN orders_dataset_backup AS od ON oi.order_id = od.order_id
    WHERE od.order_status IN ('delivered', 'shipped')
    GROUP BY pd.product_category_name, year
) AS ranked_products
WHERE category_rank = 1;

--NO 4
CREATE TABLE top_canceled_categories AS
SELECT
    product_category_canceled,
    year,
    total_cancelled_orders
FROM (
    SELECT
        pd.product_category_name AS product_category_canceled,
        EXTRACT(YEAR FROM od.order_purchase_timestamp) AS year,
        COUNT(*) AS total_cancelled_orders,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM od.order_purchase_timestamp) ORDER BY COUNT(*) DESC) AS category_rank
    FROM product_dataset AS pd
    INNER JOIN order_items_dataset AS oi ON pd.product_id = oi.product_id
    INNER JOIN orders_dataset AS od ON oi.order_id = od.order_id
    WHERE od.order_status = 'canceled'
    GROUP BY pd.product_category_name, year
) AS canceled_product_rank
WHERE category_rank = 1;

-- NO 5
CREATE TABLE revenue_canceled AS (
SELECT 
	rp.year,
	rp.total_revenue,
	cp.total_canceled,
	rc.product_category_revenue,
	rc.total_revenue_per_category,
	tc.product_category_canceled,
    tc.total_cancelled_orders
FROM revenue_per_year AS rp
JOIN cancelled_per_year AS cp ON rp.year=cp.year
JOIN revenue_category_items AS rc ON rp.year=rc.year
JOIN top_canceled_categories AS tc ON rc.year=tc.year
)