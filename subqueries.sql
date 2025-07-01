-- 1. Subqueries in SELECT Clause

-- 1. Total amount spent by each customer
SELECT name,
  (SELECT SUM(amount) FROM Orders WHERE Orders.customer_id = Customers.customer_id) AS total_spent
FROM Customers;

-- 2. Number of orders placed by each customer
SELECT name,
  (SELECT COUNT(*) FROM Orders WHERE Orders.customer_id = Customers.customer_id) AS order_count
FROM Customers;

-- 3. Average order amount per customer
SELECT name,
  (SELECT AVG(amount) FROM Orders WHERE Orders.customer_id = Customers.customer_id) AS avg_order
FROM Customers;

-- 4. Highest order amount per customer
SELECT name,
  (SELECT MAX(amount) FROM Orders WHERE Orders.customer_id = Customers.customer_id) AS max_order
FROM Customers;

-- 5. Difference between customer’s max and min order
SELECT name,
  (SELECT MAX(amount) - MIN(amount) FROM Orders WHERE Orders.customer_id = Customers.customer_id) AS order_diff
FROM Customers;

--  2. Subqueries in WHERE Clause

-- 1. Customers who placed any order
SELECT name 
FROM Customers 
WHERE customer_id IN (SELECT customer_id FROM Orders);

-- 2. Customers with any order over ₹700
SELECT name 
FROM Customers 
WHERE customer_id IN (
  SELECT customer_id FROM Orders WHERE amount > 700
);

-- 3. Customers whose total order amount > ₹1000
SELECT name 
FROM Customers 
WHERE customer_id IN (
  SELECT customer_id FROM Orders GROUP BY customer_id HAVING SUM(amount) > 1000
);

-- 4. Customers with no orders
SELECT name 
FROM Customers 
WHERE customer_id NOT IN (
  SELECT DISTINCT customer_id FROM Orders
);

-- 5. Customers who placed their highest order in Chennai
SELECT name 
FROM Customers 
WHERE city = 'Chennai' AND customer_id IN (
  SELECT customer_id 
  FROM Orders 
  WHERE amount = (SELECT MAX(amount) FROM Orders)
);

-- 3. Subqueries in FROM Clause

-- 1. Average total order amount per customer
SELECT AVG(total_spent) AS avg_spent
FROM (
  SELECT customer_id, SUM(amount) AS total_spent
  FROM Orders
  GROUP BY customer_id
) AS customer_totals;

-- 2. Top spender
SELECT name, total
FROM (
  SELECT customer_id, SUM(amount) AS total
  FROM Orders
  GROUP BY customer_id
) AS totals
JOIN Customers ON Customers.customer_id = totals.customer_id
ORDER BY total DESC
LIMIT 1;

-- 3. Customers who placed more than 1 order
SELECT name
FROM (
  SELECT customer_id, COUNT(*) AS order_count
  FROM Orders
  GROUP BY customer_id
  HAVING COUNT(*) > 1
) AS frequent_customers
JOIN Customers ON Customers.customer_id = frequent_customers.customer_id;

-- 4. Orders grouped and filtered from subquery
SELECT *
FROM (
  SELECT customer_id, COUNT(*) AS num_orders
  FROM Orders
  GROUP BY customer_id
) AS order_summary
WHERE num_orders >= 2;

-- 5. City-wise average order amount
SELECT city, AVG(total_amount) AS avg_city_order
FROM (
  SELECT C.city, SUM(O.amount) AS total_amount
  FROM Customers C
  JOIN Orders O ON C.customer_id = O.customer_id
  GROUP BY C.customer_id
) AS city_orders
GROUP BY city;
