USE practice;

SELECT count(*) FROM sales
UNION
SELECT count(*) FROM customers;

-- 주문 거래액이 가장 높은 10건을 높은순으로 고객명, 상품명, 주문금액 
SELECT
  c.customer_name AS 고객명,
  s.product_name AS 상품명,
  s.total_amount AS 주문금액
FROM customers c
INNER JOIN sales s ON c.customer_id=s.customer_id
ORDER BY s.total_amount DESC
LIMIT 10;

-- 고객 유형별 [고객유형, 주문건수, 평균주문금액] 을 평균주문금액 높은순으로 정렬
SELECT
  c.customer_type AS 고객유형,
  count(s.id) AS 주문건수,
  avg(s.total_amount) AS 평균주문금액
FROM customers c
INNER JOIN sales s ON c.customer_id=s.customer_id
GROUP BY c.customer_type
ORDER BY 평균주문금액 DESC;

-- 문제1: 모든 고객(주문 x 포함)의 이름과 구매한 상품명 조회
SELECT
  c.customer_name AS 고객명,
  s.product_name AS 상품명
FROM customers c
LEFT JOIN sales s ON c.customer_id=s.customer_id
ORDER BY 고객명;

-- 문제 2: 고객 정보와 주문 정보를 모두 포함한 상세 조회
SELECT
  *
FROM sales s
INNER JOIN customers c ON c.customer_id=s.customer_id;

-- 문제 3: VIP 고객들의 구매 내역만 조회
SELECT
  *
FROM sales s
INNER JOIN customers c ON c.customer_id=s.customer_id
WHERE c.customer_type='VIP';

-- 문제 4: 건당 50만원 이상 주문한 기업 고객들
SELECT
  c.customer_name
FROM sales s
INNER JOIN customers c ON c.customer_id=s.customer_id
WHERE c.customer_type='기업' AND s.total_amount>=5*power(10, 5)
GROUP BY c.customer_name;

-- 문제 5: 2024년 하반기(7월~12월) 전자제품 구매 내역
SELECT
  *
FROM sales s
INNER JOIN customers c ON c.customer_id=s.customer_id
WHERE s.category='전자제품' AND s.order_date BETWEEN '2024-07-01' AND '2024-12-31';

-- 문제 6: 고객별 주문 통계 (INNER JOIN) [고객명, 유형, 주문횟수, 총구매, 평균구매, 최근주문일]
 SELECT
  c.customer_id AS ID,
  c.customer_name AS 고객명,
  c.customer_type AS 유형,
  COUNT(s.id) AS 주문횟수,
  SUM(s.total_amount) AS 총구매액,  
  AVG(s.total_amount) AS 평균구매액,
  MAX(s.order_date) AS 최근주문일
FROM customers c
INNER JOIN sales s ON c.customer_id=s.customer_id
GROUP BY c.customer_id, 고객명, 유형;

-- 문제 7: 모든 고객의 주문 통계 (LEFT JOIN) - 주문 없는 고객도 포함
SELECT
  c.customer_name AS 고객명,
  c.customer_type AS 유형,
  COUNT(s.id) AS 주문횟수,
  COALESCE(SUM(s.total_amount), 0) AS 총구매액,  
  COALESCE(AVG(s.total_amount), 0) AS 평균주문액,
  COALESCE(MAX(s.order_date), '주문없음') AS 최근주문일
FROM customers c
LEFT JOIN sales s ON c.customer_id=s.customer_id
GROUP BY 고객명, 유형;

-- 문제 8: 상품 카테고리별로 구매한 고객 유형 분석
SELECT
  s.category AS 카테고리,
  c.customer_type AS 고객유형,
  COUNT(s.id) AS 주문수,
  AVG(s.total_amount) AS 평균주문액
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY 카테고리, 고객유형
ORDER BY 카테고리;
 
-- 문제 9: 고객별 등급 분류
-- 활동등급(구매횟수) : [0(잠재고객) < 브론즈 < 3 <= 실버 < 5 <= 골드 < 10 <= 플래티넘]
-- 구매등급(구매총액) : [0(신규) < 일반 <= 10만 < 우수 <= 20만 < 최우수 < 50만 <= 로얄]
SELECT
  c.customer_name AS 고객명,
  c.customer_type AS 유형,
  coalesce(count(s.id), 0) AS 구매횟수,
  CASE
    WHEN count(s.id)=0 THEN '잠재고객'
    WHEN count(s.id)>= 10 THEN '플래티넘'
    WHEN count(s.id)>= 5 THEN '골드'
    WHEN count(s.id)>= 3 THEN '실버'
    ELSE '브론즈' 
  END AS 활동등급,
  coalesce(sum(s.total_amount), 0) AS 구매금액,
  CASE
    WHEN sum(s.total_amount) IS NULL THEN '신규'
    WHEN sum(s.total_amount)>=5*power(10, 5) THEN '로얄'
    WHEN sum(s.total_amount)>=2*power(10, 5) THEN '최우수'
    WHEN sum(s.total_amount)>=power(10, 5) THEN '우수'
    ELSE '일반'
  END AS 구매등급
FROM customers c
LEFT JOIN sales s ON c.customer_id=s.customer_id
GROUP BY 고객명, 유형;

-- 문제 10: 활성 고객 분석
-- 고객상태(최종구매일) [NULL(구매없음) | 활성고객 <= 30 < 관심고객 <= 90 관심고객 < 휴면고객]별로
-- 고객수, 총주문건수, 총매출액, 평균주문금액 분석

SELECT
  c.customer_id,
  c.customer_name,
  count(s.id) AS 총주문건수,
  coalesce(sum(s.total_amount), 0) AS 총매출액,
  coalesce(avg(s.total_amount), 0) AS 평균매출액,
  datediff('2024-12-31', max(s.order_date)) 
FROM customers c
LEFT JOIN sales s ON c.customer_id=s.customer_id
GROUP BY c.customer_id, c.customer_name;
