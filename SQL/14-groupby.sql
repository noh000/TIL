USE lecture;

-- GROUP BY = 엑셀 피벗테이블
-- pivot 기준축을 잡고 데이터를 재정렬

SELECT
	category AS 카테고리,
    count(*) AS 주문건수,
    sum(total_amount) AS 총매출,
    AVG(total_amount) AS 평균매출
FROM sales
GROUP BY category
ORDER BY 총매출 DESC;

-- 지역별 
SELECT
	region AS 지역,
    count(*) AS 주문건수,
    sum(total_amount) AS 매출액,
    count(DISTINCT customer_id) AS 고객수,
    count(*) / count(DISTINCT customer_id) AS 고객당주문건수,
    round(sum(total_amount) / count(DISTINCT customer_id)) AS 고객당평균매출액
FROM sales
GROUP BY region;

-- 다중 그룹핑
SELECT
	region AS 지역,
    category AS 카테고리,
    count(*) AS 주문건수,
    sum(total_amount) AS 총매출액,
    round(AVG(total_amount)) AS 평균매출액
FROM sales
GROUP BY region, category
ORDER BY 지역, 총매출액 DESC;

-- 영업사원
SELECT
	date_format(order_date, '%Y-%m') AS 기준월,
    sales_rep,
	count(*) AS 판매건수,
    sum(total_amount) AS 총판매액,
    round(sum(total_amount) / count(*)) AS 건당평균판매액
FROM sales
GROUP BY 기준월, sales_rep
ORDER BY 기준월, 총판매액 DESC;

-- MAU
SELECT 
	date_format(order_date, '%Y-%m') AS 월,
    count(*) AS 판매건수,
    sum(total_amount) AS 총판매액,
	count(DISTINCT customer_id) AS 월활성고객수
FROM sales
GROUP BY date_format(order_date, '%Y-%m');

-- 요일별
SELECT
	dayname(order_date),
    count(*) AS 주문건수,
    sum(total_amount) AS 총매출액,
    round(AVG(total_amount)) AS 평균매출액
FROM sales
GROUP BY dayofweek(order_date), dayname(order_date)
ORDER BY dayofweek(order_date);