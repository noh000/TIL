USE lecture;

SELECT
  *,
  -- 지루하고 현학적임
  (SELECT customer_name FROM customers c WHERE c.customer_id=s.customer_id) AS 주문고객이름,
  (SELECT customer_type FROM customers c WHERE c.customer_id=s.customer_id) AS 고객등급
FROM sales s;

-- JOIN
SELECT
  '1. 전체 고객수' AS 구분,
  COUNT(*) AS 행수,
  COUNT(*) AS 고객수
FROM customers
UNION

-- INNER JOIN 교집합 (양 테이블 모두 데이터가 있을 때)
SELECT
  '2. INNER JOIN' AS 구분,
  COUNT(*) AS 줄수,
  COUNT(DISTINCT c.customer_id) AS 고객수
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id

UNION
-- LELT JOIN 왼쪽 테이블(FROM)의 데이터는 다 가져옴 -> 구매내역이 없는 고객 데이터 포함(+5)
SELECT
  '3. LEFT JOIN' AS 구분,
  COUNT(*) AS 줄수,
  COUNT(DISTINCT c.customer_id) AS 고객수
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id;