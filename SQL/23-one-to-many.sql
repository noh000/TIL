USE lecture;

-- 테이블 관계
-- 일대다(1:N)

SELECT
  c.customer_id,
  c.customer_name,
  COUNT(s.id) AS 주문횟수,
  GROUP_CONCAT(s.product_name) AS 주문제품들 
FROM customers c
LEFT JOIN sales s ON c.customer_id=s.customer_id
GROUP BY c.customer_id, c.customer_name;