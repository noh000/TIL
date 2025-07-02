USE lecture;

SELECT
	category,
  count(*) AS 주문건수,
  sum(total_amount) AS 총매출액
FROM sales
WHERE total_amount>=power(10, 7)  -- 원본 데이터에 필터링 후 GROUPING
GROUP BY category;

SELECT
	category,
  count(*) AS 주문건수,
  sum(total_amount) AS 총매출액
FROM sales
GROUP BY category
HAVING sum(total_amount)>=power(10, 7);  -- 피벗테이블에 필터 추가

-- 활성 지역 찾기 (주문건수>=20, 고객수>=15)
SELECT
	region AS 지역,
  count(*) AS 주문건수,
  count(DISTINCT customer_id) AS 고객수,
  sum(total_amount) AS 총매출액
FROM sales
GROUP BY 지역
HAVING 주문건수>=20 AND 고객수>=15;

-- 우수 영업사원
SELECT 
	sales_rep AS 영업사원,
  count(*) AS 판매건수,
  count(DISTINCT customer_id) AS 담당고객수,
  sum(total_amount) AS 총판매액,
  count(DISTINCT date_format(order_date, '%Y-%m')) AS 활동개월수,
  sum(total_amount) / count(DISTINCT date_format(order_date, '%Y-%m')) AS 월평균매출
FROM sales
GROUP BY 영업사원
HAVING 월평균매출>=5*power(10, 5)
ORDER BY 월평균매출 DESC;