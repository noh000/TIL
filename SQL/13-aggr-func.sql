-- 집계 함수
USE lecture;
SELECT * FROM customers;
SELECT * FROM sales;

-- COUNT
SELECT count(*) AS 매출건수 FROM sales;

SELECT
	count(*) AS 총주문건수,
    -- 중복 제거(별개의)
    count(DISTINCT customer_id) AS 고객수,  
    count(DISTINCT product_name) AS 제품수
FROM sales;

-- SUM
SELECT
	format(sum(total_amount), 0) AS 총매출,
    sum(total_amount) AS 총매출액,
	sum(quantity) AS 총판매수량
FROM sales;

SELECT
	format(sum(total_amount), 0) AS 총매출액,
	format(sum(quantity), 2) AS 총판매수량
FROM sales;

SELECT
	SUM(IF(region='서울', total_amount, 0)) AS 서울매출,
    sum(
		IF(
			category='전자제품', total_amount, 0
            )
		) AS 전자매출
FROM sales;

-- AVG
SELECT
	AVG(total_amount) AS 평균매출액,
	AVG(quantity) AS 평균판매수량,
	round(AVG(unit_price)) AS 평균단가
FROM sales;

-- MIN / MAX
SELECT
	MIN(total_amount) AS 최소매출액,
	MAX(total_amount) AS 최대매출액,
    MIN(order_date) AS 첫주문일,
    MAX(order_date) AS 최근주문일
FROM sales;