-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


DROP TABLE IF EXISTS public.customers_dataset;

CREATE TABLE IF NOT EXISTS public.customers_dataset
(
    customer_id character varying(255) COLLATE pg_catalog."default" NOT NULL DEFAULT nextval('customers_dataset_customer_id_seq'::regclass),
    customer_unique_id character varying(255) COLLATE pg_catalog."default",
    customer_zip_code_prefix character varying(255) COLLATE pg_catalog."default",
    customer_city character varying(50) COLLATE pg_catalog."default",
    customer_state character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT customers_dataset_pkey PRIMARY KEY (customer_id)
);

DROP TABLE IF EXISTS public.geolocation_dataset;

CREATE TABLE IF NOT EXISTS public.geolocation_dataset
(
    geolocation_zip_code_prefix character varying(50) COLLATE pg_catalog."default",
    geolocation_lat numeric,
    geolocation_lng numeric,
    geolocation_city character varying(50) COLLATE pg_catalog."default",
    geolocation_state character varying(50) COLLATE pg_catalog."default"
);

DROP TABLE IF EXISTS public.order_items_dataset;

CREATE TABLE IF NOT EXISTS public.order_items_dataset
(
    order_id character varying(255) COLLATE pg_catalog."default",
    order_item_id character varying(50) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    seller_id character varying(255) COLLATE pg_catalog."default",
    shipping_limit_date date,
    price numeric,
    freight_value numeric
);

DROP TABLE IF EXISTS public.order_payments_dataset;

CREATE TABLE IF NOT EXISTS public.order_payments_dataset
(
    order_id character varying(255) COLLATE pg_catalog."default",
    payment_sequential character varying(10) COLLATE pg_catalog."default",
    payment_type character varying(50) COLLATE pg_catalog."default",
    payment_installments character varying(10) COLLATE pg_catalog."default",
    payment_value numeric
);

DROP TABLE IF EXISTS public.order_reviews_dataset;

CREATE TABLE IF NOT EXISTS public.order_reviews_dataset
(
    review_id character varying(255) COLLATE pg_catalog."default",
    order_id character varying(255) COLLATE pg_catalog."default",
    review_score integer,
    review_comment_title text COLLATE pg_catalog."default",
    review_comment_message text COLLATE pg_catalog."default",
    review_creation_date date,
    review_answer_timestamp date
);

DROP TABLE IF EXISTS public.orders_dataset;

CREATE TABLE IF NOT EXISTS public.orders_dataset
(
    order_id character varying(255) COLLATE pg_catalog."default",
    customer_id character varying(255) COLLATE pg_catalog."default",
    order_status character varying(50) COLLATE pg_catalog."default",
    order_purchase_timestamp date,
    order_approved_at date,
    order_delivered_carrier_date date,
    order_delivered_customer_date date,
    order_estimated_delivery_date date,
    CONSTRAINT order_id PRIMARY KEY (order_id)
);

DROP TABLE IF EXISTS public.product_dataset;

CREATE TABLE IF NOT EXISTS public.product_dataset
(
    product_id character varying(255) COLLATE pg_catalog."default",
    product_category_name character varying(100) COLLATE pg_catalog."default",
    product_name_lenght numeric,
    product_description_lenght numeric,
    product_photos_qty numeric,
    product_weight_g numeric,
    product_length_cm numeric,
    product_height_cm numeric,
    product_width_cm numeric,
    CONSTRAINT product_id PRIMARY KEY (product_id)
);

DROP TABLE IF EXISTS public.sellers_dataset;

CREATE TABLE IF NOT EXISTS public.sellers_dataset
(
    seller_id character varying(255) COLLATE pg_catalog."default",
    seller_zip_code_prefix character varying(10) COLLATE pg_catalog."default",
    seller_city character varying(50) COLLATE pg_catalog."default",
    seller_state character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT seller_id PRIMARY KEY (seller_id)
        INCLUDE(seller_id)
);

ALTER TABLE IF EXISTS public.customers_dataset
    ADD CONSTRAINT zip_code FOREIGN KEY (customer_zip_code_prefix)
    REFERENCES public.geolocation_dataset (geolocation_zip_code_prefix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.customers_dataset
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id)
    REFERENCES public.orders_dataset (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.geolocation_dataset
    ADD CONSTRAINT zip_code FOREIGN KEY (geolocation_zip_code_prefix)
    REFERENCES public.sellers_dataset (seller_zip_code_prefix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_items_dataset
    ADD CONSTRAINT seller_id FOREIGN KEY (seller_id)
    REFERENCES public.sellers_dataset (seller_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_payments_dataset
    ADD CONSTRAINT order_id FOREIGN KEY (order_id)
    REFERENCES public.orders_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_reviews_dataset
    ADD CONSTRAINT order_id FOREIGN KEY (order_id)
    REFERENCES public.orders_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders_dataset
    ADD CONSTRAINT order_id FOREIGN KEY (order_id)
    REFERENCES public.order_items_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.product_dataset
    ADD CONSTRAINT product_id FOREIGN KEY (product_id)
    REFERENCES public.order_items_dataset (product_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;