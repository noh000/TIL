USE lecture;

-- Scala -> 한 개의 데이터
-- Vector -> 한 줄로 이루어진 데이터
-- Matrix -> 행과 열과 이루어진 데이터

-- 서브쿼리를 쓰는 경우
-- 1. 메인 쿼리에 필요한 특정 단일값을 먼저 계산해야 할 때 (max/min/avg 등) --> 스칼라 서브쿼리
-- 2. (WHERE) 다른 테이블 기준으로 필터링할 때 (= 스칼라, IN 벡터)
-- 3. (SELECT) 연산 결과 붙일 때

-- NEW 4. (FROM) 가상 테이블(Inline view)

-- 평균매출이 50만원 이상인 카테고리
SELECT
 s.category,
 avg(total_amount) AS 평균매출액
FROM sales s
GROUP BY s.category
HAVING 평균매출액 >= 5*power(10, 5);

SELECT *
FROM (
  SELECT 
    category,
  AVG(total_amount) AS 평균매출액
  FROM sales GROUP BY category
) AS cateogry_summary  -- ->뷰 이름 필수!!
WHERE 평균매출액 >= 5*power(10, 5);

-- category_suammry
-- ┌─────────────┬─────────────┐
-- │  category   │   평균매출액   │
-- ├─────────────┼─────────────┤
-- │  전자제품     │   890,000   │
-- │  의류        │   420,000   │
-- │  생활용품     │   650,000   │
-- │  식품        │   180,000   │
-- └─────────────┴─────────────┘
-- SELECT * FROM category_summary WHERE 평균매출액 > 5*power(10, 5)


-- 1. 카테고리별 매출 분석 후 필터링
-- 카테고리명, 주문건수, 총매출, 평균매출, 평균매출 [0 <= 저단가 < 400000 <= 중단가 < 800000 < 고단가]
SELECT
 category AS 카테고리,
 COUNT(id) AS 주문건수,
 SUM(total_amount) AS 총매출,
 AVG(total_amount) AS 평균매출,
 CASE
  WHEN AVG(total_amount) >= 8*power(10, 5) THEN '고단가'
  WHEN AVG(total_amount) >= 4*power(10, 5) THEN '중단가'
  ELSE '저단가'
END AS 단가구분
FROM sales
GROUP BY category;

-- AVG(s.total_amount) 계속 반복되는 데 계속 함수를 써야해? 다른데 저장해 두었다가 쓸 수는 없나? -> 인라인 뷰

SELECT
  카테고리, 주문건수, 총매출, 평균매출,
  CASE
    WHEN 평균매출 >= 8*power(10, 5) THEN '고단가'
    WHEN 평균매출 >= 4*power(10, 5) THEN '중단가'
    ELSE '저단가'
  END AS 단가구분
FROM (
  SELECT
    category AS 카테고리,
    COUNT(*) AS 주문건수,
    SUM(total_amount) AS 총매출,
    AVG(total_amount) AS 평균매출
  FROM sales
  GROUP BY category
) AS c_a;

-- 영업사원별 성과 등급 분류 [영업사원, 총매출액, 주문건수, 평균주문액, 매출등급, 주문등급]
-- 매출등급 - 총매출[0< C <= 백만 < B < 3백만 <= A < 5백만 <= S]
-- 주문등급 - 주문건수  [0 <= C < 15 <= B < 30 <= A]
-- ORDER BY 총매출액 DESC
  
SELECT
  영업사원, 총매출액, 주문건수, 평균주문액,
  CASE
   WHEN 총매출액 >= 5*POWER(10, 6) THEN 'S'
   WHEN 총매출액 >= 3*POWER(10, 6) THEN 'A'
   WHEN 총매출액 >= POWER(10, 6) THEN 'B'
   ELSE 'C'
  END AS 매출등급,
  CASE
    WHEN 주문건수 >= 25 THEN 'A'
    WHEN 주문건수 >= 15 THEN 'B'
    ELSE 'C'
  END AS 주문등급
FROM (
  SELECT
    sales_rep AS 영업사원, 
    SUM(total_amount) AS 총매출액,
    COUNT(id) AS 주문건수,
    AVG(total_amount) AS 평균주문액
  FROM sales
  GROUP BY sales_rep
) AS sales_rep_summary
ORDER BY 총매출액 DESC;