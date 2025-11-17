-- Task 1
SELECT
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
GROUP BY c.id
ORDER BY total_spend DESC
LIMIT 5;

-- Task 2
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN products p ON p.id = oi.product_id
JOIN orders o ON o.id = oi.order_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Task 3
SELECT
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary AS employee_salary,
    dept.avg_salary AS department_average
FROM employees e
JOIN departments d ON d.id = e.department_id
JOIN (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept ON dept.department_id = e.department_id
WHERE e.salary > dept.avg_salary
ORDER BY d.name, e.salary DESC;

-- Task 4
SELECT
    c.city,
    COUNT(*) AS gold_customer_count
FROM customers c
WHERE c.loyalty_level = 'Gold'
GROUP BY c.city
ORDER BY gold_customer_count DESC, c.city;

-- Loyalty distribution by city (extension)
SELECT
    city,
    SUM(CASE WHEN loyalty_level = 'Gold' THEN 1 ELSE 0 END) AS gold_count,
    SUM(CASE WHEN loyalty_level = 'Silver' THEN 1 ELSE 0 END) AS silver_count,
    SUM(CASE WHEN loyalty_level = 'Bronze' THEN 1 ELSE 0 END) AS bronze_count
FROM customers
GROUP BY city
ORDER BY gold_count DESC, city;