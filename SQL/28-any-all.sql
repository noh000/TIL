USE lecture;

-- ANY 서브쿼리 결과 중 하나라도 조건을 만족하면 TRUE, 비교 연산자(=<>) 필요
-- cf) IN 특정 값이 목록 안에 있는지 (리스트/서브쿼리)
 
-- 1. VIP 고객들의 최소 주문액보다 높은 모든 주문
SELECT s.total_amount
  FROM sales s
  INNER JOIN customers c on s.customer_id = c.customer_id
  WHERE c.customer_type = 'VIP';

SELECT
  customer_id,
  product_name,
  total_amount,
  'VIP보다 구매금액 높은 일반고객' AS 구분
FROM sales
WHERE total_amount >= ANY(
  -- VIP들의 모든 주문 금액들 (Vector)
  SELECT s.total_amount
  FROM sales s
  INNER JOIN customers c on s.customer_id = c.customer_id
  WHERE c.customer_type = 'VIP'
) AND
customer_id NOT IN (SELECT customer_id FROM customers WHERE customer_type = 'VIP')
ORDER BY total_amount DESC;

-- 어떤 지역 평균 매출액보다라도 높은 주문들
SELECT
  region,
  product_name,
  total_amount
FROM sales s
WHERE total_amount >= ANY( 
  SELECT AVG(total_amount)
  FROM sales
  GROUP BY region
)
ORDER BY total_amount DESC;

-- ALL 서브쿼리 결과 모두가 만족해야 TRUE
-- 모든 부서의 평균연봉보다 더 높은 연봉을 받는 사람 (예시 - 실행 안됨)
SELECT * 
FROM employees
-- 서브쿼리 벡터의 모든 값보다 커야함
WHERE salary > ALL(
    -- 각 부서의 평균 연봉 Vector
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
);