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

-- 6. Customers who placed any order
SELECT name 
FROM Customers 
WHERE customer_id IN (SELECT customer_id FROM Orders);

-- 7. Customers with any order over ₹700
SELECT name 
FROM Customers 
WHERE customer_id IN (
  SELECT customer_id FROM Orders WHERE amount > 700
);

-- 8. Customers whose total order amount > ₹1000
SELECT name 
FROM Customers 
WHERE customer_id IN (
  SELECT customer_id FROM Orders GROUP BY customer_id HAVING SUM(amount) > 1000
);

-- 9. Customers with no orders
SELECT name 
FROM Customers 
WHERE customer_id NOT IN (
  SELECT DISTINCT customer_id FROM Orders
);

-- 10. Customers who placed their highest order in Chennai
SELECT name 
FROM Customers 
WHERE city = 'Chennai' AND customer_id IN (
  SELECT customer_id 
  FROM Orders 
  WHERE amount = (SELECT MAX(amount) FROM Orders)
);

-- 11. Average total order amount per customer
SELECT AVG(total_spent) AS avg_spent
FROM (
  SELECT customer_id, SUM(amount) AS total_spent
  FROM Orders
  GROUP BY customer_id
) AS customer_totals;

-- 12. Top spender
SELECT name, total
FROM (
  SELECT customer_id, SUM(amount) AS total
  FROM Orders
  GROUP BY customer_id
) AS totals
JOIN Customers ON Customers.customer_id = totals.customer_id
ORDER BY total DESC
LIMIT 1;

-- 13. Customers who placed more than 1 order
SELECT name
FROM (
  SELECT customer_id, COUNT(*) AS order_count
  FROM Orders
  GROUP BY customer_id
  HAVING COUNT(*) > 1
) AS frequent_customers
JOIN Customers ON Customers.customer_id = frequent_customers.customer_id;

-- 14. Orders grouped and filtered from subquery
SELECT *
FROM (
  SELECT customer_id, COUNT(*) AS num_orders
  FROM Orders
  GROUP BY customer_id
) AS order_summary
WHERE num_orders >= 2;

-- 15. City-wise average order amount
SELECT city, AVG(total_amount) AS avg_city_order
FROM (
  SELECT C.city, SUM(O.amount) AS total_amount
  FROM Customers C
  JOIN Orders O ON C.customer_id = O.customer_id
  GROUP BY C.customer_id
) AS city_orders
GROUP BY city;

-- 16. Customers who placed at least one order over ₹400
SELECT name
FROM Customers C
WHERE EXISTS (
  SELECT 1
  FROM Orders O
  WHERE O.customer_id = C.customer_id AND O.amount > 400
);

-- 17. Customers from Chennai who placed any order
SELECT name
FROM Customers C
WHERE C.city = 'Chennai'
AND EXISTS (
  SELECT 1
  FROM Orders O
  WHERE O.customer_id = C.customer_id
);

-- 18. Customers whose total spent is exactly ₹800
SELECT name
FROM Customers
WHERE (
  SELECT SUM(amount)
  FROM Orders
  WHERE Orders.customer_id = Customers.customer_id
) = 800;

-- 19. Customers whose max order is ₹1000
SELECT name
FROM Customers
WHERE (
  SELECT MAX(amount)
  FROM Orders
  WHERE Orders.customer_id = Customers.customer_id
) = 1000;

-- 20. Customers with more than one order
SELECT name
FROM Customers C
WHERE EXISTS (
  SELECT 1
  FROM Orders O
  WHERE O.customer_id = C.customer_id
  GROUP BY O.customer_id
  HAVING COUNT(*) > 1
);
