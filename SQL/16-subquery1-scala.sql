USE lecture;

-- 매출 평균보다 더 높은 금액을 주문한 판매데이터 보기
SELECT AVG(total_amount) FROM sales;  -- 매출 평균값
SELECT * FROM sales WHERE total_amount>=612862.7083;  -- 데이터가 바뀌면?

-- > 서브쿼리 (쿼리 안에 또 쿼리)
SELECT * FROM sales
WHERE total_amount>=(SELECT AVG(total_amount) FROM sales);

-- 서브쿼리를 쓰는 경우
-- 1. 메인 쿼리에 필요한 특정 단일값을 먼저 계산해야 할 때 (max/min/avg 등) --> 스칼라 서브쿼리
-- 2. (WHERE) 다른 테이블 기준으로 필터링할 때 (= 스칼라, IN 벡터)
-- 3. (SELECT) 연산 결과 붙일 때

-- 평균금액보다 더 높은 주문
SELECT
  product_name,
  total_amount,
  total_amount - (SELECT AVG(total_amount) FROM sales) AS 평균과의차이  -- 경우 1번, 서브쿼리를 써야 값이 고정됨
FROM sales
WHERE total_amount>=(SELECT AVG(total_amount) FROM sales);

-- 매출액이 가장 높은 주문
SELECT * FROM sales
ORDER BY total_amount DESC
LIMIT 1;  
-- 정렬 후 1개 추출 -> 데이터가 많으면 오래 걸림 + 결과값이 하나가 아니면?

SELECT * FROM sales
WHERE total_amount=(SELECT MAX(total_amount) FROM sales);

-- 가장 최근 주문일의 주문데이터
SELECT * FROM sales
WHERE order_date=(SELECT MAX(order_date) FROM sales);

-- 주문액수 평균과 가장 유사한 주문데이터 5개
-- 평균 유사값 -> 주문액수와 평균의 차액이 적은 주문데이터
SELECT *,
  ABS(total_amount - (SELECT AVG(total_amount) FROM sales)) AS 평균과의차액
FROM sales
ORDER BY 평균과의차액
LIMIT 5;