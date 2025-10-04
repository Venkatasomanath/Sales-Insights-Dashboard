-- Key SQL Queries for Data Analysis

-- Monthly Revenue Trend
SELECT 
    YEAR(sale_date) as year,
    MONTH(sale_date) as month,
    SUM(total_amount) as monthly_revenue,
    COUNT(*) as total_orders
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

-- Top Performing Products
SELECT 
    p.product_name,
    p.category,
    SUM(s.quantity) as total_quantity,
    SUM(s.total_amount) as total_revenue,
    SUM(s.total_amount - (s.quantity * p.cost_price)) as total_profit
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC;

-- Customer Demographics Analysis
SELECT 
    c.region,
    c.customer_segment,
    COUNT(DISTINCT s.customer_id) as customer_count,
    SUM(s.total_amount) as total_revenue,
    AVG(s.total_amount) as avg_spend
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.region, c.customer_segment
ORDER BY total_revenue DESC;

-- Payment Method Analysis
SELECT 
    payment_method,
    COUNT(*) as transaction_count,
    SUM(total_amount) as total_amount,
    AVG(total_amount) as avg_transaction_value
FROM sales
GROUP BY payment_method
ORDER BY total_amount DESC;

-- Regional Performance
SELECT 
    c.region,
    c.country,
    SUM(s.total_amount) as total_revenue,
    COUNT(DISTINCT s.customer_id) as unique_customers,
    SUM(s.total_amount) / COUNT(DISTINCT s.customer_id) as revenue_per_customer
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.region, c.country
ORDER BY total_revenue DESC;