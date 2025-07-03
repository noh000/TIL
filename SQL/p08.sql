USE practice;

CREATE TABLE customers AS SELECT * FROM lecture.customers;
CREATE TABLE sales AS SELECT * FROM lecture.sales;
CREATE TABLE products AS SELECT * FROM lecture.products;

-- 스칼라 서브쿼리
-- 1. 성과가 좋은 주문들(평균 이상 매출)
SELECT AVG(total_amount) FROM sales;

SELECT * FROM sales
WHERE total_amount>=(SELECT AVG(total_amount) FROM sales)
ORDER BY total_amount;

-- 2. 총매출합이 가장 높은 지역의 모든 주문들 (GROUP BY)
-- 최고 매출 지역 (단, 1개여야 해)
SELECT region
FROM sales
GROUP BY region
ORDER BY sum(total_amount) DESC
LIMIT 1;

SELECT * FROM sales
WHERE region=(
  SELECT region
  FROM sales
  GROUP BY region
  ORDER BY SUM(total_amount) DESC
  LIMIT 1
);



-- 최고 매출 지역이 하나가 아닐 경우 (윈도우 함수 사용)
SELECT *
FROM sales
WHERE region IN (
  SELECT region
  FROM (
    SELECT region, 
           SUM(total_amount) AS total_sales,
           RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_sales
    FROM sales
    GROUP BY region
  ) AS ranked_regions
  WHERE rank_sales = 1
);



-- 벡터 서브쿼리
-- 1. 재고 부족(50개 미만) 제품의 매출 내역
SELECT *
FROM sales
WHERE product_name IN(
  SELECT product_name
  FROM products
  WHERE stock_quantity<50
);

-- 2. 상위 3개 매출 지역의 주문들
SELECT * FROM sales
WHERE region IN (
  SELECT region
  FROM sales
  GROUP BY region
  ORDER BY sum(total_amount) DESC
  LIMIT 3
);
-- GROUP BY 와 ORDER BY를 함께 사용한 서브쿼리를 IN (...) 안에 X
-- 특히 LIMIT이 있을 경우엔 서브쿼리는 정렬과 제한된 결과를 명확히 담아야 하기 때문에 서브쿼리로 감싸야 함

SELECT * 
FROM sales
WHERE region IN (
  SELECT region
  FROM (
    SELECT region
    FROM sales
    GROUP BY region
    ORDER BY SUM(total_amount) DESC
    LIMIT 3
  ) AS top_regions  --  'top_regions' 이라는 가상의 벡터 생성
);

-- 3. 상반기(24-01-01 ~ 24-06-30) 에 주문한 고객들의 하반기(0701~1231) 주문 내역 (BETWEEN)
SELECT * FROM sales
WHERE customer_id IN (
  SELECT DISTINCT customer_id
  FROM sales
  WHERE order_date BETWEEN '2024-01-01' AND '2024-06-30'
)
AND order_date BETWEEN '2024-07-01' AND '2024-12-31'
ORDER BY customer_id, order_date;