USE lecture;

-- 한 적 있는

SELECT
  c. customer_name
FROM customers c
WHERE EXISTS(
  SELECT 1 FROM sales s WHERE s.category= '전자제품' AND s.category='의류' AND s.total_amount>=5*power(10, 5)
);