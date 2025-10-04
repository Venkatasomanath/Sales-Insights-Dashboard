-- Create and populate sales database
CREATE DATABASE sales_insights;
USE sales_insights;

-- Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE,
    customer_segment VARCHAR(50)
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);

-- Sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    discount DECIMAL(5,2),
    payment_method VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data
INSERT INTO customers VALUES
(1, 'John Smith', 'North America', 'USA', '2022-01-15', 'Enterprise'),
(2, 'Maria Garcia', 'Europe', 'Spain', '2022-02-20', 'SMB'),
(3, 'David Johnson', 'North America', 'Canada', '2022-03-10', 'Enterprise'),
(4, 'Sarah Chen', 'Asia', 'Singapore', '2022-01-25', 'Startup'),
(5, 'Ahmed Hassan', 'Middle East', 'UAE', '2022-04-05', 'SMB');

INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 'Computers', 800.00, 1200.00),
(2, 'Office Suite', 'Software', 'Productivity', 50.00, 150.00),
(3, 'Smart Phone', 'Electronics', 'Mobile', 400.00, 699.00),
(4, 'Cloud Storage', 'Services', 'Cloud', 10.00, 25.00),
(5, 'Desk Chair', 'Furniture', 'Office', 75.00, 149.00);

INSERT INTO sales VALUES
(1, 1, 1, '2024-01-15', 2, 2400.00, 0.00, 'Credit Card'),
(2, 2, 2, '2024-01-20', 5, 750.00, 0.10, 'PayPal'),
(3, 3, 3, '2024-02-05', 1, 699.00, 0.05, 'Bank Transfer'),
(4, 1, 4, '2024-02-10', 10, 250.00, 0.00, 'Credit Card'),
(5, 4, 1, '2024-02-15', 1, 1200.00, 0.15, 'PayPal'),
(6, 5, 5, '2024-03-01', 3, 447.00, 0.00, 'Credit Card'),
(7, 2, 3, '2024-03-10', 2, 1398.00, 0.10, 'Bank Transfer'),
(8, 3, 2, '2024-03-15', 3, 450.00, 0.00, 'Credit Card');

-- Key queries for Power BI
SELECT 
    s.sale_date,
    c.customer_name,
    c.region,
    c.country,
    c.customer_segment,
    p.product_name,
    p.category,
    p.sub_category,
    s.quantity,
    s.total_amount,
    s.discount,
    s.payment_method,
    (p.selling_price - p.cost_price) * s.quantity as profit
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id;