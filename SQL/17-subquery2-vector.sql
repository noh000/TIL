USE lecture;

-- Scala -> 한 개의 데이터
-- Vector -> 한 줄로 이루어진 데이터
-- Matrix -> 행과 열과 이루어진 데이터

-- 서브쿼리를 쓰는 경우
-- 1. 메인 쿼리에 필요한 특정 단일값을 먼저 계산해야 할 때 (max/min/avg 등) --> 스칼라 서브쿼리
-- 2. (WHERE) 다른 테이블 기준으로 필터링할 때 (= 스칼라, IN 벡터)
-- 3. (SELECT) 연산 결과 붙일 때

-- 모든 VIP의 id
SELECT customer_id FROM customers WHERE customer_type='VIP';
-- -> C001, C005, C010, C013, ...
-- -> 즉 Vector

-- 모든 VIP의 주문내역
SELECT *
FROM sales
WHERE customer_id IN (
  SELECT customer_id FROM customers
  WHERE customer_type='VIP'
)
ORDER BY total_amount DESC;

-- 전자제품을 구매한 고객들의 모든 주문
SELECT *
FROM sales
WHERE customer_id IN (
  SELECT DISTINCT customer_id
  FROM sales
  WHERE category='전자제품'
);

SELECT *
FROM sales
WHERE customer_id IN (
  SELECT customer_id
  FROM sales
  WHERE category='전자제품'
  GROUP BY customer_id  -- 중복 제거를 위해 GROUPING 연산을 쓰는 것은 비효율적
);