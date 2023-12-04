# Analyzing e-Commerce Business Performance with SQL

## Problems
Measuring business performance is crucial in a company to track, monitor, and assess the success or failure of various business processes. Therefore, this paper will analyze the business performance of an eCommerce company, taking into account several business metrics, namely customer growth, product quality, and payment methods.


## Data Preparation
**![](https://lh7-us.googleusercontent.com/IA02IGt5qhRCYTZ0fIs5X3dZQlbS4YBdw5puNbwJ3TO9MD-YzdSL0nMnz0ywCMC_mmkvar5sZ2FMsGfXkgx5uD-7Xbruwgi0Vb_mOLDQ0G_JSFy6fPY51w3SRQEZXUZR-UZ1hF0m4RORmhpb6p1ThUeLcA=s2048)**

*The geolocation file is too large, so I did not upload it here.*

1. **Database Creation**

   Database creation is performed using tools from pgAdmin 4 by creating a new database.

2. **Table Creation**

   Tables are created one by one, and data types are adjusted to the values of each column. This is done using queries.

3. **Dataset Import to Tables**

   Importing the dataset into tables.

   Dataset import to tables is done using queries. When importing, it's important to note that during table creation, columns that will be primary keys have been set, but upon checking, these columns might have duplicate data.

4. **Dataset Checking**

   Dataset checking is carried out to identify which columns serve as primary keys and foreign keys.

5. **Entity Relationship Diagram (ERD) Creation**

   ERD creation is done using tools from pgAdmin 4, where the existing tables have relationships with other tables.

6. **Downloading ERD as an Image**

   Downloading the ERD is done using tools from pgAdmin 

## Data Understanding

**![](https://lh7-us.googleusercontent.com/9uiGTsIxVKIZCLZ1Oms_mjeYBAAXilfnZe5WGbhVKPeeSPjsVUBoSbGN7uz9W9mv6cju1rmT5dkhq3Q_s2m-RTgWmfGn7ESy3E29V1sWREO2OKNspEVBYrV2dDkabNlZsv-Sl4xAbKCK_mhXoLfZvGSSpg=s2048)**

The analysis of annual customer activity growth in the E-commerce company can be seen in the table above. It can be observed that in the year 2016, during a total of 3 months of activity growth analysis, the customer activity was relatively small. The monthly active customers were only about 109, new customers (those making their first order) were 313, repeat order customers were only 3, and the average order frequency for each year was 1,009.

**The increase in customer activity from 2016 to 2017.**

**![](https://lh7-us.googleusercontent.com/Szv5bV0MNEF1-kp4tWpaNFlggYv8nscQxmrOJTJrp26A25P7hfBAoxTQoj1o03A5q1YtBInS0JWLVDg-dgXuCQxwyP6w9I9a7yhC8DiSzwx8gSw1PTyyew7kF3jFGpBHVnpLgdf9x8DuY83X2O4zbvB0QA=s2048)**

In 2017, with an analysis over 12 months, it can be seen that there was a significant increase compared to the previous year. In one month, monthly active customers experienced an increase of 3287%. New customers increased by 13255% from 2016. Customers who placed repeat orders increased by 41766% from 2016. And the average order frequency per customer for each year increased by 2.27%.

**The increase in customer activity from 2017 to 2018.**

**![](https://lh7-us.googleusercontent.com/Tqi_I4_uiUXas8Qksh4NUkBfOycsk_MhwvQBsGZmyGN49wZoTzvaQ01MQRQjkRAE71a0qSsFeLL6Sdr8EL9Cq762q9QyguV1qshNGjIiuegv8xgdgZz_ZKY1lY3dfgUXK8s1AQwohJeHOl2-pTdbmdpLNw=s2048)**

Annual Customer Activity Increase
**![](https://lh7-us.googleusercontent.com/gTyOryJe-yW7_w7yvKGE5Yy5YWO4Z3nbzYlGNkQKZo0j8cQN9zoL4f-b8VHqNIYMho-KpzQJj7qEcfYgYi3Vd2FV5BlE4n9VL2a7c74VYDR5uCp95-LiFXCMC3MYElwl56E5wdo8UxaItEgCULIOx8tYMw=s2048)**

**![](https://lh7-us.googleusercontent.com/wMNDCjEJqyyN7GSwVt7vL1x6fOdsHLAc9uzC9KVk_YW9cqTF1HaRDPTbG4-uLldes9OdB56Tx-4YGt_YqOEQIyNPYco5gqOilXAsUeehNY6lxEtylrIGr2NXfGmem_xLgez6juDAFlySD3zWAXSOURqAMg=s2048)**

From the data above, it can be seen that the year 2017 has a very high total revenue compared to 2016, with the largest product category being "bed_bath_table." However, in 2017, there is also a significant number of order cancellations. Meanwhile, in 2018, there is high total revenue, and the product category with the highest revenue is "health_beauty," which also has a considerable number of cancellations.

**![](https://lh7-us.googleusercontent.com/3tz4fKeuX6Vi1avINUaXRcS7mF-2iDMffikJlI0ZvyywiNmSx9_MK4-4Pf6U2ttB-7Osg0NkTIS1-KYj7Zz27d9S96Wtgfg2xe1zUwx70lQkq2k7jkBbX5EvpIMYWHQ3bof2VRr8zuTvIik8OTKq69H4kA=s2048)**

From the data on the side, it can be observed that in 2017, there is significantly higher total revenue compared to 2016, especially in the "bed_bath_table" category. In 2018, the total revenue increases again, with the highest in the "health_beauty" category, which also has a considerable number of cancellations. This information is crucial for improving company revenue based on the rising trend in that year.

**![](https://lh7-us.googleusercontent.com/ptQ5rz63nGinnF0rk_0zoQgo-jS3I3Xb0auKSydjQxlz8xAm_EDx3ECPZ7q829eOlnXes0S-nmKJM54A6u9bpVHskeauteN-ZU-8ZaVXdYpZqDB2qHT_N7QYgW2IBnKQTxPYQOndu5naYHS49Qq44fhHSw=s2048)**

Additionally, from the data on the side, it is evident that in 2017, there is a significantly higher total order cancellation compared to 2016, especially in the "sports_leisure" category. In 2018, total cancellations increase again, with the highest in the "health_beauty" category as well. This information is essential for reducing order cancellations and increasing company revenue.

**![](https://lh7-us.googleusercontent.com/COCoyP4f9jv4E4OcxQooGq-ladZxxtGHCoANUdcJBckAPvvkEFs9P2c1yGWsEOFnOjPyAl_er7lj6M8r70QV37nhFOt6e2pGu3pLzaRwTQ2E2LLQkNdSA2emTJXOiQZJ_X-z_q9YDYZg1nFBV0Y7K5UJ5A=s2048)**

The most widely used payment method is credit_card. However, there is an undefined payment method. Further investigation is needed to facilitate the smooth running of the business.

**![](https://lh7-us.googleusercontent.com/PONNwCZzsXI2kfCsujQTVVsd-esvuf5AGKlugK3ClR_Zo3SLA_50Co2yRrolk_vqrlhzN8WuJPtVv6qd3FFFQPqnzs1b-IUMr4XIpKDWU0Dtqjm1XtvE6b-oElktyEpw8I4bt1H_rSx9jxBeZDC6qKltKw=s2048 "Diagram")**

**![](https://lh7-us.googleusercontent.com/s4N4wwy1LmA7Ry3TIeyJr5AReGbjhT4nwKz-Z1QrrTOf3N9FGKo2nSA-vBb2NknLkxs9mpmsoGrR8KcOQFHhz9RDcMSOiJrmzKh2jeBReJuIDghGI5CJBe30nQ2xs3KE6ft8m_KvEp0ezn0HyfGpaaBZlw=s2048)**
  
The use of the credit card payment method is increasing every year. The use of boleto has seen a slight increase, while the use of vouchers has decreased. The use of debit cards is still relatively low, and there are three orders with undefined payment
